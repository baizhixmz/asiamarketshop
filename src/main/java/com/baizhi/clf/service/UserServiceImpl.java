package com.baizhi.clf.service;

import com.baizhi.clf.dao.AdminDAO;
import com.baizhi.clf.dao.UserDAO;
import com.baizhi.clf.entity.Admin;
import com.baizhi.clf.entity.SuserEntity;
import com.baizhi.clf.util.PasswordUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.UUID;

/**
 * Created by Administrator on 2018/3/27.
 */
@Service
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private AdminDAO adminDAO;

    @Override
    public String regist(String cookieId) {

        SuserEntity suserEntity = new SuserEntity();
        
        suserEntity.setId(UUID.randomUUID().toString());
        
        suserEntity.setCookieid(cookieId);

        userDAO.insertUser(suserEntity);

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        HttpSession session = request.getSession();

        session.setAttribute("user",suserEntity);

        return "success";
    }

	@Override
	public SuserEntity findByCookid(String cookieId) {
		System.out.println(cookieId);
		SuserEntity user = userDAO.selectUserByUsername(cookieId);
		return user;
	}

	@Override
	public String update(SuserEntity suserEntity) {
		
		userDAO.updateUser(suserEntity);
		
		return null;
	}
}
