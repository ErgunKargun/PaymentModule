package com.pm.controller;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pm.dao.DebtDao;
import com.pm.dao.UserDao;
import com.pm.model.Debt;
import com.pm.session.SessionManager;

@Controller
public class DebtController {
	
	final Logger logger = LogManager.getLogger(DebtController.class);
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	DebtDao debtDao;
	
	@Autowired
	SessionManager sessionManager;

	@RequestMapping(value = "/user/debt/payment", method = RequestMethod.POST)
	public ModelAndView payment(@RequestParam("serial") String[] serial, HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("user/payment");
		
		if(!sessionManager.isAuthenticated(request))
			return new ModelAndView("redirect:/user");
		
		BigDecimal totalDebtAmount = new BigDecimal("0");
		for (String serialString : serial) {
			Debt debt =  debtDao.getDebtBySerialno(serialString);
			totalDebtAmount.add(debt.getBakiye());
		}
		
		System.out.println(serial);

		modelAndView.addObject("serial", serial);
		modelAndView.addObject("totalDebtAmount", totalDebtAmount);

		return modelAndView;
	}
}
