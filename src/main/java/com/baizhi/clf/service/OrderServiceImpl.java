package com.baizhi.clf.service;

import com.baizhi.clf.dao.OrderDAO;
import com.baizhi.clf.dao.ProductDAO;
import com.baizhi.clf.entity.*;
import com.baizhi.clf.filter.B_AccessFilter;
import com.baizhi.clf.util.OrderNumUtil;
import com.baizhi.clf.vo.CartCarVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import io.goeasy.GoEasy;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.*;

/**
 * Created by Administrator on 2018/3/27.
 */
@Service
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class OrderServiceImpl implements OrderService {

	
	private Logger log = LoggerFactory.getLogger(OrderServiceImpl.class);
	
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private ProductDAO productDAO;

	@Override
	@Transactional
	public String createOrder(String salary) {

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();

		HttpSession session = request.getSession();

		SuserEntity suserEntity = (SuserEntity) session.getAttribute("user");		
		// 获取当前店主信息
		Admin admin = (Admin) session.getAttribute("adminMsg");

		SorderEntity order = new SorderEntity();

		order.setId(UUID.randomUUID().toString());
		String orderNo = OrderNumUtil.getOrderNo();
		order.setOrderNum(orderNo);
		order.setOrderSalary(new Double(salary));
		order.setOrderStatus("待处理");
		order.setTime(new Date());

		order.setUserId(suserEntity.getId());
		order.setAdminId(admin.getId());

		// 插入订单数据
		orderDAO.insertOrder(order);
		
		
		GoEasy goEasy = new GoEasy("BC-57c75abca21540b89bf00e84e5d7c7f6");
		goEasy.publish(admin.getId(), "您有一个新订单，请及时处理！！！");
		
		
		// 添加当前订单信息入库 并添加订单项
		Map<String, CartCarVO> cartCar = (Map<String, CartCarVO>) session.getAttribute("cartCar");

		// 构建订单项数据并插入
		for (String s : cartCar.keySet()) {
			SorderItemEntity orderItem = new SorderItemEntity();
			CartCarVO cartCarVO = cartCar.get(s);
			SproductEntity sproductEntity = cartCarVO.getSproductEntity();

			orderItem.setId(UUID.randomUUID().toString());
			orderItem.setPrice(sproductEntity.getPrice());
			orderItem.setProductId(sproductEntity.getId());
			orderItem.setCount(cartCarVO.getCount());
			orderItem.setOrderId(orderNo);
			orderItem.setName(sproductEntity.getName());
			orderItem.setDescription(sproductEntity.getDescription());
			orderItem.setImgsrc(sproductEntity.getImgsrc());
			orderItem.setProductNum(sproductEntity.getProductNum());

			orderDAO.insertOrderItem(orderItem);
		}
		// 插入完数据清空购物车
		session.setAttribute("cartCar", null);
		return orderNo;
	}

	@Override
	public List<Map<SorderEntity, List<CartCarVO>>> findOrders() {

		System.out.println("----------------------");

		// 订单项数据 包含 订单对象 -- >对应多个 购物车对象
		List<Map<SorderEntity, List<CartCarVO>>> data = new ArrayList<Map<SorderEntity, List<CartCarVO>>>();

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();

		HttpSession session = request.getSession();

		// 获取当前店主信息
		Admin admin = (Admin) session.getAttribute("adminMsg");

		log.debug("sessionAdmin:" + admin);

		SorderEntity sorderEntity = new SorderEntity();
		sorderEntity.setAdminId(admin.getId());

		SuserEntity user = (SuserEntity) session.getAttribute("user");

		log.debug("sessionUser:" + user);

		sorderEntity.setUserId(user.getId());
		// 通过 外键和 店主id 获取用户在当前店铺的订单数据
		List<SorderEntity> sorderEntities = orderDAO.selectOrders(sorderEntity);

		// 构建订单页数据
		for (SorderEntity entity : sorderEntities) {

			log.debug(entity.toString());

			// 通过订单获取用户的订单项数据
			HashMap<SorderEntity, List<CartCarVO>> map = new HashMap<SorderEntity, List<CartCarVO>>();

			ArrayList<CartCarVO> cartCarVOs = new ArrayList<CartCarVO>();

			String orderNum = entity.getOrderNum();

			List<SorderItemEntity> sorderItemEntities = orderDAO
					.selectOrderItem(orderNum);

			for (SorderItemEntity sorderItemEntity : sorderItemEntities) {

				CartCarVO cartCarVO = new CartCarVO();

				cartCarVO.setCount(sorderItemEntity.getCount());

				SproductEntity sproductEntity = new SproductEntity();
				// 添加商品对象数据
				sproductEntity.setPrice(sorderItemEntity.getPrice());
				sproductEntity.setImgsrc(sorderItemEntity.getImgsrc());
				sproductEntity
						.setDescription(sorderItemEntity.getDescription());
				sproductEntity.setName(sorderItemEntity.getName());

				cartCarVO.setSproductEntity(sproductEntity);

				cartCarVOs.add(cartCarVO);
			}
			// 构建一个订单页数据
			map.put(entity, cartCarVOs);

			data.add(map);
		}

		return data;
	}
}
