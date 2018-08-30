package com.baizhi.clf.dao;

import com.baizhi.clf.entity.SuserEntity;

/**
 * Created by Administrator on 2018/3/27.
 */
public interface UserDAO {

	public SuserEntity selectUserByUsername(String cookieid);

	public void insertUser(SuserEntity user);

	public void updateUser(SuserEntity suserEntity);

}
