package com.pm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;

import com.pm.dao.DebtDao;
import com.pm.dao.UserDao;
import com.pm.model.Debt;
import com.pm.model.FileBucket;
import com.pm.model.User;
import com.pm.session.SessionManager;

@Controller
public class UserController {

	final Logger logger = LogManager.getLogger(UserController.class);

	@Autowired
	UserDao userDao;

	@Autowired
	DebtDao debtDao;

	@Autowired
	SessionManager sessionManager;	

	@RequestMapping(value = "/user/userpanel")
	public String userpanel(HttpServletRequest request, Model model) {
		if (!sessionManager.isAuthenticated(request))
			return "redirect:/user";

		User admin = userDao.getUserByTc(sessionManager.getLoggedUserId(request));

		List<User> userList = userDao.getAllUsersByAdminEmail(admin.getEmail());
		
		List<Debt> debtList = debtDao.getAllDebtsByTc(admin.getTc());

		model.addAttribute("admin", admin);
		model.addAttribute("userList", userList);
		model.addAttribute("debtList", debtList);
		
		model.addAttribute("formInsertNewUser", new User());
		model.addAttribute("formUpdateUser", new User());
		model.addAttribute("formUpdateAccount", new User());
		model.addAttribute("formInsertNewDebt", new Debt());
		model.addAttribute("formUpdateDebt", new Debt());
		model.addAttribute("formUpload", new FileBucket());
		
		model.addAttribute("msg", "Hoşgeldin " + admin.getName() + "!");
		model.addAttribute("css", "success");		

		return "user/userpanel";
	}

	@RequestMapping(value = "/user/datatable", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public  @ResponseBody String userDatatable(HttpServletRequest request) {
		List<Debt> debtList = debtDao.getAllDebtsByTc(sessionManager.getLoggedUserId(request));

		StringBuilder json = new StringBuilder("{ " + "\"sEcho\" : " + 3 + "," + "\"iTotalRecords\" : "
				+ debtList.size() + "," + "\"iTotalDisplayRecords \" : " + debtList.size() + "," + "\"aaData\": [");

		String str = "";
		for (Debt debt : debtList) {
			str = "{" 	
					+ "\"DT_RowId\" : " + "\"" + debt.getSerial() + "\"," 
					+ "\"Bilgi\" : " + "\"<button type='button' class='btn btn-info btn-sm'><span class='label label-info'><span class='glyphicon glyphicon-info-sign'></span></span></button>\"" + ","
					+ "\"Serial\" : " + "\"" + debt.getSerial() + "\","
					+ "\"Dönem\" : " + "\"" + debt.getDonem() + "\"," 
					+ "\"Parsel\" : " + "\"" + debt.getParsel() + "\"," 
					+ "\"Gelir Cinsi\" : " + "\"" + debt.getGelirCinsi() + "\","
					+ "\"Açıklama\" : " + "\"" + debt.getAciklama() + "\","
					+ "\"Tahakkuk\" : " + "\"" + debt.getTahakkuk() + "\","
					+ "\"Ödenen\" : " + "\"" + debt.getOdenen() + "\"," 
					+ "\"Bakiye\" : " + "\"" + debt.getBakiye() + "\"," 
					+ "\"Durum\" : " + "\"" + debt.getDurum() + "\"," 
					+ "\"Seç\" : " + "\"<label><input type='checkbox' data-serial='" + debt.getSerial()
					+ "' value='" + debt.getBakiye()
					+ "' onclick='handle(this);' /></label>\""
					+ "},";
			json.append(str);
		}
		if (debtList.size() > 0)
			json = new StringBuilder(json.substring(0, json.length() - 1));
		json.append("]}");

		return json.toString();
	}
}