package com.javalab.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.javalab.vo.BoardVO;

/**
 * 게시물 등록 처리 서블릿
 */
@WebServlet("/insertBoard")
public class InsertBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertBoardServlet() {
        super();
    }


	/* 게시물 등록 처리*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("InsertBoardServlet의 doPost()");
		
		//Gson 객체 생성 후 json -> 자바객체로 변환
		Gson gson = new Gson();
		BoardVO board = gson.fromJson(request.getReader(), BoardVO.class);
		System.out.println("변한된 board 자바객체 : " + board);
		
		// DB저장처리 (안함)
		
		// 응답 인코딩 및 MIME 타입 설정
		response.setContentType("application/json; charset=UTF-8");
		
		// 다시 JSON으로 변환 후 웹브라우저로 전송
		String jsonString = gson.toJson(board);
		PrintWriter out = response.getWriter();
		out.print(jsonString);
		out.flush();
	}
}
