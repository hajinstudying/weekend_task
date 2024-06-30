<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member</title>
<!-- jQuery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('input').css('border', 'none');
		
		// 순번 전역 변수
		let memberNo = 1;
		
		//폼 submit 이벤트
		$('#submitBtn').on('click', function(e){
			e.preventDefault();
			
			// 입력값 추출해서 객체 생성
			let member = {
					memberId: $('#memberId').val(),
					password: $('#password').val(),
					name: $('#name').val(),
					email: $('#email').val()
			};
			// JSON 문자열로 변환
			let jsonMember = JSON.stringify(member);
			// console.log('jsonMember:', jsonMember);
			
			// ajax
			$.ajax({
				url: '<c:url value="/insertMember"/>',
				type: 'POST',
				data: jsonMember,
				contentType: 'application/json; charset=UTF-8',
				dataType: 'json',
				
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
										<th>회원번호</th>
										<th>이름</th>
										<th>이메일</th>
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
							<td>\${memberNo++}</td>
							<td>\${response.memberId}</td>
							<td>\${response.name}</td>
							<td>\${response.email}</td>
						</tr>
					`;
					$('#result tbody').append(newRow);
				},
				error: function(xhr, status, error){
					console.error('Error' + error);
					alert('회원 입력 중 오류가 발생했습니다.');
				}
			}); // end of ajax			
		}); // end of $('#memberForm').on
	}); // end of $(function(){
</script>
</head>
<body>
	<form id="memberForm">
		<table border="1">
			<thead>
				<tr>
					<th colspan="2">회원정보 입력</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>memeberId</th>
					<td><input type="text" name="memberId" id="memberId"></td>
				</tr>
				<tr>
					<th>password</th>
					<td><input type="text" name="password" id="password"></td>
				</tr>
				<tr>
					<th>name</th>
					<td><input type="text" name="name" id="name"></td>
				</tr>
				<tr>
					<th>email</th>
					<td><input type="text" name="email" id="email"></td>
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