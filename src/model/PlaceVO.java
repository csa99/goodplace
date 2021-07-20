package model;

public class PlaceVO {
	
	private String p_code;
	private String p_name;
	private String p_location;
	private String p_date;
	private int p_price;
	private int p_person;
	private String p_type;
	private String p_detail;
	private String p_info;
	private String p_image;
	private String p_status;
	
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_location() {
		return p_location;
	}
	public void setP_location(String p_location) {
		this.p_location = p_location;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public int getP_person() {
		return p_person;
	}
	public void setP_person(int p_person) {
		this.p_person = p_person;
	}
	public String getP_type() {
		return p_type;
	}
	public void setP_type(String p_type) {
		this.p_type = p_type;
	}
	public String getP_detail() {
		return p_detail;
	}
	public void setP_detail(String p_detail) {
		this.p_detail = p_detail;
	}
	public String getP_info() {
		return p_info;
	}
	public void setP_info(String p_info) {
		this.p_info = p_info;
	}
	public String getP_image() {
		return p_image;
	}
	public void setP_image(String p_image) {
		this.p_image = p_image;
	}
	public String getP_status() {
		return p_status;
	}
	public void setP_status(String p_status) {
		this.p_status = p_status;
	}
	
	@Override
	public String toString() {
		return "PlaceVO [p_code=" + p_code + ", p_name=" + p_name + ", p_location=" + p_location + ", p_date=" + p_date
				+ ", p_price=" + p_price + ", p_person=" + p_person + ", p_type=" + p_type + ", p_detail=" + p_detail
				+ ", p_info=" + p_info + ", p_image=" + p_image + ", p_status=" + p_status + "]";
	}
	
}
