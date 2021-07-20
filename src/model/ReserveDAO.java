package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ReserveDAO {
	
	//구매상품입력
	public void insert_place(OrdersVO vo) {
		try {
			String sql="insert into orders(r_code, p_code, r_time, r_price) values(?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, vo.getR_code());
			ps.setString(2, vo.getP_code());
			ps.setInt(4, vo.getR_price());
			ps.setInt(3, vo.getR_time());
			ps.execute();
			//System.out.println(vo.toString());
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
	}
	
	//구매정보입력
	public String insert(ReserveVO vo, String uid) {
		String r_code="";
		try {
			String sql="select max(r_code) from reserve";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				String id=rs.getString("max(r_code)");
				int lastId=Integer.parseInt(id.substring(1))+1;
				r_code="R"+lastId;
			}
			sql="insert into reserve(r_code,u_name,u_tel,u_email,r_date,r_paytype,r_status,u_id) values(?,?,?,?,sysdate,?,'0',?)";
			ps=DB.con.prepareStatement(sql);
			ps.setString(1, r_code);
			ps.setString(2, vo.getU_name());
			ps.setString(3, vo.getU_tel());
			ps.setString(4, vo.getU_email());
			ps.setString(5, vo.getR_paytype());
			ps.setString(6, uid);
			ps.execute();
			//System.out.println(vo.toString());
		}catch(Exception e) {
			System.out.println("에러333 - "+e.toString());
		}
		return r_code;
	}
	
	//주문상품목록
	public JSONArray oplist(String r_code) {
		JSONArray array=new JSONArray();
		try {
			String sql="select * from porder where r_code=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, r_code);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("r_code", rs.getString("r_code"));
				obj.put("p_code", rs.getString("p_code"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("p_date", rs.getString("p_date"));
				obj.put("p_type", rs.getString("p_type"));
				obj.put("r_time", rs.getInt("r_time"));
				obj.put("p_price", rs.getInt("p_price"));
				obj.put("sum", rs.getInt("r_time")*rs.getInt("p_price"));
				array.add(obj);
			}
		}catch(Exception e) {
			System.out.println("에러222 - "+e.toString());
		}
		return array;
	}
	
	//예약목록
	public JSONObject list(SqlVO vo, String id) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="{call plist(?,?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=DB.con.prepareCall(sql);
			cs.setString(1, "reserve");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setInt(4, vo.getPage());
			cs.setInt(5, vo.getPerpage());
			cs.setString(6, vo.getOrder());
			cs.setString(7, vo.getDesc());
			cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
			cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);
			cs.setString(10, id);
			cs.execute();
			
			ResultSet rs=(ResultSet)cs.getObject(8);
			JSONArray array=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("r_code", rs.getString("r_code"));
				obj.put("u_name", rs.getString("u_name"));
				obj.put("u_tel", rs.getString("u_tel"));
				obj.put("u_email", rs.getString("u_email"));
				obj.put("r_date", rs.getString("r_date"));
				obj.put("r_paytype", rs.getString("r_paytype"));
				obj.put("r_status", rs.getString("r_status"));
				obj.put("u_id", rs.getString("u_id"));	
				array.add(obj);
			}
			jObject.put("array", array);
			
			int count=cs.getInt(9);
			jObject.put("count", count);
		}catch(Exception e) {
			System.out.println("에러111 - "+e.toString());
		}
		return jObject;
	}

}
