package com.baizhi.clf;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.core.Ordered;
import org.springframework.web.filter.DelegatingFilterProxy;

import com.baizhi.clf.filter.A_LoginFilter;
import com.baizhi.clf.filter.B_AccessFilter;
import com.baizhi.clf.filter.C_AccessFilter;
import com.baizhi.clf.filter.D_LanguageFilter;


/**
 * Created by Administrator on 2018/3/21.
 */
@SpringBootApplication
@MapperScan("com.baizhi.clf.dao")
@ImportResource("classpath:com/baizhi/clf/mvc/spring-mvc.xml")
public class ApplicationRun extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(
			SpringApplicationBuilder builder) {
		builder.sources(this.getClass());
		return super.configure(builder);
	}

	public static void main(String[] args) {
		SpringApplication.run(ApplicationRun.class, args);
	}
	
}
