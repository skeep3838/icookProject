package com.icook._00_init.config;

import java.beans.PropertyVetoException;
import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.mchange.v2.c3p0.ComboPooledDataSource;


@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = "com.websystique.spring")
public class RootAppConfig {
	
	@Bean//gmail�H�c�H�H
	 public JavaMailSender getMailSender() {
	  JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	  // Using gmail
	  mailSender.setHost("smtp.gmail.com");
	  mailSender.setPort(587);
	  mailSender.setUsername("u4ek7bp6d8zo@gmail.com");
	  mailSender.setPassword("homeoaxejcrcrpbv");//gmail�H�c�H�H���v�K�X

	  Properties javaMailProperties = new Properties();
	  javaMailProperties.put("mail.smtp.starttls.enable", "true");
	  javaMailProperties.put("mail.smtp.auth", "true");
	  javaMailProperties.put("mail.transport.protocol", "smtp");
	  javaMailProperties.put("mail.debug", "true");// Prints out everything on screen

	  mailSender.setJavaMailProperties(javaMailProperties);
	  return mailSender;
	 }
	
	
	@Bean
	public DataSource dataSource() {
		ComboPooledDataSource ds = new ComboPooledDataSource();
		ds.setUser("sa");
		ds.setPassword("12345");
		try {
			ds.setDriverClass("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
		ds.setJdbcUrl("jdbc:sqlserver://localhost:1433;databaseName=icook");
		ds.setInitialPoolSize(4);
		ds.setMaxPoolSize(8);
		return ds;
	}
	@Bean
	public LocalSessionFactoryBean sessionFactory() {
		LocalSessionFactoryBean factory = new LocalSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setPackagesToScan(new String[] {"com.icook.model"});
		factory.setHibernateProperties(additionalProperties());
		return factory;
	}
	@Bean(name="transactionManager")
	@Autowired
	public HibernateTransactionManager transactionManager(SessionFactory sessionFactory) {
		HibernateTransactionManager txManager = new HibernateTransactionManager();
		txManager.setSessionFactory(sessionFactory);
		return txManager;
	}
	private Properties additionalProperties() {
		Properties properties = new Properties();
		properties.put("hibernate.dialect", org.hibernate.dialect.SQLServer2012Dialect.class);
		properties.put("hibernate.show_sql", Boolean.FALSE);
		properties.put("hibernate.format_sql", Boolean.TRUE);
		properties.put("default_batch_fetch_size", 10);
		properties.put("hiberante.hbm2ddl.auto", "update");
		return properties;
	}
}
