package myhero;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MyheroDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public MyheroDTO getMyhero(List list) {
		MyheroDTO myheroDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM MY_HERO WHERE UID = ? AND HERO = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, (String) list.get(0));
			pstmt.setString(2, (String) list.get(1));
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				myheroDTO=new MyheroDTO();
				myheroDTO.setNum(rs.getInt("NUM"));
				myheroDTO.setUid(rs.getString("UID"));
				myheroDTO.setHero(rs.getString("HERO"));
				myheroDTO.setHlevel(rs.getInt("HERO_LEVEL"));
				myheroDTO.setExp(rs.getInt("EXP"));
				myheroDTO.setAttack(rs.getInt("ATTACK"));
				myheroDTO.setPdefense(rs.getInt("PDEFENSE"));
				myheroDTO.setEdefense(rs.getInt("EDEFENSE"));
				myheroDTO.setLife(rs.getInt("LIFE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return myheroDTO;
	}
	
	public MyheroDTO getMyhero(String hero) {
		MyheroDTO myheroDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM MY_HERO WHERE HERO = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				myheroDTO=new MyheroDTO();
				myheroDTO.setNum(rs.getInt("NUM"));
				myheroDTO.setUid(rs.getString("UID"));
				myheroDTO.setHero(rs.getString("HERO"));
				myheroDTO.setHlevel(rs.getInt("HERO_LEVEL"));
				myheroDTO.setExp(rs.getInt("EXP"));
				myheroDTO.setAttack(rs.getInt("ATTACK"));
				myheroDTO.setPdefense(rs.getInt("PDEFENSE"));
				myheroDTO.setEdefense(rs.getInt("EDEFENSE"));
				myheroDTO.setLife(rs.getInt("LIFE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return myheroDTO;
	}
	
	public List getMyheroList(int startRow,int pageSize, String uid) {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List myheroList=new ArrayList();
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
		    String sql="SELECT * FROM MY_HERO WHERE UID = ? ORDER BY NUM LIMIT ?, ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				MyheroDTO myheroDTO=new MyheroDTO();
				myheroDTO.setNum(rs.getInt("NUM"));
				myheroDTO.setUid(rs.getString("UID"));
				myheroDTO.setHero(rs.getString("HERO"));
				myheroDTO.setHlevel(rs.getInt("HERO_LEVEL"));
				myheroDTO.setExp(rs.getInt("EXP"));
				myheroDTO.setAttack(rs.getInt("ATTACK"));
				myheroDTO.setPdefense(rs.getInt("PDEFENSE"));
				myheroDTO.setEdefense(rs.getInt("EDEFENSE"));
				myheroDTO.setLife(rs.getInt("LIFE"));
				//배열한칸에 글 정보 저장
				myheroList.add(myheroDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return myheroList;		
	}
	
	public int getMyheroCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count = 0;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT COUNT(*) FROM MY_HERO";
			pstmt=con.prepareStatement(sql);
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
	
	public void insertMyhero(MyheroDTO myheroDTO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		
		try {
			con = getConnection();

			String sql = "INSERT INTO MY_HERO(NUM, UID, HERO, HLEVEL, EXP, ATTACK, PDEFENSE, EDEFENSE, LIFE) VALUES(NULL, ?, ?, 1, 0, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, myheroDTO.getUid());
			pstmt.setString(2, myheroDTO.getHero());
			pstmt.setInt(3, myheroDTO.getAttack());
			pstmt.setInt(4, myheroDTO.getPdefense());
			pstmt.setInt(5, myheroDTO.getEdefense());
			pstmt.setInt(6, myheroDTO.getLife());
			
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
	
	public void updateMyhero(MyheroDTO myheroDTO, int exp) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//1,2 디비연결 메서드호출
			con = getConnection();
			
			//3단계 수정 String sql="UPDATE 테이블이름 SET 수정열 = 값 WHERE 조건열 = 값";
			String sql = "UPDATE MY_HERO SET EXP = ? WHERE UID = ? AND HERO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, exp);
			pstmt.setString(2, myheroDTO.getUid());
			pstmt.setString(3, myheroDTO.getHero());
			
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
	
	public void levelUpMyhero(MyheroDTO myheroDTO, int exp, int hlevel) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//1,2 디비연결 메서드호출
			con = getConnection();
			
			//3단계 수정 String sql="UPDATE 테이블이름 SET 수정열 = 값 WHERE 조건열 = 값";
			String sql = "UPDATE MY_HERO SET EXP = ?, HLEVEL = ? WHERE UID = ? AND HERO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, exp);
			pstmt.setInt(2, hlevel);
			pstmt.setString(3, myheroDTO.getUid());
			pstmt.setString(4, myheroDTO.getHero());
			
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
}
