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
	// 장바구니에 추가 => 세션에 저장된 myCart(리스트) 불러와서 .add 한 후 다시 세션에 저장
	String product_id = request.getParameter("product_id");
	
	System.out.println("주문할 상품: " + product_id );
	
	List<Product> cartList = (List<Product>)session.getAttribute("cartList");
	
	// 카트가 null인지 확인
	if (cartList == null) {
	    cartList = new ArrayList<>(); // 새로운 카트 생성
	}
	
	ProductRepository productDAO = new ProductRepository();
	
	Product product = productDAO.getProductById(product_id);
	
	// 장바구니가 비었는지 체크
	if (product.getQuantity() == 0) {
		// 빈 장바구니면 그냥 추가
		product.setQuantity(1);
		cartList.add(product);
	}
	else {

		boolean isExist = false;
		
		for (Product product : cartList) {
	
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
	
	session.setAttribute("cartList", cartList);
	
	String root = request.getContextPath();
	
	response.sendRedirect(root+"/shop/product.jsp?product_id="+ product_id);
%>