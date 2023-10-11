package ability;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AbilityDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public AbilityDTO getAbility(String hero) {
		AbilityDTO abilityDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="SELECT * FROM ABILITY WHERE HERO = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				abilityDTO=new AbilityDTO();
				abilityDTO.setHero(rs.getString("HERO"));
				abilityDTO.setProperty(rs.getString("PROPERTY"));
				abilityDTO.setUniform(rs.getString("UNIFORM"));
				abilityDTO.setAttack(rs.getInt("ATTACK"));
				abilityDTO.setPdefense(rs.getInt("PDEFENSE"));
				abilityDTO.setEdefense(rs.getInt("EDEFENSE"));
				abilityDTO.setLife(rs.getInt("LIFE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return abilityDTO;
	}
}
