<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 주문처리 => order, product_io 테이블에 데이터 추가하기 */
	
	// 세션에 저장한 장바구니리스트
	List<Product> cartList = (List<Product>)session.getAttribute("cartList");
	
	
	// 파라미터로 전달받은 배송 및 주문정보
	String name = request.getParameter("name");
	String shippingDate = request.getParameter("shippingDate");
	String country = request.getParameter("country");
	String zipCode = request.getParameter("zipCode");
	String addressName = request.getParameter("addressName");
	String phone = request.getParameter("phone");
	
	OrderRepository orderDAO = new OrderRepository();
	Order order = new Order();
	
	order.setShipName(name);
	order.setDate(shippingDate);
	order.setCountry(country);
	order.setZipCode(zipCode);
	order.setAddress(addressName);
	order.setPhone(phone);
	
	// 로그인여부
	boolean isLoggin = session.getAttribute("loginId") != null ? true : false; 	
	String userType = "";
			
	if(isLoggin) {
		userType = "회원";
		order.setUserId( (String)session.getAttribute("loginId") );
	} else {
		userType = "비회원";
	}
	
	int totalPrice = 0;

	for(Product product : cartList) {
		totalPrice  += product.getQuantity()*product.getUnitPrice();
	}
	
	order.setTotalPrice(totalPrice);
	
	// order.jsp 에서 표시해야해서 order로 요청하기
	request.setAttribute("myOrder", order);
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("order.jsp");
	dispatcher.forward(request, response);
	
	
	
	
	
%>