package com.baizhi.clf.service;

import com.baizhi.clf.entity.SuserEntity;

/**
 * Created by Administrator on 2018/3/27.
 */
public interface UserService {

    
    public SuserEntity findByCookid(String cookieid);
    
    public String regist(String cookieId);
    
    public String update(SuserEntity suserEntity);
}
