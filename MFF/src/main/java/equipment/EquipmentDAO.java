package equipment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class EquipmentDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public EquipmentDTO getEquipment(String hero) {
		EquipmentDTO equipmentDTO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 디비연결
			con=getConnection();
			//3sql
			String sql="select * from equipment where hero=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hero);
			//4실행결과 저장
			rs=pstmt.executeQuery();
			//5 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				equipmentDTO=new EquipmentDTO();
				equipmentDTO.setEquipment1(rs.getString("EQUIPMENT1"));
				equipmentDTO.setEquipment2(rs.getString("EQUIPMENT2"));
				equipmentDTO.setEquipment3(rs.getString("EQUIPMENT3"));
				equipmentDTO.setEquipment4(rs.getString("EQUIPMENT4"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return equipmentDTO;
	}
}
