package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import information.InformationDTO;

public class StoreDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public StoreDTO getStore(String hero) {
		StoreDTO storeDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM STORE WHERE HERO = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				storeDTO=new StoreDTO();
				storeDTO.setHero(rs.getString("HERO"));
				storeDTO.setPrice(rs.getInt("PRICE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return storeDTO;
	}
	
	public List getStoreList(int startRow,int pageSize, String uid) {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List storeList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();

			String sql="SELECT A.*, B.PRICE FROM (SELECT I.HERO, I.PICTURE FROM (SELECT UID, HERO FROM MY_HERO WHERE UID = ?) M RIGHT OUTER JOIN INFORMATION I ON M.HERO = I.HERO WHERE M.HERO IS NULL) A, (SELECT  S.HERO, S.PRICE FROM (SELECT UID, HERO FROM MY_HERO WHERE UID = ?) M RIGHT OUTER JOIN STORE S ON M.HERO = S.HERO WHERE M.HERO IS NULL) B WHERE A.HERO = B.HERO ORDER BY HERO LIMIT ?, ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, uid);
			pstmt.setInt(3, startRow-1);
			pstmt.setInt(4, pageSize);
			rs=pstmt.executeQuery();

			while(rs.next()) {
				StoreDTO storeDTO=new StoreDTO();
				storeDTO.setHero(rs.getString("HERO"));
				storeDTO.setPrice(rs.getInt("PRICE"));
				storeDTO.setPicture(rs.getString("PICTURE"));
				//배열한칸에 글 정보 저장
				storeList.add(storeDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return storeList;		
	}
	
	public int getStoreCount(String uid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count = 0;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT  COUNT(*) FROM (SELECT I.HERO, I.PICTURE FROM (SELECT UID, HERO FROM MY_HERO WHERE UID = ?) M RIGHT OUTER JOIN INFORMATION I ON M.HERO = I.HERO WHERE M.HERO IS NULL) A, (SELECT S.HERO, S.PRICE FROM (SELECT UID, HERO FROM MY_HERO WHERE UID = ?) M RIGHT OUTER JOIN STORE S ON M.HERO = S.HERO WHERE M.HERO IS NULL) B WHERE A.HERO = B.HERO";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, uid);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			// 5 다음행으로 이동 데이터 있으면 열 접근
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return count;
	}
}
