package com.baizhi.clf.controller;

import com.baizhi.clf.entity.SorderEntity;
import com.baizhi.clf.entity.SorderTypeEntity;
import com.baizhi.clf.entity.SuserEntity;
import com.baizhi.clf.service.OrderService;
import com.baizhi.clf.service.OrderTypeService;
import com.baizhi.clf.service.UserService;
import com.baizhi.clf.vo.CartCarVO;
import com.baizhi.clf.vo.OrderDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2018/3/27.
 */
@RestController
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private UserService userService;
	@Autowired
	private OrderTypeService orderTypeService;

	@RequestMapping("/createOrder")
	public String createOrder(String salary, String name, String phone,
			String address, String qtime, HttpServletRequest request) {

		HttpSession session = request.getSession();

		if (name != null && phone != null && address != null) {
			SuserEntity user = (SuserEntity) session.getAttribute("user");
			user.setName(name);
			user.setPhone(phone);
			user.setAddress(address);
			userService.update(user);
		}

		String result = orderService.createOrder(salary);

		SorderTypeEntity sorderTypeEntity = new SorderTypeEntity();
		sorderTypeEntity.setId(UUID.randomUUID().toString());
		sorderTypeEntity.setOrderNum(result);
		sorderTypeEntity.setName(name);
		sorderTypeEntity.setPhone(phone);
		sorderTypeEntity.setAddress(address);
		sorderTypeEntity.setQtime(qtime);

		orderTypeService.add(sorderTypeEntity);

		return result;
	}

	@RequestMapping("/findMyOrder")
	public List<OrderDTO> findMyOrder() {

		// 由于前台js不支持复杂的json转换所以这里边转换为简单结构
		List<Map<SorderEntity, List<CartCarVO>>> orders = orderService
				.findOrders();

		ArrayList<OrderDTO> dtoArrayList = new ArrayList<OrderDTO>();

		for (Map<SorderEntity, List<CartCarVO>> order : orders) {

			for (SorderEntity sorderEntity : order.keySet()) {

				OrderDTO orderDTO = new OrderDTO();

				orderDTO.setSorderEntity(sorderEntity);

				orderDTO.setCartCarVO(order.get(sorderEntity));

				dtoArrayList.add(orderDTO);
			}
		}

		return dtoArrayList;
	}
}
