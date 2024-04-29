package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
		int result1 = 0;
		int result2 = 0;
		
		int subTotal = product.getQuantity()*product.getUnitPrice();
		
		String sql = " INSERT INTO product_io (product_id, order_no, type, amount, user_id) "
				   + " VALUES(?, ?,  ?, ?, ?)" ;
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, product.getProductId());
			psmt.setInt(2, product.getOrderNo());
			psmt.setString(3, product.getType());
			psmt.setInt(4, subTotal);
			psmt.setString(5, product.getUserId());
			
			result1 = psmt.executeUpdate();
			
			
			// product 테이블 재고수 변경
			sql = " UPDATE product "
				+ " SET units_in_stock = units_in_stock + ?"
				+ " WHERE product_id = ? ";
		
			psmt = con.prepareStatement(sql);
			
			// product_io 테이블 등록 성공 시, 
			if (result1 > 0) {
				
				if (product.getType().equals("OUT")) {
					// 출고(주문) 시,
					psmt.setInt(1, product.getQuantity()*-1 );
					psmt.setString(2, product.getUserId());
					
				} else {
					// 입고 시,
					psmt.setInt(1, product.getQuantity()*-1 );
					psmt.setString(2, product.getUserId());
				}
				
				result2 = psmt.executeUpdate();
				
				return result2;
			}
			
			
		} catch (SQLException e) {
			System.err.println("상품 입출고 등록 시, 예외 발생");
			e.printStackTrace();
		}
		
		return result2;
	}
}