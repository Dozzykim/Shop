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
				
				product.setProductId(rs.getString("product_id"));
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
		
		String sql = " SELECT * "
				   + " FROM product "
				   + " WHERE product_id = ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			
			rs = psmt.executeQuery();
			
			Product product = new Product();
			if(rs.next()) {
				
				product.setProductId(rs.getString("product_id"));
				product.setName(rs.getString("name"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setCondition(rs.getString("condition"));
				product.setUnitsInStock(rs.getInt("units_in_stock"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setFile(rs.getString("file"));
				
				System.out.println("상품아이디:" + product.getProductId());
				
				return product;
			}
		} catch (SQLException e) {
			System.err.println("상품정보 조회 시, 예외 발생");
			e.printStackTrace();
		}
		
		return null;
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





























