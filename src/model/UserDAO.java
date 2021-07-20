package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	//로그인
	public UserinfoVO read(String id) {
		UserinfoVO vo=new UserinfoVO();
		try {
			String sql="select * from userinfo where u_id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setU_id(rs.getString("u_id"));
				vo.setU_pass(rs.getString("u_pass"));
				vo.setU_name(rs.getString("u_name"));
				vo.setU_tel(rs.getString("u_tel"));
				vo.setU_email(rs.getString("u_email"));
			}
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
		return vo;
	}

}
