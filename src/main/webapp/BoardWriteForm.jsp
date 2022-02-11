<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css" />

<style type="text/css">

container {
	width: 70%;
	margin: 0 auto;
	padding-top: 5%;
	text-align: center;
}

div>#paging {
	text-align: center;
}

/*애니메이션 처리 */
.hit {
	animation-name: blink; /* 애니메이션 이름 */
	animation-duration: 1.5s; /* 애니메이션 동작시간 */
	animation-timing-function: ease; /* 시작과 종료 부드럽게 처리 */
	animation-iteration-count: infinite; /* 무한반복 */
}

/* 애니메이션 지점 설정 */
@keyframes blink {
      from {color: white;}
      30% {color: yellow;}
      to {color: red; font-weight: bold;}
}

#list {
	text-align: center;
}   

#write {
	text-align: right;
}

.table {
	text-align: center;
	width: 900px;
	margin-left: auto;
	margin-right: auto;
	border-collapse: collapse;

}

.table > thead > tr > th {
	text-align: center;
}

.table > tbody > tr > th {
	text-align: center;
}

/* 표 인스턴스 */
.table-hover > tbody > tr : hover {
	background-color: #e6ecff;
}

.table > tbody > tr > td : hover {
	text-align: center;
}

.table > tbody > tr > #title {
	text-align: left;
}

a {
	text-decoration: none;
}

h3 {
	text-align: center;
}

/* input [type=text],
input [type=email],
input [type=password] {
	width: 100%;
	height: 100%;
	border: 0;
	background: transparent;
} */

input:focus, textarea:focus {     
	outline: none; 
	background: transparent;
	resize: none;
	border: none;
	}


</style>
<title>BBS Writer</title>
</head>
<body>
<div id="container">
<h3><b>게시글 입력하기</b></h3>
<p />
<form action="BoardWriteProcCon.do">
<center>
				<table class="table table-striped table-bordered table-hover">
					<tbody>
						<tr height="50">
							<th width="150" align="center">작성자</th>
							<td width="400" align="left">
							<input type="text" name="writer" size="60" style="width:100%; border:none; background: transparent" />
							</td>
						</tr>
						
						<tr height="50">
							<th width="150" align="center">제목</th>
							<td width="400" align="left">
							<input type="text" name="subject" size="60" style="width:100%; border: none; background: transparent" />
							</td>
						</tr>
						
						<tr height="50">
							<th width="150" align="center">이메일</th>
							<td width="400" align="left">
							<input type="email" name="email" size="60" style="width:100%; border: none; background: transparent" />
							</td>
						</tr>
						
						<tr height="50">
							<th width="150" align="center">비밀번호</th>
							<td width="400" align="left">
							<input type="password" name="password" size="60" style="width:100%; border: none; background: transparent" />
							</td>
						</tr>
						
						<tr height="50">
							<th width="150" align="center">글내용</th>
							<td width="400" align="left">
							<textarea rows="10" cols="50" name="content" style="width:100%; border: none; background: transparent" ></textarea>
							</td>
						</tr>
						
						<tr height="50">
							<th align="center" colspan="2">
								<input type="submit" value="글쓰기" />&nbsp;&nbsp;
								<input type="reset" value="다시작성" />&nbsp;&nbsp;
								<button type="button" onclick="locaiotn.href='BoardListCon.do'">전체 게시글 보기</button>
							</th>
						</tr>
					</tbody>
				</table>
			</center>
</form>
</div>
</body>
</html>