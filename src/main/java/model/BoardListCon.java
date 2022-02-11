package model;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BoardListCon.do")
public class BoardListCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//한 화면에 보여지는 게시글의 숫자를 구현 = 10개씩 끊어서 보기
		int pageSize = 10;
		
		//현재 보여지는 페이지의 번호
		String pageNum = request.getParameter("pageNum");	//[1][2]...
		
		//pageNum의 null처리
		if(pageNum == null) {
			pageNum = "1";	//최신글을 가져옴
		}
		
		//총 게시글의 갯수를 지정
		int count = 0;
		
		//화면에 보여지는 글번호 숫자의 위치
		int number = 0;
		
		// 페이지 번호의 형 변환
		int currentPage = Integer.parseInt(pageNum);
		
		//DAO객체
		BoardDAO bdao = new BoardDAO();
		
		//총 게시글의 숫자를 가져옴
		count = bdao.getAllCount();
		
		//==============================================
		//현재 보여질 페이지의 시작번호
		//1페이지 => 1
		//2페이지 => 11
		//3페이지 => 21
		
		int startRow = (currentPage - 1)*pageSize + 1;
		int endRow = currentPage*pageSize;	//1*10=10; 2*10=20;
		
		//최신글 10개 기준으로 게시글을 리턴하는 메소드 호출
		Vector<BoardDTO> v = bdao.getAllBoard(startRow, endRow);
		
		//===============================================
		//start, end까지의 데이터만 가져옴
		//전체가 9개의 게시글일때 글의 줄 위치 => 9-(1-1)*10 = 9
		//11개의 게시글일때 글의 줄 위치 => 11-(2-1)*10 = 1
		//23번째 게시글의 줄 위치 = > 23-(3-1)*10=3
		
		number = count - (currentPage-1)*pageSize;
		
		//================================================
		//수정 삭제시, 비번 일치하지 않았을 경우 메시지
		String msg = (String)request.getAttribute("msg");
		
		//jsp페이지에서 사용할 데이터 저장
		request.setAttribute("number", number);
		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("msg", msg);
		
		RequestDispatcher dis = request.getRequestDispatcher("BoardList.jsp");
		dis.forward(request, response);
				

	}

}
