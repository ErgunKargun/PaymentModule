package com.pm.controller.filemonitorservice;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.apache.commons.io.monitor.FileAlterationListenerAdaptor;
import org.apache.commons.io.monitor.FileAlterationMonitor;
import org.apache.commons.io.monitor.FileAlterationObserver;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
//import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Controller;

import com.pm.configuration.Config;
import com.pm.dao.DebtDao;
import com.pm.dao.FileDao;
import com.pm.dao.RoleDao;
import com.pm.dao.UserDao;
import com.pm.model.Debt;
import com.pm.model.Role;

import com.pm.model.User;
import com.pm.model.compositekey.RoleCompositeKey;

/**
 * @author Ergun
 * 
 */

@Controller
@Component
public class FileMonitor extends FileAlterationListenerAdaptor {

	final Logger logger = LogManager.getLogger(FileMonitor.class);

	@Autowired
	private UserDao userDao;
	@Autowired
	private DebtDao debtDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private Config config;

	private FileAlterationObserver observer;

	private FileAlterationMonitor monitor;

	@PostConstruct
	public void startMonitor() {
		new File(config.PM_LOGS_DIR).mkdirs();
		new File(config.FILEMONITOR_PARENT_DIR).mkdirs();
		new File(config.FILEVALIDATOR_PARENT_TEST_DIR).mkdirs();

		System.setProperty("pm.logs.dir", config.PM_LOGS_DIR);

		observer = new FileAlterationObserver(config.FILEMONITOR_PARENT_DIR);
		observer.addListener(this);

		monitor = new FileAlterationMonitor(Long.parseLong(config.FILEMONITOR_INTERVAL), observer);

		try {
			monitor.start();
			System.out.println("Monitor start " + this.getClass().getName());
			logger.info("Monitor start " + this.getClass().getName());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			/*
			 * userDao.insert(new User("17644635680", "Ergün", "Kargün",
			 * "ergunkargun@gmail.com", "5395535700", "kargunergun@gmail.com"));
			 * roleDao.insert(new Role(new RoleCompositeKey("17644635680",
			 * "ROLE_DEVELOPER")));
			 */
			userDao.insert(new User("17644635680", "Ergun", "Kargun", "ergunkargun@gmail.com", "5395535700",
					"kargunergun@gmail.com"));
			roleDao.insert(new Role(new RoleCompositeKey("17644635680", "ROLE_AGA")));

			User adminTest = new User("12345678901", "Abdullah", "Kargün", "apokargun@gmail.com", "5395535700",
					"ergunkargun@gmail.com");
			adminTest.setStripe("sk_test_uumslaUH4IHyRX7oyRUS9Wad");
			userDao.insert(adminTest);
			roleDao.insert(new Role(new RoleCompositeKey("12345678901", "ROLE_ADMIN")));
			
			userDao.insert(new User("10000000046", "Humeyra", "Gurses", "humeyra_gurses@hotmail.com", "5395535700",
					"apokargun@gmail.com"));
			roleDao.insert(new Role(new RoleCompositeKey("10000000046", "ROLE_USER")));
			debtDao.insert(new Debt("asda", "sdf", "10000000046", "sda", "asdad", new BigDecimal("123"), new BigDecimal("12")));

			logger.info("Inserting the top of pyramid" + this.getClass().getName());
		}
	}

	@Override
	public void onFileCreate(File file) {
		User adminUser = userDao.getUserByTc(file.getName().substring(0, 11));
		logger.info("On File Create " + this.getClass().getName());
		try {
			logger.info("File recording... " + this.getClass().getName());
			BufferedReader rea = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
			Scanner read = new Scanner(rea);
			// System.out.println("Try Reading File " + file.getName() + " "
			// + this.getClass().getName());
			logger.info("Try Reading File... " + file.getName() + " " + this.getClass().getName());
			while (read.hasNext()) {
				String[] dataline = read.nextLine().split(",");
				String tc = dataline[0];
				String name = dataline[1];
				String surname = dataline[2];
				String email = dataline[3];
				String phoneNumber = dataline[4];
				String donem = dataline[5];
				String parsel = dataline[6];
				String gelirCinsi = dataline[7];
				String aciklama = dataline[8];

				BigDecimal tahakkuk = new BigDecimal(dataline[9].trim()).setScale(2, BigDecimal.ROUND_UP);
				System.out.println(tahakkuk);
				BigDecimal odenen = new BigDecimal(dataline[10].trim()).setScale(2, BigDecimal.ROUND_UP);

				// BigDecimal tahakkuk = new
				// BigDecimal(NumberFormat.getCurrencyInstance().format(new
				// BigDecimal(dataline[9].trim())));
				// BigDecimal odenen = new
				// BigDecimal(NumberFormat.getCurrencyInstance().format(new
				// BigDecimal(dataline[10].trim())));

				String roleString = "ROLE_USER";
				for (Role role : roleDao.getAllRolesOfUserByTc(tc)) {
					if (role.getRoleCompositeKey().getRole().equals("ROLE_AGA"))
						roleString = "ROLE_ADMIN";
					break;
				}

				Role roleOfUser = new Role(new RoleCompositeKey(tc, roleString));
				User user = new User(tc, name, surname, email, phoneNumber, adminUser.getEmail());
				Debt debt = new Debt(donem, parsel, tc, gelirCinsi, aciklama, tahakkuk, odenen);

				roleDao.insert(roleOfUser);
				userDao.insert(user);
				debtDao.insert(debt);
			}
			insertFileToDb(file, adminUser);
			// file.delete();
			logger.info("File closed. " + this.getClass().getName());
			read.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void insertFileToDb(File file, User adminUser) throws IOException {
		// List<String> lines =
		// Files.readAllLines(Paths.get(file.getAbsolutePath()),
		// StandardCharsets.UTF_8);
		byte[] encoded = Files.readAllBytes(Paths.get(file.getAbsolutePath()));
		fileDao.insert(new com.pm.model.File(now(), adminUser.getEmail(), new String(encoded, "UTF-8")));
	}

	public String now() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); // 2016/11/16
																				// 12:08:43
		Date date = new Date();
		return dateFormat.format(date);
	}

	@PreDestroy
	public void stopMonitor() {
		try {
			monitor.stop();
			logger.info("Application Stopped!");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// public UserDao getUserDao() {
	// return userDao;
	// }
	//
	// public void setUserDao(UserDao userDao) {
	// this.userDao = userDao;
	// }
	//
	// public DebtDao getDebtDao() {
	// return debtDao;
	// }
	//
	// public void setDebtDao(DebtDao debtDao) {
	// this.debtDao = debtDao;
	// }
	//
	// public RoleDao getRoleDao() {
	// return roleDao;
	// }
	//
	// public void setRoleDao(RoleDao roleDao) {
	// this.roleDao = roleDao;
	// }
	//
	// public FileDao getFileDao() {
	// return fileDao;
	// }
	//
	// public void setFileDao(FileDao fileDao) {
	// this.fileDao = fileDao;
	// }
	//
	// public FileAlterationObserver getObserver() {
	// return observer;
	// }
	//
	// public void setObserver(FileAlterationObserver observer) {
	// this.observer = observer;
	// }
	//
	// public FileAlterationMonitor getMonitor() {
	// return monitor;
	// }
	//
	// public void setMonitor(FileAlterationMonitor monitor) {
	// this.monitor = monitor;
	// }
}
