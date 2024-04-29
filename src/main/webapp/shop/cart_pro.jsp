<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 상품목록 창에서 장바구니 버튼 클릭 시!!
	// 장바구니에 추가 => 세션에 저장된 myCart(리스트) 불러와서 .add 한 후 다시 세션에 저장
	String product_id = request.getParameter("product_id");
	
	ProductRepository productDAO = new ProductRepository();
	Product product = productDAO.getProductById(product_id);
	
	System.out.println("주문할 상품: " + product_id);
	
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	
	// 카트가 null인지 확인
	if (cartList == null) {
		cartList = new ArrayList<>(); // 새로운 카트 생성
	}
	
	boolean isExist = false;
	
	for (Product item : cartList) {
	
		// 이미 있는 상품이면 수량만 증가
		if (item.getName().equals(product.getName())) {
			
			item.setQuantity(item.getQuantity() + 1);
			isExist = true;
	
			break;
		}
	} //foreach 끝
	
		// 존재하지않는 상품이면 새로 product 생성 후 추가
	if (!isExist) {
	
		Product newItem = new Product();
		newItem.setProductId(product_id);
		newItem.setName(product.getName());
		newItem.setUnitPrice(product.getUnitPrice());
		newItem.setQuantity(1);
		newItem.setType("OUT");
	
		cartList.add(newItem);
	}
	
	session.setAttribute("cartList", cartList);
	
	String root = request.getContextPath();
	
	response.sendRedirect(root + "/shop/products.jsp");
%>