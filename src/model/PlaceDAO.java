package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class PlaceDAO {	
	
	//상품삭제
	public void delete(String p_code) {
		try {
			String sql="delete from place where p_code=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, p_code);
			ps.execute();
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
	}
	
	//상품수정
	public void update(PlaceVO vo) {
		try {
			String sql="update place set p_name=?, p_location=?, p_date=?, p_price=?, p_person=?, p_type=?, p_detail=?, p_info=?, p_image=?, p_status=? where p_code=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(11, vo.getP_code());
			ps.setString(1, vo.getP_name());
			ps.setString(2, vo.getP_location());
			ps.setString(3, vo.getP_date());
			ps.setInt(4, vo.getP_price());
			ps.setInt(5, vo.getP_person());
			ps.setString(6, vo.getP_type());
			ps.setString(7, vo.getP_detail());
			ps.setString(8, vo.getP_info());
			ps.setString(9, vo.getP_image());
			ps.setString(10, vo.getP_status());
			ps.execute();
			//System.out.println(vo.toString());
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
	}
	
	//장소읽어오기
	public PlaceVO read(String p_code) {
		PlaceVO vo=new PlaceVO();
		try {
			String sql="select * from place where p_code=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, p_code);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setP_code(rs.getString("p_code"));
				vo.setP_name(rs.getString("p_name"));
				vo.setP_location(rs.getString("p_location"));
				vo.setP_date(rs.getString("p_date"));
				vo.setP_price(rs.getInt("p_price"));
				vo.setP_person(rs.getInt("p_person"));
				vo.setP_type(rs.getString("p_type"));
				vo.setP_detail(rs.getString("p_detail"));
				vo.setP_info(rs.getString("p_info"));
				vo.setP_image(rs.getString("p_image"));	
				vo.setP_status(rs.getString("p_status"));
				//System.out.println(vo.toString());
			}
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
		return vo;
	}
	
	//마지막 장소 코드 가져오기
	public String getCode() {
		String p_code="P001";
		try {
			String sql="select max(p_code) from place";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				String lastId=rs.getString("max(p_code)");
				p_code="P"+(Integer.parseInt(lastId.substring(1))+1);
			}
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
		return p_code;
	}
	
	//장소등록
	public void insert(PlaceVO vo) {
		try {
			String sql="insert into place(p_code, p_name, p_location, p_date, p_price, p_person, p_type, p_detail, p_info, p_image, p_status) values(?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, vo.getP_code());
			ps.setString(2, vo.getP_name());
			ps.setString(3, vo.getP_location());
			ps.setString(4, vo.getP_date());
			ps.setInt(5, vo.getP_price());
			ps.setInt(6, vo.getP_person());
			ps.setString(7, vo.getP_type());
			ps.setString(8, vo.getP_detail());
			ps.setString(9, vo.getP_info());
			ps.setString(10, vo.getP_image());
			ps.setString(11, "1");
			ps.execute();
			//System.out.println(vo.toString());
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
	}
	
	//장소리스트 출력
	public JSONObject list(SqlVO vo) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="{call list(?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=DB.con.prepareCall(sql);
			cs.setString(1, "place");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setInt(4, vo.getPage());
			cs.setInt(5, vo.getPerpage());
			cs.setString(6, vo.getOrder());
			cs.setString(7, vo.getDesc());
			cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
			cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);
			cs.execute();
			
			ResultSet rs=(ResultSet)cs.getObject(8);
			JSONArray array=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("p_code", rs.getString("p_code"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("p_location", rs.getString("p_location"));
				obj.put("p_date", rs.getString("p_date"));
				obj.put("p_price", rs.getInt("p_price"));
				obj.put("p_person", rs.getInt("p_person"));
				obj.put("p_type", rs.getString("p_type"));
				obj.put("p_detail", rs.getString("p_detail"));
				obj.put("p_info", rs.getString("p_info"));
				obj.put("p_image", rs.getString("p_image"));
				obj.put("p_status", rs.getString("p_status"));
				array.add(obj);
			}
			jObject.put("array", array);
			
			int count=cs.getInt(9);
			jObject.put("count", count);
		}catch(Exception e) {
			System.out.println("에러 - "+e.toString());
		}
		return jObject;
	}
	
}
