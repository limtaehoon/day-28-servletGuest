package com.guest.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.guest.model.GuestDAO;

/**
 * Servlet implementation class GuestLoginAction
 */
@WebServlet("/guestbook/login.gb")
public class GuestLoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GuestLoginAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String userid =request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		GuestDAO dao = GuestDAO.getInstance();
		int flag = dao.guestLoginCheck(userid, pwd);
		String path ="";
		if(flag==1) {
			HttpSession session =request.getSession();
			session.setAttribute("login", userid);
			path="insert.jsp";
					
		}else if(flag==0){
			request.setAttribute("errMsg","È¸¿ø¾Æ´Ô");
			path="login.jsp";
			
		}else if(flag==-1){
			request.setAttribute("errMsg","ºñ¹Ð¹øÈ£ ¾Æ´Ô");
			path="login.jsp";
		}else if(flag==1) {
			request.setAttribute("errMsg","¾ÆÀÌµð ¾Æ´Ô");
			path="login.jsp";
		}
		RequestDispatcher rd
			= request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
