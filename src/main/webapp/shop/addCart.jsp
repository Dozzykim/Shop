<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 장바구니에 추가 => 세션에 저장된 myCart(리스트) 불러와서 .add 한 후 다시 세션에 저장
	String product_id = request.getParameter("product_id");
	String product_name = request.getParameter("product_name");
	int product_price = Integer.parseInt(request.getParameter("product_price"));
	
	List<Product> myCart = (List<Product>) session.getAttribute("myCart");
	
	
	// 장바구니가 비었는지 체크
	if (myCart.isEmpty()) {
		// 빈 장바구니면 그냥 추가
		Product product = new Product();
		product.setName(product_name);
		product.setQuantity(1);
		product.setUnitPrice(product_price);
	
		myCart.add(product);
	
	}
	else {

		boolean isExist = false;
		
		for (Product product : myCart) {
	
			// 이미 있는 상품이면 수량만 변경
			if (product.getName().equals(product_name)) {
				// 수량 1 추가
				int addQty = product.getQuantity() + 1;
				product.setQuantity(addQty);
				
				isExist = true;
	
				break;
			}
			else {
				isExist = false;
			}
			
		} //foreach 끝
		
		if (!isExist) {
	
			Product addNew = new Product();
			addNew.setName(product_name);
			addNew.setUnitPrice(product_price);
			addNew.setQuantity(1);
		}
	}
	
	
	String root = request.getContextPath();
	
	response.sendRedirect(root+"/shop/product.jsp?productId="+ product_id);
%>