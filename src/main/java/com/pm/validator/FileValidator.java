package com.pm.validator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Scanner;
import java.util.regex.Pattern;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

import com.pm.configuration.Config;
import com.pm.dao.UserDao;
import com.pm.model.FileBucket;
import com.pm.model.User;

//http://docs.spring.io/spring/docs/current/spring-framework-reference/html/validation.html#validation-mvc-configuring

@Component
public class FileValidator implements Validator {

	final Logger logger = LogManager.getLogger(FileValidator.class);

	@Autowired
	UserDao userDao;
	
	@Autowired
	private Config config;

	public static final String PNG_MIME_TYPE = "text/plain";

	public static final long TEN_MB_IN_BYTES = 10485760; // 10mb

	@Override
	public boolean supports(Class<?> clazz) {
		return FileBucket.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {

		FileBucket fileBucket = (FileBucket) target;

		if (fileBucket.getMultipartFile() != null && fileBucket.getMultipartFile().isEmpty()) {
			errors.rejectValue("multipartFile", "upload.file.empty");
		}

		else if (!PNG_MIME_TYPE.equalsIgnoreCase(fileBucket.getMultipartFile().getContentType())) {
			errors.rejectValue("multipartFile", "upload.file.invalid.type");
		}

		else if (fileBucket.getMultipartFile().getSize() > TEN_MB_IN_BYTES) {
			errors.rejectValue("multipartFile", "upload.file.exceeded.size");
		}

		else {
			int errorLine = 0;

			MultipartFile multipartFile = fileBucket.getMultipartFile();
			File testUploadedFile = new File(config.FILEVALIDATOR_PARENT_TEST_DIR + File.separator + adminUser().getTc() + "_"
					+ new Date().toString().replaceAll(":","_") + "_" + multipartFile.getOriginalFilename());
						
			try {
				testUploadedFile.createNewFile();
				FileCopyUtils.copy(multipartFile.getBytes(), testUploadedFile);
				logger.info("File validating... " + this.getClass().getName());
				BufferedReader rea = new BufferedReader(
						new InputStreamReader(new FileInputStream(testUploadedFile), "UTF-8"));
				Scanner read = new Scanner(rea);

				while (read.hasNext()) {
					errorLine++;
					String[] dataline = read.nextLine().split(",");
					if (dataline.length != 11) {
						errors.rejectValue("multipartFile", "upload.file.error.generalline", new Object[] { errorLine }, null);
						break;
					}
					String tc = dataline[0];
					String email = dataline[3];
					String phoneNumber = dataline[4];
					String tahakkuk = dataline[9];
					String odenen = dataline[10];

					// validate tc of format "12345678901"
					if (!tc.matches("\\d{11}"))
						errors.rejectValue("multipartFile", "upload.file.error.tc", new Object[] { errorLine }, null);
//					else if (!checkIfItIsARealTc(Long.parseLong(tc))) {
//						errors.rejectValue("multipartFile", "upload.file.error.invalid.tc", new Object[] { errorLine }, null);
//					}
					// validate email of format "abc@abc.abc"
					if (!checkIfItIsAValidEmail(email))
						errors.rejectValue("multipartFile", "upload.file.error.email", new Object[] { errorLine }, null);
					// validate phone number of format "5551234567"
					if (!phoneNumber.matches("\\d{10}"))
						errors.rejectValue("multipartFile", "upload.file.error.phone", new Object[] { errorLine }, null);
					// validate bigdecimals of format "1.2" or "0" etc.
					if (!checkIfInvalidBigDecimals(tahakkuk, odenen))
						errors.rejectValue("multipartFile", "upload.file.error.debt.amounts", new Object[] { errorLine }, null);
				}
				logger.info("File validating finished. " + this.getClass().getName());
				read.close();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private User adminUser() {
		User adminUser = userDao.getUserByTc(SecurityContextHolder.getContext().getAuthentication().getName());
		return adminUser;
	}

	private boolean checkIfInvalidBigDecimals(String tahakkuk, String odenen) {
		final String BIGDECIMAL_PATTERN = "(?:\\d+(?:\\.\\d+)?|\\.\\d+)";
		return Pattern.compile(BIGDECIMAL_PATTERN).matcher(tahakkuk).matches()
				&& Pattern.compile(BIGDECIMAL_PATTERN).matcher(odenen).matches();
	}

	private boolean checkIfItIsAValidEmail(String email) {
		final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
		return Pattern.compile(EMAIL_PATTERN).matcher(email).matches();
	}

//	private boolean checkIfItIsARealTc(long parseLong) {
//		// https://onedio.com/haber/tc-kimlik-numarasi-hakkinda-sizi-sasirtacak-5-gercek-538999
//		// 4th feature
//		long tc = parseLong / 10;
//		long compareLong = 0L;
//		while (tc > 0) {
//			compareLong += tc % 10;
//			tc = tc / 10;
//		}
//		return compareLong % 10 == parseLong % 10;
//	}
}