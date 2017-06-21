package com.pm.controller;

import java.io.File;
import java.io.IOException;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.ModelAndView;

import com.pm.configuration.Config;
import com.pm.dao.DebtDao;
import com.pm.dao.FileDao;
import com.pm.dao.RoleDao;
import com.pm.dao.UserDao;
import com.pm.json.response.JsonResponseObject;
import com.pm.model.Debt;
import com.pm.model.FileBucket;
import com.pm.model.Role;
import com.pm.model.User;
import com.pm.model.compositekey.RoleCompositeKey;
import com.pm.model.enums.Durum;
import com.pm.session.SessionManager;
import com.pm.validator.FileValidator;

@Controller
public class AdminController {

	final Logger logger = LogManager.getLogger(AdminController.class);

	@Autowired
	UserDao userDao;

	@Autowired
	DebtDao debtDao;

	@Autowired
	FileDao fileDao;

	@Autowired
	RoleDao roleDao;

	@Autowired
	private Config config;

	@Autowired
	SessionManager sessionManager;

	@Autowired
	FileValidator fileValidator;

	@Autowired
	private MessageSource messageSource;

	@RequestMapping(value = "/admin/delete/debt/{serial}", method = RequestMethod.DELETE)
	public @ResponseBody JsonResponseObject DeleteDebt(HttpServletRequest request,
			@PathVariable("serial") String serial) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		Debt deletedDebt = debtDao.getDebtBySerialno(serial);
		debtDao.delete(deletedDebt);

