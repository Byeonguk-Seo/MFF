package uniform;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UniformDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public List getUniformList(String hero) {
		List uniformList=new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 1, 2 디비연결 메서드 호출
			con = getConnection();

			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			// String sql="SELECT * FROM 테이블이름 WHERE 조건열 = 값;
			String sql = "SELECT * FROM UNIFORM WHERE HERO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, hero);

			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs = pstmt.executeQuery();

			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// if  rs.next() 결과에서 다음행 이동하고 데이터 있으면 true => 아이디 비밀번호 일치
			// else                              데이터 없으면 false => 아이디 비밀번호 틀림
			while(rs.next()){
				UniformDTO uniformDTO = new UniformDTO();
				uniformDTO.setHero(rs.getString("HERO"));
				uniformDTO.setUniform(rs.getString("UNIFORM"));
				uniformDTO.setPicture(rs.getString("PICTURE"));
				uniformDTO.setUpday(rs.getString("UPDAY"));
				//배열한칸에 글 정보 저장
				uniformList.add(uniformDTO);
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
		return uniformList;
	}
	
	public UniformDTO getUniform(String hero, String uniform) {
		UniformDTO uniformDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM UNIFORM WHERE HERO = ? AND UNIFORM = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			pstmt.setString(2, uniform);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				uniformDTO=new UniformDTO();
				uniformDTO.setHero(rs.getString("HERO"));
				uniformDTO.setUniform(rs.getString("UNIFORM"));
				uniformDTO.setPicture(rs.getString("PICTURE"));
				uniformDTO.setUpday(rs.getString("UPDAY"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return uniformDTO;
	}
}
