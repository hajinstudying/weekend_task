package com.javalab.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.javalab.vo.MemberVO;

/**
 * 회원등록 처리 서블릿
 */
@WebServlet("/insertMember")
public class InsertMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertMemberServlet() {
        super();
    }
    
	/* 회원등록 처리*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("InsertMemberServlet의 doPost()");
		
		// Gson 객체 생성 후 json -> 자바객체로 변환
		Gson gson = new Gson();
		MemberVO member = gson.fromJson(request.getReader(), MemberVO.class);
		System.out.println("변환된 member 자바객체 : " + member);
		
		// DB저장처리 (안함)
		
		// 응답 인코딩 및 MIME 타입 설정
		response.setContentType("application/json; charset=utf-8");

		// 다시 JSON으로 변환 후 웹브라우저로 전송
		String jsonString = gson.toJson(member);
		PrintWriter out = response.getWriter();
		out.print(jsonString);
		out.flush();
	}
}
