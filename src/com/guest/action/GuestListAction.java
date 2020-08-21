package com.guest.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.guest.model.GuestDAO;
import com.guest.model.GuestDTO;
import com.guest.model.PageUtil;

/**
 * Servlet implementation class GuestListAction
 */
@WebServlet("/guestbook/list.gb")
public class GuestListAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GuestListAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		GuestDAO dao = GuestDAO.getInstance();
		String pageNum =request.getParameter("pageNum")
				==null?"1":request.getParameter("pageNum");
		String field = request.getParameter("field")
				==null?"":request.getParameter("field");
		String word = request.getParameter("word")
				==null?"":request.getParameter("word");
		int currentPage = Integer.parseInt(pageNum);
		int pageSize =5;
		int startRow = (currentPage-1)*pageSize+1;
		int endRow = currentPage*pageSize;
		
		
		int count =dao.guestCount(field,word);
		//ÃÑÆäÀÌÁö¼ö 
		int totPage = (count/pageSize)+(count%pageSize==0?0:1);
		int pageBlock =3;
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;//1 4 7
		int endPage= startPage+pageBlock-1;
		if(endPage>totPage) endPage=totPage;
		
		PageUtil pu = new PageUtil();
		pu.setCurrentPage(currentPage);
		pu.setEndPage(endPage);
		pu.setStartPage(startPage);
		pu.setTotPage(totPage);
		pu.setField(field);
		pu.setWord(word);
		
		ArrayList<GuestDTO> arr = null; 
		if(word.equals("")) {		
		arr = dao.guestlist(startRow, endRow);
		}else {
			arr = dao.guestlist(field, word, startRow, endRow);
		}
		int rowNo = count-((currentPage-1)*pageSize);
		
		request.setAttribute("rowNo", rowNo);
		request.setAttribute("pu", pu);
		request.setAttribute("arr", arr);
		request.setAttribute("count", count);
		
		RequestDispatcher
				rd = request.getRequestDispatcher("listResult.jsp");
		rd.forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			doGet(request, response);
	}

}
