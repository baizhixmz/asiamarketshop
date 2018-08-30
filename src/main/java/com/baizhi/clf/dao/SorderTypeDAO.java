package com.baizhi.clf.dao;

import com.baizhi.clf.entity.SorderTypeEntity;

public interface SorderTypeDAO {

	public SorderTypeEntity selectByOrderNum(String orderNum);

	public void insert(SorderTypeEntity sorderTypeEntity);

	public void delete(String orderNum);

}
