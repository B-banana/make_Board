<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

to {
	color: red;
	font-weight: bold;
}

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

.table>thead>tr>th {
	text-align: center;
}

.table>tbody>tr>th {
	text-align: center;
}

/* 표 인스턴스 */
.table-hover>tbody>tr : hover {
	background-color: #e6ecff;
}

.table>tbody>tr>td : hover {
	text-align: center;
}

.table>tbody>tr>#title {
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
<title>Insert title here</title>
</head>
<body>
<center>
<h2> 게시글 삭제 하기 </h2>
<form action="BoardDeleteProcCon.do" method="post" >
<table border="1" width="600" bgcolor="ivory">
		
<tr height="40">
<td width="150" align="center"> 패스워드 </td>
<td width="450" colspan="3">&nbsp;<input type="password" name="password" size="60" style="border: none; background: transparent"></td>
</tr>

<tr height="40">
<td colspan="4" align="center">
<input type="submit" value="글삭제">&nbsp;&nbsp;
<input type="button" onclick="location.href='BoardListCon.do'" value="전체글보기"></td>
</tr>

<tr height="40">
<td colspan="4">
<input type="hidden" name="num" value="${bean.num }" /> 
<input type="hidden" name="pass" value="${bean.password }" /> 
<input type="submit" value="삭제하기">&nbsp;
<input type="button" onclick="location.href='BoardListCon.do'" value="삭제취소">
</td>
</tr>
</table>
</form>
</center>
</body>
</html>