		return new JsonResponseObject("SUCCESS", null);
	}

	@RequestMapping(value = "/admin/delete/user/{tc}", method = RequestMethod.DELETE)
	public @ResponseBody JsonResponseObject deleteUser(HttpServletRequest request, @PathVariable("tc") String tc) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		User user = userDao.getUserByTc(tc);

		deleteEverythingBelongsToUser(user);

		return new JsonResponseObject("SUCCESS", null);
	}

	private void deleteEverythingBelongsToUser(User user) {
		List<User> userList = userDao.getAllUsersByAdminEmail(user.getEmail());
		for (User userI : userList)
			deleteEverythingBelongsToUser(userI);

		List<com.pm.model.File> fileList = fileDao.getAllFilesOfUserByAdminEmail(user.getEmail());
		for (com.pm.model.File file : fileList)
			fileDao.delete(file);

		List<com.pm.model.Debt> debtList = debtDao.getAllDebtsByTc(user.getTc());
		for (Debt debt : debtList)
			debtDao.delete(debt);

		List<Role> roleList = roleDao.getAllRolesOfUserByTc(user.getTc());
		for (Role role : roleList)
			roleDao.delete(role);

		userDao.delete(user);
	}

	@RequestMapping(value = "/admin/update/debt/{serial}", method = RequestMethod.POST)
	public @ResponseBody JsonResponseObject updateDebt(HttpServletRequest request,
			@PathVariable("serial") String serial, @ModelAttribute("formUpdateDebt") @Valid Debt updatedDebt,
			BindingResult bindingResult) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		if (bindingResult.hasErrors())
			return new JsonResponseObject("ERROR", errorMessageList(bindingResult.getAllErrors()));

		updatedDebt.setTc(debtDao.getDebtBySerialno(serial).getTc());
		updatedDebt.setBakiye(updatedDebt.getTahakkuk().subtract(updatedDebt.getOdenen()));
		debtDao.update(updatedDebt);

		return new JsonResponseObject("SUCCESS", null);
	}

	@RequestMapping(value = "/admin/update/user/{tc}", method = RequestMethod.POST)
	public @ResponseBody JsonResponseObject updateUser(HttpServletRequest request, @PathVariable("tc") String tc,
			@ModelAttribute("formUpdateUser") @Valid User updatedUser, BindingResult bindingResult) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		if (bindingResult.hasErrors())
			return new JsonResponseObject("ERROR", errorMessageList(bindingResult.getAllErrors()));

		User user = userDao.getUserByTc(tc);

		List<User> userList = userDao.getAllUsersByAdminEmail(user.getEmail());
		if (userList != null)
			for (User userI : userList) {
				userI.setAdminEmail(updatedUser.getEmail());
				userDao.update(userI);
			}
		List<com.pm.model.File> fileList = fileDao.getAllFilesOfUserByAdminEmail(user.getEmail());
		for (com.pm.model.File file : fileList) {
			file.setAdminEmail(updatedUser.getEmail());
			fileDao.update(file);
		}

		updatedUser.setUpdated(new Date());
		userDao.update(updatedUser);

		return new JsonResponseObject("SUCCESS", null);
	}

	@RequestMapping(value = "/admin/insert/debt/{tc}", method = RequestMethod.POST)
	public @ResponseBody JsonResponseObject insertNewDebt(HttpServletRequest request, @PathVariable("tc") String tc,
			@ModelAttribute("formInsertNewDebt") @Valid Debt insertedDebt, BindingResult bindingResult) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		if (bindingResult.hasErrors())
			return new JsonResponseObject("ERROR", errorMessageList(bindingResult.getAllErrors()));

		insertedDebt.setTc(tc);
		System.out.println("InsertedDEBT " + tc);
		insertedDebt.setBakiye(insertedDebt.getTahakkuk().subtract(insertedDebt.getOdenen()));
		insertedDebt.setDurum(Durum.ODENMEDI);
		debtDao.insert(insertedDebt);

		return new JsonResponseObject("SUCCESS", insertedDebt);
	}

	@RequestMapping(value = "/admin/insert/user", method = RequestMethod.POST)
	public @ResponseBody JsonResponseObject insertNewUser(HttpServletRequest request,
			@ModelAttribute("formInsertNewUser") @Valid User insertedUser, BindingResult bindingResult) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		if (bindingResult.hasErrors())
			return new JsonResponseObject("ERROR", errorMessageList(bindingResult.getAllErrors()));

		User admin = (User) userDao.getUserByTc(sessionManager.getLoggedUserId(request));

		insertedUser.setAdminEmail(admin.getEmail());
		insertedUser.setCreated(null);
		insertedUser.setUpdated(null);
		userDao.insert(insertedUser);

		String roleString = "ROLE_USER";
		for (Role role : roleDao.getAllRolesOfUserByTc(sessionManager.getLoggedUserId(request))) {
			if (role.getRoleCompositeKey().getRole().equals("ROLE_AGA"))
				roleString = "ROLE_ADMIN";
			break;
		}
		
		Role roleOfInsertedUser = new Role(new RoleCompositeKey(insertedUser.getTc(), roleString));
		roleDao.insert(roleOfInsertedUser);

		return new JsonResponseObject("SUCCESS", null);
	}

	@RequestMapping(value = "/admin/update/account", method = RequestMethod.POST)
	public @ResponseBody JsonResponseObject updateAccount(HttpServletRequest request,
			@ModelAttribute("formUpdateAccount") @Valid User updatedAdmin, BindingResult bindingResult) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		if (bindingResult.hasErrors())
			return new JsonResponseObject("ERROR", errorMessageList(bindingResult.getAllErrors()));

		User admin = (User) userDao.getUserByTc(sessionManager.getLoggedUserId(request));

		List<User> userList = userDao.getAllUsersByAdminEmail(admin.getEmail());
		for (User user : userList) {
			user.setAdminEmail(updatedAdmin.getEmail());
			userDao.update(user);
		}
		List<com.pm.model.File> fileList = fileDao.getAllFilesOfUserByAdminEmail(admin.getEmail());
		for (com.pm.model.File file : fileList) {
			file.setAdminEmail(updatedAdmin.getEmail());
			fileDao.update(file);
		}

		updatedAdmin.setUpdated(new Date());
		userDao.update(updatedAdmin);

		return new JsonResponseObject("SUCCESS", null);
	}

	@RequestMapping(value = "/admin/datatable", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public @ResponseBody String adminDatatable(HttpServletRequest request) {

		User admin = (User) userDao.getUserByTc(sessionManager.getLoggedUserId(request));
		List<User> userList = userDao.getAllUsersByAdminEmail(admin.getEmail());

		StringBuilder json = new StringBuilder("{ " + "\"sEcho\" : " + 3 + "," + "\"iTotalRecords\" : "
				+ userList.size() + "," + "\"iTotalDisplayRecords \" : " + userList.size() + "," + "\"aaData\": [");
		
		String str = "";
		for (User user : userList) {
			str = "{"
					+ "\"DT_RowId\" : " + "\"" + user.getTc() + "\","
					+ "\"Bilgi\" : " + "\"<button type='button' class='btn btn-info btn-sm'><span class='label label-info'><span class='glyphicon glyphicon-info-sign'></span></span></button>\"" + "," 
					+ "\"Tc\" : " + "\"" + user.getTc() + "\"," 
					+ "\"Adı\" : " + "\"" + user.getName() + "\"," 
					+ "\"Soyadı\" : " + "\"" + user.getSurname() + "\"," 
					+ "\"Email\" : " + "\"" + user.getEmail() + "\"," 
					+ "\"Telefon\" : " + "\"" + user.getPhoneNumber() + "\","
					+ "\"Admin Email\" : " + "\"" + user.getAdminEmail() + "\","
					+ "\"Güncelle\" : " + "\""
					+ "<button data-toggle='modal' data-target='#modalUpdateUser' data-id='" + user.getTc()
					+ "' data-href='" + request.getContextPath() + "/admin/update/user/" + user.getTc()
					+ "' data-tc='" + user.getTc()
					+ "' data-name='" + user.getName()
					+ "' data-surname='" + user.getSurname()
					+ "' data-email='" + user.getEmail()
					+ "' data-phone-number='" + user.getPhoneNumber()
					+ "' class='btn btn-primary buttonUpdateUser'> <i class='fa fa-edit'></i></button>\","
					+ "\"Sil\" : " + "\"<button data-toggle='modal' data-target='#modalDelete' " 
					+ "' data-href='" + request.getContextPath() + "/admin/delete/user/" + user.getTc()
					+ "' data-id='" + user.getTc() + "' " 
					+ "data-object='Tc si" + user.getTc() + " olan kullanıcı' "
					+ "class='btn btn-danger buttonDeleteUser'>" + "<i class='fa fa-remove'></i></button>\","
					+ "\"Git\" : " + "\"<button " 
					+ " data-href='" + request.getContextPath() + "/admin/workspace/" + user.getTc()
					+ "' data-tc='" + user.getTc() + "' " 					
					+ "class='btn btn-info toAdminWorkspace'>"
					+ "<span class='badge pull-right'><span class='glyphicon glyphicon-arrow-right'></span></span></button></td>\"" + "},";
			json.append(str);
		}
		if (userList.size() > 0)
			json = new StringBuilder(json.substring(0, json.length() - 1));
		json.append("]}");
		
		System.out.println(json);
		return json.toString();
	}

	@RequestMapping(value = "/admin/workspace/{tc}", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public @ResponseBody String adminWorkspace(@PathVariable("tc") String tc, HttpServletRequest request) {

		List<Debt> debtList = debtDao.getAllDebtsByTc(tc);

		StringBuilder json = new StringBuilder("{ " + "\"sEcho\" : " + 3 + "," + "\"iTotalRecords\" : "
				+ debtList.size() + "," + "\"iTotalDisplayRecords \" : " + debtList.size() + "," + "\"aaData\": [");

		String str = "";
		for (Debt debt : debtList) {
			str = "{" + "\"DT_RowId\" : " + "\"" + debt.getSerial() + "\"," + "\"Bilgi\" : "
					+ "\"<button type='button' class='btn btn-info btn-sm'><span class='label label-info'><span class='glyphicon glyphicon-info-sign'></span></span></button>\""
					+ "," + "\"Serial\" : " + "\"" + debt.getSerial() + "\"," + "\"Dönem\" : " + "\"" + debt.getDonem()
					+ "\"," + "\"Parsel\" : " + "\"" + debt.getParsel() + "\"," + "\"Gelir Cinsi\" : " + "\""
					+ debt.getGelirCinsi() + "\"," + "\"Açıklama\" : " + "\"" + debt.getAciklama() + "\","
					+ "\"Tahakkuk\" : " + "\"" + debt.getTahakkuk() + "\"," + "\"Ödenen\" : " + "\"" + debt.getOdenen()
					+ "\"," + "\"Bakiye\" : " + "\"" + debt.getBakiye() + "\"," + "\"Durum\" : " + "\""
					+ debt.getDurum() + "\"," + "\"Güncelle\" : " + "\""
					+ "<button data-toggle='modal' data-target='#modalUpdateDebt' data-serial='" + debt.getSerial()
					+ "' data-href='" + request.getContextPath() + "/admin/update/debt/" + debt.getSerial()
					+ "' data-donem='" + debt.getDonem() + "' data-parsel='" + debt.getParsel() + "' data-gelir-cinsi='"
					+ debt.getGelirCinsi() + "' data-aciklama='" + debt.getAciklama() + "' data-tahakkuk='"
					+ debt.getTahakkuk() + "' data-odenen='" + debt.getOdenen() + "' data-durum='" + debt.getDurum()
					+ "' class='btn btn-primary buttonUpdateDebt'> <i class='fa fa-edit'></i></button>\","
					+ "\"Sil\" : " + "\"<button data-toggle='modal' data-target='#modalDelete' " 
					+ "' data-href='" + request.getContextPath() + "/admin/delete/debt/" + debt.getSerial()
					+ "' data-id='" + debt.getSerial() + "' " 
					+ "data-object='" + debt.getSerial() + " seri numaralı tahakkuk' "
					+ "class='btn btn-danger buttonDeleteDebt'>" + "<i class='fa fa-remove'></i></button>\"" + "},";
			json.append(str);
		}
		if (debtList.size() > 0)
			json = new StringBuilder(json.substring(0, json.length() - 1));
		json.append("]}");

		return json.toString();
	}

	@RequestMapping(value = "/admin/upload", method = RequestMethod.POST)
	public @ResponseBody JsonResponseObject uploadFile(HttpServletRequest request,
			@ModelAttribute("fileUpload") FileBucket fileBucket, BindingResult bindingResult) {

		if (!sessionManager.isAuthenticated(request))
			return new JsonResponseObject("REDIRECT", null);

		fileValidator.validate(fileBucket, bindingResult);

		if (bindingResult.hasErrors())
			return new JsonResponseObject("ERROR", errorMessageList(bindingResult.getAllErrors()));

		MultipartFile multipartFile = fileBucket.getMultipartFile();

		File liveFile = new File(
				config.FILEMONITOR_PARENT_DIR + File.separator + sessionManager.getLoggedUserId(request) + "_"
						+ new Date().toString().replaceAll(":", "_") + "_" + multipartFile.getOriginalFilename());
		try {
			liveFile.createNewFile();
			FileCopyUtils.copy(multipartFile.getBytes(), liveFile);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return new JsonResponseObject("SUCCESS", null);
	}

	private Object errorMessageList(List<ObjectError> allErrors) {
		List<String> errorMessages = new ArrayList<String>();
		for (Object object : allErrors) {
			if (object instanceof FieldError) {
				FieldError fieldError = (FieldError) object;
				String errorMessage = messageSource.getMessage(fieldError, null);
				errorMessages.add(errorMessage);
			}
		}
		return errorMessages;
	}
}