package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.PlaceDAO;
import model.PlaceVO;
import model.SqlVO;

@WebServlet(value={"/home", "/place/list", "/place/list.json", "/place/insert", "/place/update", "/place/delete", "/place/read"})
public class Place extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	PlaceDAO dao=new PlaceDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		String path=request.getServletPath();
		RequestDispatcher dis=null;
		
		switch(path) {
		
		case "/place/delete":
			PlaceVO oldVO=dao.read(request.getParameter("p_code"));
			dao.delete(request.getParameter("p_code"));
			if(oldVO.getP_image()!=null) {
				File file=new File("C:/image/"+oldVO.getP_image());
				file.delete();
			}
			response.sendRedirect("/home");
			break;
		
		case "/place/read":
			PlaceVO v=dao.read(request.getParameter("p_code"));
			String date=v.getP_date();
			request.setAttribute("yy", date.substring(0, 4));
			request.setAttribute("MM", date.substring(5, 7));
			request.setAttribute("dd", date.substring(8, 10));
			request.setAttribute("vo", v);
			request.setAttribute("pageName", "/place/read.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		
		case "/place/insert":
			request.setAttribute("p_code", dao.getCode());
			request.setAttribute("pageName", "/place/insert.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
						
		case "/place/list":
			request.setAttribute("pageName", "/place/list.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		
		case "/place/list.json":
			SqlVO svo=new SqlVO();
			svo.setKey(request.getParameter("key"));
			svo.setWord(request.getParameter("word"));
			svo.setPage(Integer.parseInt(request.getParameter("page")));
			svo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
			svo.setOrder(request.getParameter("order"));
			svo.setDesc(request.getParameter("desc"));
			out.println(dao.list(svo));
			break;
			
		case "/home":
			request.setAttribute("pageName", "/place/home.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;		
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String path=request.getServletPath();
		
		MultipartRequest multi=new MultipartRequest(request,
				"c:/pimage", 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
		
		PlaceVO vo=new PlaceVO();
	
		vo.setP_code(multi.getParameter("p_code"));
		vo.setP_name(multi.getParameter("p_name"));
		vo.setP_location(multi.getParameter("p_location"));
		String yy=multi.getParameter("yy");
		String MM=multi.getParameter("MM");
		String dd=multi.getParameter("dd");
		vo.setP_date(yy+MM+dd);
		vo.setP_price(Integer.parseInt(multi.getParameter("p_price")));
		vo.setP_person(Integer.parseInt(multi.getParameter("p_person")));
		vo.setP_type(multi.getParameter("p_type"));
		vo.setP_detail(multi.getParameter("p_detail"));
		vo.setP_info(multi.getParameter("p_info"));
		vo.setP_image(multi.getFilesystemName("p_image"));
		String p_status=multi.getParameter("p_status")==null?"1":"0";
		vo.setP_status(p_status);
		//System.out.println(vo.toString());
		
		switch(path) {
		
		case "/place/update":
			PlaceVO oldVO=dao.read(vo.getP_code());
			if(multi.getFilesystemName("p_image")==null) { //새로 업로드한 이미지가 없는 경우
				vo.setP_image(oldVO.getP_image());
			}else { //새로 업로드한 이미지가 있는 경우
				if(oldVO.getP_image() != null) { //예전 이미지가 있는 경우
					File file=new File("c:/image/"+oldVO.getP_image());
					file.delete();
				}
			}
			dao.update(vo);
			break;			
		
		case "/place/insert":
			dao.insert(vo);
			break;			
		}
		response.sendRedirect("/home");
	}

}
