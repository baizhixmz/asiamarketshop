package com.baizhi.clf.config;

import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.filters.RemoteIpFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.DelegatingFilterProxy;

import com.baizhi.clf.filter.A_LoginFilter;
import com.baizhi.clf.filter.B_AccessFilter;
import com.baizhi.clf.filter.C_AccessFilter;
import com.baizhi.clf.filter.D_LanguageFilter;

@Configuration
public class FilterConfig {
	
	@Bean
    public FilterRegistrationBean  filterRegistrationBean() {
		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
		A_LoginFilter a_LoginFilter = new A_LoginFilter();
		registrationBean.setFilter(a_LoginFilter);
		List<String> urlPatterns = new ArrayList<String>();
	    urlPatterns.add("/*");
	    registrationBean.setUrlPatterns(urlPatterns);
	    return registrationBean;
    }
	
	
	@Bean
	public FilterRegistrationBean  filter1() {
		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
		B_AccessFilter b_AccessFilter = new B_AccessFilter();
		registrationBean.setFilter(b_AccessFilter);
		List<String> urlPatterns = new ArrayList<String>();
		urlPatterns.add("/toshop/*");
		registrationBean.setUrlPatterns(urlPatterns);
		return registrationBean;
	}
	
	
	@Bean
	public FilterRegistrationBean  filter2() {
		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
		C_AccessFilter c_AccessFilter = new C_AccessFilter();
		registrationBean.setFilter(c_AccessFilter);
		List<String> urlPatterns = new ArrayList<String>();
		urlPatterns.add("*.jsp");
		registrationBean.setUrlPatterns(urlPatterns);
		return registrationBean;
	}
	
	
	@Bean
	public FilterRegistrationBean  filter3() {
		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
		D_LanguageFilter d_LanguageFilter = new D_LanguageFilter();
		registrationBean.setFilter(d_LanguageFilter);
		List<String> urlPatterns = new ArrayList<String>();
		urlPatterns.add("/toshop/*");
		registrationBean.setUrlPatterns(urlPatterns);
		return registrationBean;
	}
	
	
}
