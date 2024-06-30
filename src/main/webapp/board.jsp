<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
<!-- jQuery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$('input').css('border', 'none');
	
	// 폼 submit 이벤트
	$('#submitBtn').on('click', function(e){
		e.preventDefault();
		
		// 입력값 추출해서 객체 생성
		let board = {
		    bno: $('#bno').val(),
		    title: $('#title').val(),
		    content: $('#content').val(),
		    memberId: $('#memberId').val(),
		    hitNo: $('#hitNo').val(),
		    regDate: $('#regDate').val()
		};
		// JSON 객체로 변환
		let jsonBoard = JSON.stringify(board);
		console.log('jsonBoard: ', jsonBoard);
		
		//ajax
		$.ajax({
			url : '<c:url value="/insertBoard"/>',
			type: 'post',
			data: jsonBoard,
			dataType: 'json',
			contentType: 'application/json; charset=UTF-8',
			
			// jquery가 자동으로 받은 jsonString -> 자바 객체로 바꿔줌
			success: function(response){
				// console.log(response);
				// 테이블 헤더 출력 (테이블요소가 0개인 경우)
				if ($('#result table').length === 0) {
					let tableHeader = `
						<table border="1">
							<thead>
								<tr>
									<th>순번</th>
									<th>제목</th>
									<th>작성자</th>
									<th>조회수</th>
									<th>등록일</th>
								</tr>
							<thead>
							<tbody>
							</tbody>
						</table>
						`;
					$('#result').html(tableHeader);
				}
				
				// 새로운 행 추가
				let newRow = `
					<tr>
						<td>\${response.bno}</td>
						<td>\${response.title}</td>
						<td>\${response.memberId}</td>
						<td>\${response.hitNo}</td>
						<td>\${response.regDate}</td>
					</tr>
				`;
				$('#result tbody').append(newRow);
			},
			error: function(xhr, status, error){
				console.error('Error' + error);
				alert('게시물 등록 중 오류가 발생했습니다.');
			}
		}); // end of ajax
	}); // end of $('#submitBtn').on
}); // end of $(function(){
</script>

</head>
<body>
<form id="boardForm">
		<table border="1">
			<thead>
				<tr>
					<th colspan="2">게시물 등록</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>bno</th>
					<td><input type="text" name="bno" id="bno"></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" name="title" id="title"></td>
				</tr>
				<tr>
					<th>content</th>
					<td><input type="text" name="content" id="content"></td>
				</tr>
				<tr>
					<th>memberId</th>
					<td><input type="text" name="memberId" id="memberId"></td>
				</tr>
				<tr>
					<th>hitNo</th>
					<td><input type="text" name="hitNo" id="hitNo"></td>
				</tr>
				<tr>
					<th>regDate</th>
					<td><input type="text" name="regDate" id="regDate"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<button type="submit" id="submitBtn">등록버튼</button>
	</form>
	<br>
	<div id="result"></div>
</body>
</html>