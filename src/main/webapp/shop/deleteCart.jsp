<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 상품 개별삭제
	String product = request.getParameter("id");
	List<Product> cartList = (List<Product>)session.getAttribute("cartList");

	if (product.equals("deleteAll")) {
		
		/* 전체삭제 요청 시 */
		//세션에 저장된 장바구니 무효화 시키고 다시 초기화.
		session.removeAttribute("cartList");
		
		// 초기화된 카트 다시 세션에 담아주기
		List<Product> newCart = new ArrayList();
		session.setAttribute("cartList", newCart);
		
		
	} else {
		/* 개별 삭제 요청 시 */
		for(Product item : cartList) {
			// 장바구니 제품 중, 이름이 일치하는 제품만 삭제
			if(item.getProductId().equals(product)) {
				cartList.remove(item);
				
				break;
			}
		}
		// 삭제하고 다시 세션에 저장...
		session.setAttribute("cartList", cartList);
		
		// 다시 장바구니 화면으로 리다이렉트
		String root = request.getContextPath();
		response.sendRedirect(root+"/shop/cart.jsp");
	}
%>