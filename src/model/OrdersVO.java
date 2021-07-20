package model;

public class OrdersVO extends PlaceVO {
	
	private String r_code;
	private String u_name;
	private int r_time;
	private int r_price;
	private int sum;
	
	public String getR_code() {
		return r_code;
	}
	public void setR_code(String r_code) {
		this.r_code = r_code;
	}
	public String getU_name() {
		return u_name;
	}
	public void U_name(String u_name) {
		this.u_name = u_name;
	}
	public int getR_time() {
		return r_time;
	}
	public void setR_time(int r_time) {
		this.r_time = r_time;
	}
	public int getR_price() {
		return r_price;
	}
	public void setR_price(int r_price) {
		this.r_price = r_price;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = r_time*r_price;
	}
	@Override
	public String toString() {
		return "OrdersVO [r_code=" + r_code + ", u_name=" + u_name + ", r_time=" + r_time + ", r_price=" + r_price
				+ ", sum=" + sum + "]";
	}
	
}
