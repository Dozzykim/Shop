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
	System.out.println("장바구니 들어옴");
	// 장바구니에 추가 => 세션에 저장된 myCart(리스트) 불러와서 .add 한 후 다시 세션에 저장
	String product_id = request.getParameter("product_id");
	String product_name = request.getParameter("product_name");
	int product_price = Integer.parseInt(request.getParameter("product_price"));
	
	System.out.println("주문할 상품: " + product_id );
	
	List<Product> cartList = (List<Product>)session.getAttribute("cartList");
	
	
	// 장바구니가 비었는지 체크
	if (cartList.size() == 0) {
		
		Product newItem = new Product();
		// 빈 장바구니면 그냥 추가
		newItem.setProductId(product_id);
		newItem.setName(product_name);
		newItem.setUnitPrice(product_price);
		newItem.setQuantity(1);
		
		cartList.add(newItem);
		
	} else {
		
		boolean isExist = false;
		
		for (Product myItem : cartList) {
	
			// 이미 있는 상품(myItem)이면 수량만 변경
			if (myItem.getName().equals(product_name)) {
				// 수량 1 추가
				int addQty = myItem.getQuantity() + 1;
				myItem.setQuantity(addQty);
				
				isExist = true;
				System.out.println("존재하는 상품. 수량 1증가");
	
				break;
			}
			else {
				isExist = false;
			}
			
		} //foreach 끝
		
		if (!isExist) {
	
			Product newItem = new Product();
			
			newItem.setProductId(product_id);
			newItem.setName(product_name);
			newItem.setUnitPrice(product_price);
			newItem.setQuantity(1);
			
			cartList.add(newItem);
			
			System.out.println("장바구니에 새롭게 추가");
		}
	}
	
	session.setAttribute("cartList", cartList);
	
	String root = request.getContextPath();
	
	response.sendRedirect(root+"/shop/product.jsp?product_id="+ product_id);
%>