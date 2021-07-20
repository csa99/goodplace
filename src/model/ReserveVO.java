package model;

public class ReserveVO {
	
	private String r_code;
	private String u_name;
	private String u_tel;
	private String u_email;
	private String r_date;
	private String r_paytype;
	private String r_status;
	private String u_id;
	
	public String getR_code() {
		return r_code;
	}
	public void setR_code(String r_code) {
		this.r_code = r_code;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_tel() {
		return u_tel;
	}
	public void setU_tel(String u_tel) {
		this.u_tel = u_tel;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getR_date() {
		return r_date;
	}
	public void setR_date(String r_date) {
		this.r_date = r_date;
	}
	public String getR_paytype() {
		return r_paytype;
	}
	public void setR_paytype(String r_paytype) {
		this.r_paytype = r_paytype;
	}
	public String getR_status() {
		return r_status;
	}
	public void setR_status(String r_status) {
		this.r_status = r_status;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	
	@Override
	public String toString() {
		return "ReserveVO [r_code=" + r_code + ", u_name=" + u_name + ", u_tel=" + u_tel + ", u_email=" + u_email
				+ ", r_date=" + r_date + ", r_paytype=" + r_paytype + ", r_status=" + r_status + ", u_id=" + u_id + "]";
	}

}
