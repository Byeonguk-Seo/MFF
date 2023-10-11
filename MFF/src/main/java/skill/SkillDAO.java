package skill;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SkillDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public SkillDTO getSkill(String hero) {
		SkillDTO skillDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM SKILL WHERE HERO = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				skillDTO=new SkillDTO();
				skillDTO.setHero(rs.getString("HERO"));
				skillDTO.setUniform(rs.getString("UNIFORM"));
				skillDTO.setStriker(rs.getString("STRIKER"));
				skillDTO.setUltimate(rs.getString("ULTIMATE"));
				skillDTO.setAwakened(rs.getString("AWAKENED"));
				skillDTO.setLeader(rs.getString("LEADER"));
				skillDTO.setPassive1(rs.getString("PASSIVE1"));
				skillDTO.setPassive2(rs.getString("PASSIVE2"));
				skillDTO.setActive1(rs.getString("ACTIVE1"));
				skillDTO.setActive2(rs.getString("ACTIVE2"));
				skillDTO.setActive3(rs.getString("ACTIVE3"));
				skillDTO.setActive4(rs.getString("ACTIVE4"));
				skillDTO.setActive5(rs.getString("ACTIVE5"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return skillDTO;
	}
}
