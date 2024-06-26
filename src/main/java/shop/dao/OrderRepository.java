package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {

	/**
	 * 주문 등록
	 * 
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		String sql = " INSERT INTO `order` (ship_name, zip_code, country, address,"
				+ " date, user_id, total_price, order_pw, phone ) " + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ? ) ";

		try {
			psmt = con.prepareStatement(sql);

			psmt.setString(1, order.getShipName());
			psmt.setString(2, order.getZipCode());
			psmt.setString(3, order.getCountry());
			psmt.setString(4, order.getAddress());
			psmt.setString(5, order.getDate());
			psmt.setString(6, order.getUserId());
			psmt.setInt(7, order.getTotalPrice());
			psmt.setString(8, order.getOrderPw());
			psmt.setString(9, order.getPhone());

			int result = psmt.executeUpdate();

			System.out.println("오더 완료");
			return result;

		} catch (SQLException e) {
			System.err.println("주문 및 배송정보 저장 시 예외 발생");
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 최근 등록한 orderNo
	 * 
	 * @return
	 */
	public int lastOrderNo() {

		String sql = " SELECT max(order_no) as maxNo " + " FROM `order` ";

		int maxNo = 0;

		try {

			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				maxNo = rs.getInt("maxNo");
			}

		} catch (SQLException e) {
			System.err.println("주문번호 조회 시 예외 발생");
			e.printStackTrace();
		}

		return maxNo;
	}

	/**
	 * 주문 내역 조회 - 회원
	 * 
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		String sql = " SELECT * "
				   + " FROM `order` "
				   + " WHERE user_id = ? ";
		// 여기 sql 문 조인으로 변경해야함
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				Product product = new Product();
				product.setOrderNo(rs.getInt("order_no"));
				product.setProductId(rs.getString("product));
			}
			
		} catch (SQLException e) {
			System.err.println("주문 내역 조회 시, 예외 발생");
			e.printStackTrace();
		}
		
	}

	/**
	 * 주문 내역 조회 - 비회원
	 * 
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {

	}

}
