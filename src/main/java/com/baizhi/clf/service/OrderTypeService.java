package com.baizhi.clf.service;

import com.baizhi.clf.entity.SorderTypeEntity;

public interface OrderTypeService {

	public SorderTypeEntity findByOrderNum(String orderNum);

	public void add(SorderTypeEntity sorderTypeEntity);

	public void remove(String orderNum);

}
