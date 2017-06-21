package com.pm.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.stereotype.Controller;

@Controller
@Configuration
@ComponentScan(basePackages = { "com.pm.*" })
@PropertySource("classpath:app.properties")
public class Config {
	
	@Value("${config.twilio_account_sid}")
	public static String TWILIO_ACCOUNT_SID;
	@Value("${config.twilio_auth_token}")
	public static String TWILIO_AUTH_TOKEN;
	@Value("$config.twilio_phone_number}")
	public static String TWILIO_PHONE_NUMBER;
	@Value("${config.auth_api_key}")
	public static String AUTH_API_KEY;
	
	@Value("${config.smsexplorer_username}")
	public String SMSEXPLORER_USERNAME;
	@Value("${config.smsexplorer_password}")
	public String SMSEXPLORER_PASSWORD;
	
	@Value("${filemonitor.interval}")
	public String FILEMONITOR_INTERVAL;
	@Value("${filemonitor.parent.dir}")
	public String FILEMONITOR_PARENT_DIR;
	
	@Value("${filevalidator.parent.test_dir}")
	public String FILEVALIDATOR_PARENT_TEST_DIR;
	
	@Value("${pm.logs.dir}")
	public String PM_LOGS_DIR;
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}	
}
