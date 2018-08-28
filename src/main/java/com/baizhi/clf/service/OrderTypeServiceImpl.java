package com.baizhi.clf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baizhi.clf.dao.SorderTypeDAO;
import com.baizhi.clf.entity.SorderTypeEntity;

@Service
@Transactional
public class OrderTypeServiceImpl implements OrderTypeService {

	@Autowired
	private SorderTypeDAO sorderTypeDAO;
	
	@Override
	public SorderTypeEntity findByOrderNum(String orderNum) {
		
		SorderTypeEntity orderType = sorderTypeDAO.selectByOrderNum(orderNum);
		
		return orderType;
	}

	@Override
	public void add(SorderTypeEntity sorderTypeEntity) {
		// TODO Auto-generated method stub
		sorderTypeDAO.insert(sorderTypeEntity);
	}

	@Override
	public void remove(String orderNum) {
		// TODO Auto-generated method stub
		sorderTypeDAO.delete(orderNum);
	}

}
