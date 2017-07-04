package com.pm.controller;

import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pm.dao.DebtDao;
import com.pm.dao.UserDao;
import com.pm.json.response.JsonResponseObject;
import com.pm.mail.Mailer;
import com.pm.model.Debt;
import com.pm.model.User;
import com.pm.model.enums.Durum;
import com.pm.report.Reporter;
import com.pm.session.SessionManager;
import com.stripe.Stripe;
import com.stripe.exception.APIConnectionException;
import com.stripe.exception.APIException;
import com.stripe.exception.AuthenticationException;
import com.stripe.exception.CardException;
import com.stripe.exception.InvalidRequestException;
import com.stripe.model.Charge;

@Controller
public class DebtController {

	final Logger logger = LogManager.getLogger(DebtController.class);

	@Autowired
	UserDao userDao;

	@Autowired
	DebtDao debtDao;

	@Autowired
	SessionManager sessionManager;
	
	@Autowired
	Reporter reporter;
	
	@Autowired
	Mailer mailer;

	@RequestMapping(value = "/user/debt/payment", method = RequestMethod.POST)
	public @ResponseBody JsonResponseObject payment(@RequestParam("json") String json, HttpServletRequest request) throws AuthenticationException, InvalidRequestException, APIConnectionException, CardException, APIException {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);
		
		JSONObject jsonObject = new JSONObject(json);
				
//		String serialsAsString = (String) jsonObject.get("serials");
//		serialsAsString = serialsAsString.trim().substring(1, serialsAsString.trim().length()-1);		
//		String serialsUnformatted[] = serialsAsString.split(",");
//		String serials[] = new String[]{};
//		int index = 0;
//		for (String serialUnformatted : serialsUnformatted) {
//			String serial = serialUnformatted.substring(1, serialUnformatted.length()-1);
//			serials[index] = serial;
//			index++;
//		}
		
		String serials[] = jsonObject.getString("serials").substring(0, jsonObject.getString("serials").length()-1).split("&");
		
		BigDecimal totalDebtAmount = new BigDecimal("0");
		
		System.out.println(serials.length);
		for (String serial : serials) {
			System.out.println(serial);
			Debt debt =  debtDao.getDebtBySerialno(serial);
			totalDebtAmount = totalDebtAmount.add(debt.getBakiye());
			debt.setDurum(Durum.UNKNOWN);
			debtDao.update(debt);
		}				

		System.out.println("Total payment amount : " + totalDebtAmount);
		
		//stripe works - creating charges
		User user = userDao.getUserByTc(sessionManager.getLoggedUserId(request));
		Stripe.apiKey = userDao.getUserByEmail(user.getAdminEmail()).get(0).getStripe();
		
		String token = jsonObject.getString("token");

		// Charge the user's card:
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("amount", totalDebtAmount.multiply(new BigDecimal("100")).intValue());
		params.put("currency", "try");
		params.put("description", "Sulama birliği ödemesi");
		params.put("source", token);

		@SuppressWarnings("unused")
		Charge charge = Charge.create(params);

		for (String serial : serials) {
			Debt debt =  debtDao.getDebtBySerialno(serial);
			debt.setDurum(Durum.ODENDI);
			debtDao.update(debt);
		}				
		
		//send mail to user and admin who is responsible from him/her
		reporter.report(user.getTc(), serials);
		mailer.sendMail(user.getEmail(), "Sulama Fatura", "Faturanız", new File("E:/" + user.getTc() + "Fatura.pdf"));
		
		return new JsonResponseObject("SUCCESS", null);
	}
}
