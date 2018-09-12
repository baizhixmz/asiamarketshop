package com.baizhi.clf.filter;

import com.baizhi.clf.dao.UserDAO;
import com.baizhi.clf.entity.SuserEntity;
import com.baizhi.clf.util.CookiesUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * Created by Administrator on 2018/3/1.
 */
//@WebFilter(urlPatterns = "/as*", filterName = "f0")
public class A_LoginFilter implements Filter {
	private ServletContext servletContext;

	
	private UserDAO userDAO;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

		servletContext = filterConfig.getServletContext();
	    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(servletContext);
	    userDAO = (UserDAO) ctx.getBean("userDAO");
		
	}


	@Override
	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) servletRequest;

		Cookie cookie = CookiesUtil.getCookieByName(request, "userId");

		HttpServletResponse response = (HttpServletResponse) servletResponse;


		HttpSession session = request.getSession();

		if (cookie == null) {
			String cookName = UUID.randomUUID().toString();
			CookiesUtil.setCookie(response, "userId", cookName, 1000 * 60 * 60 * 24 * 365);
			SuserEntity user = new SuserEntity();
			user.setCookieid(cookName);
			user.setId(UUID.randomUUID().toString());
			userDAO.insertUser(user);
			session.setAttribute("user", user);
		} else {
			SuserEntity suser = userDAO.selectUserByUsername(cookie.getValue());
			session.setAttribute("user", suser);

		}

		// 代表用户已经登录直接放行
		filterChain.doFilter(servletRequest, servletResponse);

	}

	@Override
	public void destroy() {

	}
}
