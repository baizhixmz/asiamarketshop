package com.baizhi.clf;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureOrder;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.baizhi.clf.dao.UserDAO;
import com.baizhi.clf.entity.SuserEntity;
import com.baizhi.clf.service.UserService;
import com.baizhi.clf.service.UserServiceImpl;

@SpringBootTest
@RunWith(SpringRunner.class)
public class TestUser {
		
	@Autowired
	private UserService service;
	
	@Test
	public void testQuery(){
		
		SuserEntity user = service.findByCookid("1111");
		
		System.out.println(user.getPhone());
		
	}
	
}
