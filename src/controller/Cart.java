package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.OrdersVO;

@WebServlet(value={"/cart/list", "/cart/insert", "/cart/update", "/cart/delete"})
public class Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		String path=request.getServletPath();
		RequestDispatcher dis=null;
		HttpSession session=request.getSession();
		ArrayList<OrdersVO> cartList=(ArrayList<OrdersVO>)session.getAttribute("cartList");
		if(cartList==null) cartList=new ArrayList<OrdersVO>();
		
		switch(path) {
		
		case "/cart/update":
			int r_time=Integer.parseInt(request.getParameter("r_time"));
			for(OrdersVO cart:cartList) {
				if(cart.getP_code().equals(request.getParameter("p_code"))) {
					cart.setR_time(r_time);
					break;
				}
			}
			session.setAttribute("cartList", cartList);
			//response.sendRedirect("/cart/list");
			break;
		
		case "/cart/delete":
			for(OrdersVO cart:cartList) {
				if(cart.getP_code().equals(request.getParameter("p_code"))) {
					cartList.remove(cart);
					break;
				}
			}
			session.setAttribute("cartList", cartList);
			//response.sendRedirect("/cart/list");
			break;
		
		case "/cart/list":
			request.setAttribute("pageName", "/cart/list.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
			
		case "/cart/insert":
			OrdersVO vo=new OrdersVO();
			vo.setP_type(request.getParameter("p_type"));
			vo.setP_code(request.getParameter("p_code"));
			vo.setP_date(request.getParameter("p_date"));
			vo.setP_name(request.getParameter("p_name"));
			vo.setP_price(Integer.parseInt(request.getParameter("p_price")));
			r_time=1;
	        for(OrdersVO cart:cartList) {//카트에 이미 담긴 상품인지 체크
	           if(cart.getP_code().equals(request.getParameter("p_code"))) {
	        	  r_time=cart.getR_time()+1; //수량을 1증가
	              cartList.remove(cart); //기존 상품삭제
	              break;
	           }
	        }
	        vo.setR_time(r_time);
			//System.out.println(vo.toString());
			cartList.add(vo);
			session.setAttribute("cartList", cartList);
			break;
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
