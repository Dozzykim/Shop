package shop.dao;

import java.sql.SQLException;
import java.util.UUID;

import shop.dto.PersistentLogin;
import shop.dto.User;

public class UserRepository extends JDBConnection {
	
	/**
	 * 회원 등록
	 * @param user
	 * @return
	 */
	public int insert(User user) {
		int result = 0;
		
		String sql = " INSERT INTO user (id, password, name, gender, birth, mail, phone, address) "
				   + " VALUES(?, ?, ?, ?, ?, ?, ?, ?) ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user.getId());
			psmt.setString(2, user.getPassword());
			psmt.setString(3, user.getName());
			psmt.setString(4, user.getGender());
			psmt.setString(5, user.getBirth());
			psmt.setString(6, user.getMail());
			psmt.setString(7, user.getPhone());
			psmt.setString(8, user.getAddress());
			
			result = psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println("회원가입 시, 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	/**
	 * 로그인을 위한 사용자 조회
	 * @param id
	 * @param pw
	 * @return
	 */
	public User login(String id, String pw) {
		
		String sql = " SELECT * "
				   + " FROM user "
				   + " WHERE id = ? and password = ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pw);
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				User user = new User();
				user.setId(rs.getString("id"));
				user.setPassword(rs.getString("password"));
				
				System.out.println("아이디: " + user.getId());
				
				return user;
			}
		} catch (SQLException e) {
			System.err.println("로그인 시도 시, 예외 발생");
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 마이페이지 회원정보 조회 불러오기 (by Id)
	 * @param id
	 * @param pw
	 * @return
	 */
	public User getUserById(String id) {
		String sql = " SELECT * "
				   + " FROM user "
				   + " WHERE id = ? ";
		
		try {
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id); // 첫번째 물음표에 매개변수 id 넣기
			
			rs = psmt.executeQuery();
			
			User user = new User();
			
			if (rs.next()) {
				user.setId(rs.getString("id"));
				user.setName(rs.getString("name"));
				user.setGender(rs.getString("gender"));
				user.setBirth(rs.getString("birth"));
				user.setMail(rs.getString("mail"));
				user.setPhone(rs.getString("phone"));
				user.setAddress(rs.getString("address"));
				
				return user;
			}
			
		} catch (SQLException e) {
			System.err.println("회원정보 조회 시, 예외발생");
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	/**
	 * 회원 수정
	 * @param user
	 * @return
	 */
	public int update(User user) {
		int result = 0;
		
		String sql = " UPDATE user "
				   + " SET name = ? "
				   + "    ,gender = ? "
				   + "    ,birth = ? "
				   + "    ,mail = ? "
				   + "    ,phone = ? "
				   + "    ,address = ? "
				   + " WHERE id = ? " ;
		
		try {
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, user.getName());
			psmt.setString(2, user.getGender());
			psmt.setString(3, user.getBirth());
			psmt.setString(4, user.getMail());
			psmt.setString(5, user.getPhone());
			psmt.setString(6, user.getAddress());
			psmt.setString(7, user.getId());
			
			result = psmt.executeUpdate(); // 성공 1, 실패 0
			
			
		} catch (SQLException e) {
			System.err.println("회원정보 업데이트 시, 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}


	/**
	 * 회원 삭제
	 * @param id
	 * @return
	 */
	public int delete(String id) {
		int result = 0;
		
		String sql = " DELETE FROM user "
				   + " WHERE id = ? " ; 
		
		try {
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, id);
			
			result = psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println("회원 탈퇴 시, 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 토큰 리프레쉬
	 * @param userId
	 */
	public String refreshToken(String userId) {
	    PersistentLogin persistentLogin = selectToken(userId);
	    String token = null;
	    if (persistentLogin == null) {
	        // 토큰이 없는 경우, 삽입
	    	token = insertToken(userId);
	    } else {
	        // 토큰이 있는 경우, 갱신
	    	token =  updateToken(userId);
	    }
	    return token;
	}

	
	
	/**
	 * 토큰 정보 조회
	 * @param userId
	 * @return
	 */
	public PersistentLogin selectToken(String userId) {
	    String sql = "SELECT * FROM persistent_logins WHERE user_id = ?";
	    
	    PersistentLogin persistentLogin = null;
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);

	        rs = psmt.executeQuery();
	        if (rs.next()) {
	        	persistentLogin = new PersistentLogin();
	        	persistentLogin.setpNo( rs.getInt("p_no")); 
	        	persistentLogin.setUserId( rs.getString("user_id") ); 
	        	persistentLogin.setToken( rs.getString("token") ); 
	        	persistentLogin.setDate( rs.getTimestamp("date") ); 
	        }
	        rs.close();
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 조회 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    return persistentLogin;
	}
	
	
	/**
	 * 토큰 정보 조회 - 토큰으로
	 * @param token
	 * @return
	 */
	public PersistentLogin selectTokenByToken(String token) {
	    String sql = "SELECT * FROM persistent_logins WHERE token = ?";
	    
	    PersistentLogin persistentLogin = null;
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, token);

	        rs = psmt.executeQuery();
	        if (rs.next()) {
	            persistentLogin = new PersistentLogin();
	            persistentLogin.setpNo(rs.getInt("p_no")); 
	            persistentLogin.setUserId(rs.getString("user_id")); 
	            persistentLogin.setToken(rs.getString("token")); 
	            persistentLogin.setDate(rs.getTimestamp("date")); // date 필드로 변경
	        }
	        rs.close();
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 조회 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    return persistentLogin;
	}


	
	
	/**
	 * 자동 로그인 토큰 생성
	 * @param userId
	 * @return
	 */
	public String insertToken(String userId) {
		 int result = 0;
	    String sql = "INSERT INTO persistent_logins (user_id, token) VALUES (?, ?)";
	    String token = UUID.randomUUID().toString();
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);
	        psmt.setString(2, token);

	        result = psmt.executeUpdate(); // 퍼시스턴트 로그인 정보 등록 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 등록 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개가 등록되었습니다.");
	    return token;
	}
	
	/**
	 * 자동 로그인 토큰 갱신
	 * @param userId
	 * @return
	 */
	public String updateToken(String userId) {
	    int result = 0;
	    String sql = "UPDATE persistent_logins SET token = ?, date = now() WHERE user_id = ?";
	    String token = UUID.randomUUID().toString();
	    try {
	    	psmt = con.prepareStatement(sql);
	        psmt.setString(1, token);
	        psmt.setString(2, userId);

	        result = psmt.executeUpdate(); // 퍼시스턴트 로그인 정보 수정 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 수정 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개의 데이터가 수정되었습니다.");
	    return token;
	}
	
	
	/**
	 * 토큰 삭제
	 * - 로그아웃 시, 자동 로그인 풀림
	 * @param userId
	 * @return
	 */
	public int deleteToken(String userId) {
	    int result = 0;
	    String sql = "DELETE FROM persistent_logins WHERE user_id = ?";
	    
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);

	        result = psmt.executeUpdate(); // 특정 사용자의 자동 로그인 정보 삭제 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 삭제 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개의 데이터가 삭제되었습니다.");
	    return result;
	}


}

















