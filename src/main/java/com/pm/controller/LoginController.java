package com.pm.controller;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

//import com.authy.AuthyApiClient;
//import com.authy.api.Token;
import com.pm.configuration.Config;
import com.pm.dao.DebtDao;
import com.pm.dao.UserDao;
import com.pm.session.SessionManager;
//import com.twilio.Twilio;
//import com.twilio.rest.api.v2010.account.Message;
//import com.twilio.type.PhoneNumber;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import net.maradit.api.Maradit;

@Controller
public class LoginController {
	
	final Logger logger = LogManager.getLogger(LoginController.class);

	@Autowired
	UserDao userDao;

	@Autowired
	DebtDao debtDao;
	
	@Autowired
	private Config config;

	@Autowired
	SessionManager sessionManager;

	//final AuthyApiClient authyApiClient = new AuthyApiClient(Config.auth_api_key);

	int randomCode;	   

	@RequestMapping(value = { "/", "/index" })
	public ModelAndView index() {
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/login");
		return model;
	}

	@RequestMapping(value = "/login")
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, HttpServletRequest request) {

		if (sessionManager.isAuthenticated(request))
			return new ModelAndView("redirect:/user");

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Geçersiz İsim veya Tc!");
		}

		if (logout != null) {
			sessionManager.logOut(request);
			model.addObject("msg", "Oturum Sonlandı. Yine bekleriz.");
		}
		model.setViewName("login");

		return model;
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
		System.out.println("LOGOUT");
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    return "redirect:/login?logout";
	}

	@RequestMapping(value = {"/user","/user**","/user/**"})
	public ModelAndView user(HttpServletRequest request, RedirectAttributes redirectAttributes) {

		// this user org.springframework.security.core.userdetails.User
		Authentication userSecure = SecurityContextHolder.getContext().getAuthentication();
		
		com.pm.model.User userModel = userDao.getUserByTc(userSecure.getName());
		
		sessionManager.partialLogIn(request, userModel.getTc());

		if (!sessionManager.isAuthenticated(request)) {

			/*
			 * com.authy.api.User userAuthy =
			 * authyApiClient.getUsers().createUser(userModel.getEmail(),
			 * "539-553-5700", userModel.getCountryCode().substring(1));
			 * 
			 * if (userAuthy.isOk()) {
			 * 
			 * // int authyId = userAuthy.getId(); //
			 * userModel.setAuthyId(authyId); userDao.update(userModel);
			 * 
			 * /* PhoneVerification phoneVerification =
			 * authyApiClient.getPhoneVerification(); Params params = new
			 * Params(); params.setAttribute("locale","en");
			 * phoneVerification.start("539-553-5700", "90", "sms", params);
			 */

			// authyApiClient.getUsers().requestSms(authyId);

			/*
			 * Map<String, String> options = new HashMap<String, String>();
			 * options.put("force", "true");
			 * authyApiClient.getUsers().requestSms(41089997,options);
			 * 
			 * }
			 */
			
			randomCode = 1000 + new SecureRandom().nextInt(9000);
			/*Twilio.init(Config.twilio_account_sid, Config.twilio_auth_token);
			Message.creator(new PhoneNumber(userModel.getCountryCode() + userModel.getPhoneNumber()),
					new PhoneNumber(Config.getTwilio_phone_number()), String.valueOf(randomCode)).create();*/
						
			List<String> to = new ArrayList<String>();
	        to.add(userModel.getCountryCode() + userModel.getPhoneNumber());
	        new Maradit(config.SMSEXPLORER_USERNAME,config.SMSEXPLORER_PASSWORD).submit(to, String.valueOf(randomCode));

			ModelAndView mav = new ModelAndView("redirect:/user/verifycode");
			redirectAttributes.addFlashAttribute("msg", userModel.getCountryCode() + " (***) *** "
					+ userModel.getPhoneNumber().substring(6) + " numaralı telefonunuza gönderilen kodu girin!");
			return mav;
		}

		return new ModelAndView("redirect:/user/userpanel");
	}

	@RequestMapping(value = "/user/verifycode", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView verifycode(HttpServletRequest request, RedirectAttributes redirectAttributes) {

		if (!sessionManager.isPartiallyAuthenticated(request))
			return new ModelAndView("redirect:/user");

		if (!sessionManager.isAuthenticated(request)) {
			String code = request.getParameter("code");

			if (code != null)
				if (!code.isEmpty()) {
					// it means user tc
					String userId = sessionManager.getLoggedUserId(request);
					// com.pm.model.User userModel =
					// userDao.getUserByTc(userId);

					// Token token =
					// authyApiClient.getTokens().verify(userModel.getAuthyId(),
					// code);
					// if (token.isOk()) {
					if (String.valueOf(randomCode).equals(code)) {
						sessionManager.logIn(request, userId);
						return new ModelAndView("redirect:/user");
					} else {
						ModelAndView mav = new ModelAndView("user/verifycode");
						mav.addObject("codeError", "Yanlış kod, tekrar deneyebilirsin!");
						return mav;
					}
				} else
					return new ModelAndView("user/verifycode");
			else
				return new ModelAndView("user/verifycode");
		} else
			return new ModelAndView("redirect:/user");

		// unreachable code...
		// return new ModelAndView("redirect:/user/verifycodecheck");
	}

	// for 403 access denied page
	@RequestMapping(value = "/403")
	public ModelAndView accesssDenied() {
		
		ModelAndView model = new ModelAndView();

		if (SecurityContextHolder.getContext().getAuthentication() != null) {
			model.addObject("msg", "Hi " + SecurityContextHolder.getContext().getAuthentication().getAuthorities() + ", you do not have permission to access this page!");
		} else {
			model.addObject("msg", "You do not have permission to access this page!");
		}

		model.setViewName("403");
		return model;

	}
}
