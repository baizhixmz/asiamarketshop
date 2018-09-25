package com.baizhi.clf.service;

import com.baizhi.clf.dao.CategoryDAO;
import com.baizhi.clf.dao.ProductDAO;
import com.baizhi.clf.entity.SproductEntity;
import com.baizhi.clf.entity.SurlEntity;
import com.baizhi.clf.vo.CartCarVO;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.*;

@Service
public class CartCarServiceImpl implements CartCarService {

	@Resource
	private ProductService productService;
	@Resource
	private CategoryDAO categoryDAO;

	@Override
	public List<CartCarVO> queryCarGoods(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		SurlEntity surlEntity = (SurlEntity)session.getAttribute("shopMsg");
		
		String carName = surlEntity.getId()+"cartCar";
		
		ArrayList<CartCarVO> cartCars = new ArrayList<CartCarVO>();
		Map<String, CartCarVO> cartCar = (Map<String, CartCarVO>) session.getAttribute(carName);
		if (cartCar == null) {
			return null;
		} else {
			Iterator<CartCarVO> iterator = cartCar.values().iterator();
			while (iterator.hasNext()) {
				cartCars.add(iterator.next());
			}
			return cartCars;
		}
	}

	@Override
	public void addCarGood(HttpServletRequest request, String id) {
		
		HttpSession session = request.getSession();
		
		SurlEntity surlEntity = (SurlEntity)session.getAttribute("shopMsg");
		
		String carName = surlEntity.getId()+"cartCar";
		
		Map<String, CartCarVO> cartCar = (Map<String, CartCarVO>) session.getAttribute(carName);
		if (cartCar == null) {
			session.setAttribute(carName,
					new HashMap<String, CartCarVO>());
			cartCar = (Map<String, CartCarVO>) session
					.getAttribute(carName);
		}
		if (!cartCar.containsKey(id)) {
			CartCarVO cartCarVO = new CartCarVO();
			cartCarVO.setCount(1);
			SproductEntity sproductEntity = productService.findProductDetail(id);
			sproductEntity.setCategoryName(categoryDAO.selectCategoryById(
					sproductEntity.getCategoryId()).getName());
			cartCarVO.setSproductEntity(sproductEntity);
			cartCar.put(id, cartCarVO);
		} else {
			CartCarVO cartCarVO = cartCar.get(id);
			cartCarVO.setCount(cartCarVO.getCount() + 1);
			cartCar.put(id, cartCarVO);
		}
	}

	@Override
	public void modifyCarGood(HttpServletRequest request, int count, String id) {
		
		HttpSession session = request.getSession();
		
		SurlEntity surlEntity = (SurlEntity)session.getAttribute("shopMsg");
		
		String carName = surlEntity.getId()+"cartCar";
		
		Map<String, CartCarVO> cartCar = (Map<String, CartCarVO>) session.getAttribute(carName);
		CartCarVO cartCarVO = cartCar.get(id);
		cartCarVO.setCount(count);
		cartCar.put(id, cartCarVO);
	}

	@Override
	public void dropCarGood(HttpServletRequest request, String id) {
		HttpSession session = request.getSession();
		
		SurlEntity surlEntity = (SurlEntity)session.getAttribute("shopMsg");
		
		String carName = surlEntity.getId()+"cartCar";
		Map<String, CartCarVO> cartCar = (Map<String, CartCarVO>)session.getAttribute(carName);
		cartCar.remove(id);
	}

	@Override
	public void addCarGoodAndCount(HttpServletRequest request, String id,
			int count) {
		
		HttpSession session = request.getSession();
		
		SurlEntity surlEntity = (SurlEntity)session.getAttribute("shopMsg");
		
		String carName = surlEntity.getId()+"cartCar";
		
		Map<String, CartCarVO> cartCar = (Map<String, CartCarVO>) session.getAttribute(carName);
		if (cartCar == null) {
			session.setAttribute(carName,
					new HashMap<String, CartCarVO>());
			cartCar = (Map<String, CartCarVO>) session.getAttribute(carName);
		}
		if (!cartCar.containsKey(id)) {
			CartCarVO cartCarVO = new CartCarVO();
			cartCarVO.setCount(count);
			SproductEntity sproductEntity = productService
					.findProductDetail(id);
			sproductEntity.setCategoryName(categoryDAO.selectCategoryById(
					sproductEntity.getCategoryId()).getName());
			cartCarVO.setSproductEntity(sproductEntity);
			cartCar.put(id, cartCarVO);
		} else {
			CartCarVO cartCarVO = cartCar.get(id);
			cartCarVO.setCount(count);
			cartCar.put(id, cartCarVO);
		}

	}
}
