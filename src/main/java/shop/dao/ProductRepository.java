package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		
		String sql = " SELECT * "
				   + " FROM product ";
		
		// 상품을 담을 리스트
		List<Product> productList = new ArrayList<Product>();
		
		try {
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				Product product = new Product();
				
				product.setName(rs.getString("name"));
				product.setDescription(rs.getString("description"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setFile(rs.getString("file"));
				
				productList.add(product);
			}
			
			return productList;
			
		} catch (SQLException e) {
			System.err.println("상품 목록 조회 시, 예외 발생");
			
		}
		
		return null;
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		
	}

}





























