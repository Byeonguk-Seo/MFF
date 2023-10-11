package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
//	클래스 => 멤버변수,메서드 
	// 주제 : 회원관련 디비작업
	
	// 디비연결 메서드
	public Connection getConnection() throws Exception{
		// throws Exception : 예외처리(에러처리) 메서드 호출한 곳에서 처리하겠다.

		// DataBase ConnectionPool => DBCP
		// 서버에서 미리 디비연결 => 이름정의 => 이름을 불러서 디비연결정보 사용
		// 1. 디비연결 속도 향상, 2. 디비연결코드 수정 최소화 장점
		// webapp - META-INF - context.xml (디비연결)
		// MemberDAO 디비연결 이름을 불러서 사용
		
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}
	
//	insertMember() 메서드 정의(String id, String pass, String name)
	public void insertMember(MemberDTO memberDTO) {
		System.out.println("MemberDAO insertMember()");
		System.out.println("폼에서 받은 아이디 : "+ memberDTO.getId());
		System.out.println("폼에서 받은 비밀번호 : "+ memberDTO.getPass());
		System.out.println("폼에서 받은 이름 : "+ memberDTO.getName());
		System.out.println("폼에서 받은 이메일 : "+ memberDTO.getEmail());
		System.out.println("폼에서 받은 우편번호 : "+ memberDTO.getPost());
		System.out.println("폼에서 받은 주소 : "+ memberDTO.getAddress());
		System.out.println("폼에서 받은 상세주소 : "+ memberDTO.getAddress2());
		System.out.println("폼에서 받은 전화번호 : "+ memberDTO.getPhone());
		System.out.println("폼에서 받은 폰번호 : "+ memberDTO.getMobile());
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		// 메서드 동작할 명령
		// 1단계드라이버불러오기 2단계디비연결 3단계sql 4단계 실행
		try {
			// 에러가 발생할 코드
			// 1, 2단계 메서드
			con = getConnection();

			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql = "INSERT INTO MEMBERS(ID, PASS, NAME, DATE, EMAIL, POST, ADDRESS, ADDRESS2, PHONE, MOBILE, MONEY) VALUES(?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?, 1000)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPass());
			pstmt.setString(3, memberDTO.getName());
			pstmt.setString(4, memberDTO.getEmail());
			pstmt.setString(5, memberDTO.getPost());
			pstmt.setString(6, memberDTO.getAddress());
			pstmt.setString(7, memberDTO.getAddress2());
			pstmt.setString(8, memberDTO.getPhone());
			pstmt.setString(9, memberDTO.getMobile());
			
			// 4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			// 에러 메시지 출력
			e.printStackTrace();
		}finally {
			// 에러 상관없이 마무리(기억장소 할당 해제)
						// Connection con, PreparedStatement pstmt, ResultSet rs
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch(SQLException e) {}
			}
			if(con != null) {
				try {
					con.close();
				} 
				catch(SQLException e) {}
			}
			
		}
	}//insertMember() 메서드
	
	// 리턴할형 MemberDTO userCheck(id, pass) 메서드 정의
	public MemberDTO userCheck(String id, String pass) {
		MemberDTO memberDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 1, 2 디비연결 메서드 호출
			con = getConnection();

			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			// String sql="SELECT * FROM 테이블이름 WHERE 조건열 = 값 AND 조건열 = 값";
			String sql = "SELECT * FROM MEMBERS WHERE ID = ? AND PASS = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);

			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs = pstmt.executeQuery();

			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// if  rs.next() 결과에서 다음행 이동하고 데이터 있으면 true => 아이디 비밀번호 일치
			// else                              데이터 없으면 false => 아이디 비밀번호 틀림
			if(rs.next()){
				//데이터 있으면 true => 아이디 비밀번호 일치
				// MemeberDTO memberDTO 객체생성
				memberDTO = new MemberDTO();
				// set메서드 호출 id, pass, name, date 디비열 저장
				memberDTO.setId(rs.getString("ID"));
				memberDTO.setPass(rs.getString("PASS"));
				memberDTO.setName(rs.getString("NAME"));
				memberDTO.setDate(rs.getTimestamp("DATE"));
			}else{
				//데이터 없으면 false => 아이디 비밀번호 틀림
				 memberDTO = null;
			}
		}
		 catch (Exception e) {
			// 에러 메시지 출력
			e.printStackTrace();
		}finally {
			// 에러 상관없이 마무리
			if(rs != null) {
				try {
					rs.close();
				} 
				catch(SQLException e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch(SQLException e) {}
			}
			if(con != null) {
				try {
					con.close();
				} 
				catch(SQLException e) {}
			}
		}
		return memberDTO;
	}
	
	public int idCheck(String id) {
		MemberDTO memberDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;
		
		try {
			// 1, 2 디비연결 메서드 호출
			con = getConnection();

			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			// String sql="SELECT * FROM 테이블이름 WHERE 조건열 = 값 AND 조건열 = 값";
			String sql = "SELECT * FROM MEMBERS WHERE ID = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);

			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs = pstmt.executeQuery();

			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// if  rs.next() 결과에서 다음행 이동하고 데이터 있으면 true => 아이디 비밀번호 일치
			// else                              데이터 없으면 false => 아이디 비밀번호 틀림
			if(rs.next()){
				result = 0;
			}else{
				//데이터 없으면 false => 아이디 비밀번호 틀림
				 result = 1;
			}
		}
		 catch (Exception e) {
			// 에러 메시지 출력
			e.printStackTrace();
		}finally {
			// 에러 상관없이 마무리
			if(rs != null) {
				try {
					rs.close();
				} 
				catch(SQLException e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch(SQLException e) {}
			}
			if(con != null) {
				try {
					con.close();
				} 
				catch(SQLException e) {}
			}
		}
		return result;
	}
	
	// 리턴할형 MemberDTO getMember(String id) 메서드 정의
	public MemberDTO getMember(String id) {
		MemberDTO memberDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 1, 2 디비연결 메서드 호출
			con = getConnection();

			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
						// String sql="SELECT * FROM 테이블이름 WHERE 조건열 = 값;
			String sql = "SELECT * FROM MEMBERS WHERE ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs = pstmt.executeQuery();

			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// if  rs.next() 결과에서 다음행 이동하고 데이터 있으면 true => 아이디 비밀번호 일치
			// else                              데이터 없으면 false => 아이디 비밀번호 틀림
			if(rs.next()){
				memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("ID"));
				memberDTO.setPass(rs.getString("PASS"));
				memberDTO.setName(rs.getString("NAME"));
				memberDTO.setDate(rs.getTimestamp("DATE"));
				memberDTO.setPost(rs.getString("POST"));
				memberDTO.setEmail(rs.getString("EMAIL"));
				memberDTO.setAddress(rs.getString("ADDRESS"));
				memberDTO.setAddress2(rs.getString("ADDRESS2"));
				memberDTO.setPhone(rs.getString("PHONE"));
				memberDTO.setMobile(rs.getString("MOBILE"));
				memberDTO.setMoney(rs.getInt("MONEY"));
			}
		}
		 catch (Exception e) {
			// 에러 메시지 출력
			e.printStackTrace();
		}finally {
			// 에러 상관없이 마무리
			if(rs != null) {
				try {
					rs.close();
				} 
				catch(SQLException e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch(SQLException e) {}
			}
			if(con != null) {
				try {
					con.close();
				} 
				catch(SQLException e) {}
			}
		}
		return memberDTO;
	}
	
