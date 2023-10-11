package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.MemberDTO;

public class BoardDAO {
	// 디비연결 메서드
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	// 리턴할형 List   getBoardList() 메서드 정의
	public List getBoardList(int startRow,int pageSize) {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List boardList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
//			String sql="SELECT * FROM BOARD";
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순 정렬
//			String sql="SELECT * FROM BOARD ORDER BY NUM DESC;";
			//시작하는 행부터 10개(Mysql  limit 시작행-1,몇개)
		    String sql="SELECT * FROM BOARD ORDER BY NUM DESC LIMIT ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("NUM"));
				boardDTO.setPass(rs.getString("PASS"));
				boardDTO.setName(rs.getString("NAME"));
				boardDTO.setSubject(rs.getString("SUBJECT"));
				boardDTO.setContent(rs.getString("CONTENT"));
				boardDTO.setReadcount(rs.getInt("READCOUNT"));
				boardDTO.setDate(rs.getTimestamp("DATE"));
				//첨부파일
				boardDTO.setFile(rs.getString("FILE"));
				//배열한칸에 글 정보 저장
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardList;		
	}
	
//	BoardDTO boardDTO=boardDAO.getBoard(num);
	public BoardDTO getBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO boardDTO=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM BOARD WHERE NUM = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("NUM"));
				boardDTO.setPass(rs.getString("PASS"));
				boardDTO.setName(rs.getString("NAME"));
				boardDTO.setSubject(rs.getString("SUBJECT"));
				boardDTO.setContent(rs.getString("CONTENT"));
				boardDTO.setReadcount(rs.getInt("READCOUNT"));
				boardDTO.setDate(rs.getTimestamp("DATE"));
				//첨부파일
				boardDTO.setFile(rs.getString("FILE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardDTO;
	}
	
	//리턴값없음 insertBoard(BoardDTO boardDTO) 메서드 정의
	public void insertBoard(BoardDTO boardDTO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT MAX(NUM) FROM BOARD";
			pstmt=con.prepareStatement(sql);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 
			int num=0;
			if(rs.next()) {
				num=rs.getInt("MAX(NUM)")+1;
			}
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			// 날짜 now()
			sql="INSERT INTO BOARD(NUM, NAME, PASS, SUBJECT, CONTENT, READCOUNT, DATE, FILE) VALUES(?, ?, ?, ?, ?, ?, NOW(), ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardDTO.getName());
			pstmt.setString(3, boardDTO.getPass());
			pstmt.setString(4, boardDTO.getSubject());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.setInt(6, boardDTO.getReadcount());
			//파일
			pstmt.setString(7, boardDTO.getFile());
			
			// 4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
	// 리턴할형없음 updateBoard(BoardDTO boardDTO)
	public void updateBoard(BoardDTO boardDTO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql
			String sql="UPDATE BOARD SET SUBJECT = ?, CONTENT = ?, FILE = ? WHERE NUM = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getSubject());
			pstmt.setString(2, boardDTO.getContent());
			//파일
			pstmt.setString(3, boardDTO.getFile());
			pstmt.setInt(4, boardDTO.getNum());
			//4 실행 
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
	// 리턴값없음 deleteBoard(int num) 메서드 정의
	public void deleteBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql
			String sql="DELETE FROM BOARD WHERE NUM = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4 실행 
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
//	int count=boardDAO.getBoardCount();
	public int getBoardCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			//1,2 
			con=getConnection();
			//3sql
			String sql="SELECT COUNT(*) FROM BOARD";
			pstmt=con.prepareStatement(sql);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행으로 이동 데이터 있으면 열 접근
			if(rs.next()) {
				count=rs.getInt("COUNT(*)");
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

//	boardDAO.updateReadcount(num);	
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql
			String sql="UPDATE BOARD SET READCOUNT = READCOUNT + 1 WHERE NUM = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
}//클래스
