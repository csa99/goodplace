package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.OrdersVO;
import model.ReserveDAO;
import model.ReserveVO;
import model.SqlVO;
import model.UserinfoVO;

@WebServlet(value={"/reserve/list", "/reserve/list.json", "/reserve/oplist.json", "/reserve/insert", "/reserve/insert_place"})
public class Reserve extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ReserveDAO dao=new ReserveDAO();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		String path=request.getServletPath();
		RequestDispatcher dis=null;
		
		switch(path) {
		
		case "/reserve/oplist.json":
			out.println(dao.oplist(request.getParameter("r_code")));
			break;
		
		case "/reserve/list":
			request.setAttribute("pageName", "/reserve/list.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		
		case "/reserve/list.json":
			SqlVO svo=new SqlVO();
			svo.setKey(request.getParameter("key"));
			svo.setWord(request.getParameter("word"));
			svo.setPage(Integer.parseInt(request.getParameter("page")));
			svo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
			svo.setOrder(request.getParameter("order"));
			svo.setDesc(request.getParameter("desc"));
			
			HttpSession session=request.getSession();
			UserinfoVO userVO=(UserinfoVO)session.getAttribute("user");
			String id=userVO==null ? "" : userVO.getU_id();
			out.println(dao.list(svo, id));
			break;
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String path=request.getServletPath();
		
		switch(path) {
		
		case "/reserve/insert_place":
			OrdersVO ovo=new OrdersVO();
			ovo.setR_code(request.getParameter("r_code"));
			ovo.setP_code(request.getParameter("p_code"));
			ovo.setR_price(Integer.parseInt(request.getParameter("r_price")));
			ovo.setR_time(Integer.parseInt(request.getParameter("r_time")));
			dao.insert_place(ovo);
			//System.out.println(ovo.toString());
			break;
			
		case "/reserve/insert":
			HttpSession session=request.getSession();
			UserinfoVO userVO=(UserinfoVO)session.getAttribute("user");
			String id=userVO==null ? "" : userVO.getU_id();
			
			ReserveVO vo=new ReserveVO();
			vo.setU_name(request.getParameter("name"));
			vo.setU_tel(request.getParameter("tel"));
			vo.setU_email(request.getParameter("email"));
			vo.setR_paytype(request.getParameter("paytype"));
			vo.setU_id("user01");
			String r_code=dao.insert(vo, id);
			PrintWriter out=response.getWriter();
			out.print(r_code);
			
			//장바구니 비우기
			session=request.getSession();
			session.setAttribute("cartList", null);
			break;
		}
		
	}

}