//  updateMember(MemberDTO updateDTO) 메서드 정의
	public void updateMember(MemberDTO updateDTO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//1,2 디비연결 메서드호출
			con = getConnection();
			
			//3단계 수정 String sql="UPDATE 테이블이름 SET 수정열 = 값 WHERE 조건열 = 값";
			String sql = "UPDATE MEMBERS SET NAME = ?, EMAIL = ?, POST = ?, ADDRESS = ?, ADDRESS2 = ?, PHONE = ?, MOBILE = ?, MONEY = ? WHERE ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, updateDTO.getName());
			pstmt.setString(2, updateDTO.getEmail());
			pstmt.setString(3, updateDTO.getPost());
			pstmt.setString(4, updateDTO.getAddress());
			pstmt.setString(5, updateDTO.getAddress2());
			pstmt.setString(6, updateDTO.getPhone());
			pstmt.setString(7, updateDTO.getMobile());
			pstmt.setInt(8, updateDTO.getMoney());
			pstmt.setString(9, updateDTO.getId());
			
			//4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch(SQLException e) {}
			}
			if(con != null) {
				try {
					con.close();
				} 
				catch(SQLException e) {}
			}
		}
	}
	
	// deleteMember(String id) 메서드 정의
	public void deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//1,2 디비연결 메서드호출
			con = getConnection();
			
			//3단계 삭제 String sql="DELETE FROM 테이블이름 WHERE 조건열 = 값";
		 	//sql="DELETE FROM MEMBERS WHERE ID = ?";
			String sql="DELETE FROM MEMBERS WHERE ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			//4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch(SQLException e) {}
			}
			if(con != null) {
				try {
					con.close();
				} 
				catch(SQLException e) {}
			}
		}
	}
	
	//리턴할형 List   getMemberList() 메서드 정의
	public List getMemberList() {
		// 여러 명을 저장할 변수 => 자바 API 배열 변수
		List memberList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//1,2 디비연결 메서드호출
			con = getConnection();
			
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			// String sql="SELECT * FROM 테이블이름";
			String sql="SELECT * FROM MEMBERS";
			pstmt=con.prepareStatement(sql);
			
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				// 한 사람 정보를 MemberDTO 저장 => 배열 한 칸에 저장
				MemberDTO memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("ID"));
				memberDTO.setPass(rs.getString("PASS"));
				memberDTO.setName(rs.getString("NAME"));
				memberDTO.setDate(rs.getTimestamp("DATE"));
				
				// 배열 한 칸에 한 사람의 정보 저장
				memberList.add(memberDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
				} 
				catch(SQLException e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch(SQLException e) {}
			}
			if(con != null) {
				try {
					con.close();
				} 
				catch(SQLException e) {}
			}
		}
		
		return memberList;
	}
}//클래스
