package model;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/BoardReWriteProcCon.do")
public class BoardReWriteProcCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		int ref = Integer.parseInt(request.getParameter("ref"));
		int re_step = Integer.parseInt(request.getParameter("re_step"));
		int re_level = Integer.parseInt(request.getParameter("re_level"));
		
		BoardDTO bean = new BoardDTO();

		bean.setWriter(request.getParameter("writer"));
		bean.setEmail(request.getParameter("email"));
		bean.setSubject(request.getParameter("subject"));
		bean.setPassword(request.getParameter("password"));
		bean.setContent(request.getParameter("content"));
		bean.setRef(ref);
		bean.setRe_step(re_step);
		bean.setRe_level(re_level);
		
		//데이터 베이스에 저장
		BoardDAO bdao = new BoardDAO();
		bdao.reInsertBoard(bean);
		
		RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
		dis.forward(request, response);
		
	}

}
