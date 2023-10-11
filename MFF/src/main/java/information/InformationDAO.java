package information;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardDTO;

public class InformationDAO {
	// 디비연결 메서드
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public List getInformationList() {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List informationList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
//			String sql="SELECT * FROM BOARD";
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순 정렬
//			String sql="SELECT * FROM BOARD ORDER BY NUM DESC";
			//시작하는 행부터 10개(Mysql  limit 시작행-1,몇개)
		    String sql="SELECT * FROM INFORMATION";
			pstmt=con.prepareStatement(sql);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				InformationDTO informationDTO=new InformationDTO();
				informationDTO.setHero(rs.getString("HERO"));
				informationDTO.setHname(rs.getString("HERO_NAME"));
				informationDTO.setEname(rs.getString("ENGLISH_NAME"));
				informationDTO.setHeight(rs.getInt("HEIGHT"));
				informationDTO.setWeight(rs.getInt("WEIGHT"));
				informationDTO.setTribe(rs.getString("TRIBE"));
				informationDTO.setGender(rs.getString("GENDER"));
				informationDTO.setCamp(rs.getString("CAMP"));
				informationDTO.setNature(rs.getString("NATURE"));
				informationDTO.setAbility1(rs.getString("ABILITY1"));
				informationDTO.setAbility2(rs.getString("ABILITY2"));
				informationDTO.setAbility3(rs.getString("ABILITY3"));
				informationDTO.setBackground(rs.getString("BACKGROUND"));
				informationDTO.setPicture(rs.getString("PICTURE"));
				//배열한칸에 글 정보 저장
				informationList.add(informationDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return informationList;		
	}
	
	public InformationDTO getInformation(String hero) {
		InformationDTO informationDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM INFORMATION WHERE HERO = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				informationDTO=new InformationDTO();
				informationDTO.setHero(rs.getString("HERO"));
				informationDTO.setHname(rs.getString("HERO_NAME"));
				informationDTO.setEname(rs.getString("ENGLISH_NAME"));
				informationDTO.setHeight(rs.getInt("HEIGHT"));
				informationDTO.setWeight(rs.getInt("WEIGHT"));
				informationDTO.setTribe(rs.getString("TRIBE"));
				informationDTO.setGender(rs.getString("GENDER"));
				informationDTO.setCamp(rs.getString("CAMP"));
				informationDTO.setNature(rs.getString("NATURE"));
				informationDTO.setAbility1(rs.getString("ABILITY1"));
				informationDTO.setAbility2(rs.getString("ABILITY2"));
				informationDTO.setAbility3(rs.getString("ABILITY3"));
				informationDTO.setBackground(rs.getString("BACKGROUND"));
				informationDTO.setPicture(rs.getString("PICTURE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return informationDTO;
	}
}
