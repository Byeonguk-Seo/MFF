package boss;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BossDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public BossDTO getBoss(String hero) {
		BossDTO bossDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM BOSS WHERE HERO = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				bossDTO=new BossDTO();
				bossDTO.setHero(rs.getString("HERO"));
				bossDTO.setLevel(rs.getString("LEVEL"));
				bossDTO.setAttack(rs.getString("ATTACK"));
				bossDTO.setPdefense(rs.getString("PDEFENSE"));
				bossDTO.setEdefense(rs.getString("EDEFENSE"));
				bossDTO.setLife(rs.getString("LIFE"));
				bossDTO.setExp(rs.getString("EXP"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return bossDTO;
	}
	
	public List getBossList() {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List bossList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql="SELECT I.PICTURE, B.* FROM INFORMATION I, BOSS B WHERE I.HERO = B.HERO ORDER BY LEVEL";
			pstmt=con.prepareStatement(sql);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				BossDTO bossDTO=new BossDTO();
				bossDTO=new BossDTO();
				bossDTO.setHero(rs.getString("HERO"));
				bossDTO.setLevel(rs.getString("LEVEL"));
				bossDTO.setAttack(rs.getString("ATTACK"));
				bossDTO.setPdefense(rs.getString("PDEFENSE"));
				bossDTO.setEdefense(rs.getString("EDEFENSE"));
				bossDTO.setLife(rs.getString("LIFE"));
				bossDTO.setExp(rs.getString("EXP"));
				bossDTO.setPicture(rs.getString("PICTURE"));
				
				//배열한칸에 글 정보 저장
				bossList.add(bossDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return bossList;		
	}
}
