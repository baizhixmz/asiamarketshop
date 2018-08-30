package com.baizhi.clf.controller;

import com.baizhi.clf.entity.SuserEntity;
import com.baizhi.clf.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2018/3/27.
 */
@RestController
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping("/register")
	public String register(String cookieId, HttpServletResponse response) {

		userService.regist(cookieId);

		return "success";
	}

	@RequestMapping("/findOneById")
	public SuserEntity findOneById(String cookieId, HttpServletRequest request) {

		SuserEntity suserEntity = userService.findByCookid(cookieId);

		return suserEntity;

	}

	@RequestMapping("/getUser")
	public String getUser(String cookieId, HttpServletRequest request) {

		SuserEntity user = userService.findByCookid(cookieId);

		HttpSession session = request.getSession();

		session.setAttribute("user", user);

		return "success";

	}

}
