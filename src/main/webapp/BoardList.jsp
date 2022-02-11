<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>BBS List</title>
<!-- Bootstrap -->
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<style type="text/css">
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

/* #write {
	text-align: right;
	transform: translateX(-400px);
	
} */

.table {
	text-align: center;
	width: 900px;
	margin-left: auto;
	margin-right: auto;
}

.table > thead > tr > th {
	text-align: center;
}

/* 표 인스턴스 */
.table-hover > tbody > tr : hover {
	background-color: #e6ecff;
}

/* .table > tbody > tr > td {
	text-align: center;
} */

.table > tbody > tr > #title {
	text-align: left;
}

a {
	text-decoration: none;
}

.text-orange {
	color: orange;
	font-weight: 450;
}

</style>
</head>
<body>

<c:if test="${mas == 0 }">
<script type="text/javascript">
alert('수정 시 비밀번호가 일치하지 않습니다.);
</script>
</c:if>

<c:if test="${mas == 1 }">
<script type="text/javascript">
alert('삭제 시 비밀번호가 일치하지 않습니다.);
</script>
</c:if>


<%-- <div id="container">

<c:if test="${id != null }">
<%@ include file="loginOK.jsp" %>
</c:if>

<c:if test="${id == null }">
<%@ include file="login.jsp" %>
</c:if>

</div> --%>

<div id="list">
<h3><b>게시판(전체글 : ${count })</b></h3>

</div>

<!-- <div id="write" >
<a href="BoardWriteForm.jsp">글쓰기</a>
</div> -->

	<div id="mainList">
		<!-- table-striped : 선택하면 한줄 건너 배경색이 달라지는 기능 -->
		<!-- table-bordered : 모든 셀에 테두리가 만들어짐 -->
		<!-- table-hover : 마우스를 올리면 마우스 커서가 있는 행만 색이 변함 -->
		<table class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th width="150">번호</th>
					<th width="300">제목</th>
					<th width="150">작성자</th>
					<th width="150">작성일</th>
					<th width="150">조회수</th>
				</tr>
			</thead>

			<tbody>
				<c:set var="number" value="${number }" />
				<c:forEach var="bean" items="${v }">
					<tr height="40">
						<td width="50" align="center">${number }</td>

						<td width="300" align="left">
						<c:if test="${bean.re_step > 1 }">
								<c:forEach begin="1" end="${(bean.re_step - 1) * 5 }">
									&nbsp;
								</c:forEach>
						</c:if> 
						<a href="BoardInfoControl.do?num=${bean.num }">${bean.subject }</a>
						</td>

						<td width="100" align="center">${bean.writer }</td>
						<td width="150" align="center">${bean.reg_date }</td>
						<td width="80" align="center">${bean.readcount }</td>
					</tr>
					<c:set var="number" value="${number - 1 }" />
				</c:forEach>
				<tr>
				<td colspan="5" align="right">
				<button type="button" onclick="location.href='BoardWriteForm.jsp'">글쓰기</button>
				</td>
				</tr>
			</tbody>
		</table>
		<p/>
		<!-- 페이징 처리 구현	 -->
		<center>
			<c:if test="${count > 0 }">
				<!-- 		
		전체글 10개 1페이지
		전체글 34개 4페이지 -->
				<c:set var="pageCount"
					value="${count/pageSize+(count%pageSize==0 ? 0 : 1) }" />

				<!-- 시작페이지 숫자를 지정 -->
				<c:set var="startPage" value="${1 }" />

				<!-- 1~9페이지까지 또는 11, 12, 13 -->
				<c:if test="${currentPage%10 != 0 }">
					<fmt:parseNumber var="result" value="${currentPage/10 }"
						integerOnly="true" />
					<c:set var="startPage" value="${result * 10 + 1 }" />
				</c:if>

				<!-- 10 20 30 -->
				<%-- 				<c:if test="${currentPage%10 == 0 }">
					<fmt:parseNumber var="result" value="${currentPage/10 }" integerOnly="true" />
					<c:set var="startPage" value="${(result - 1) * 10 + 1 }" />
				</c:if>
				 --%>
				<!-- 화면에 보여질 페이지 처리 숫자 -->
				<c:set var="pageBlock" value="${10 }" />
				<!-- 첫번째 화면 기준  1 + 10 -1 = 10 -->
				<c:set var="endPage" value="${startPage + pageBlock - 1 }"></c:set>

				<c:if test="${endPage > pageCount}">
					<c:set var="endPage" value="${pageCount }" />
				</c:if>

				<!-- 이전페이지 -->
				<c:if test="${startPage>10 }">
					<a href="BoardListCon.do?pageNum=${startPage-10 }" style="text-decoration: none">[이전]</a>
				</c:if>

				<!-- 페이징 처리 -->
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<a class="text-${(currentPage == i)? 'orange' : 'normal' }" href="BoardListCon.do?pageNum=${i}" style="text-decoration: none">[${i}]</a>
				</c:forEach>

				<!-- 다음페이지 -->
				<c:if test="${endPage>10 }">
					<a href="BoardListCon.do?pageNum=${startPage+10 }" style="text-decoration: none">[다음]</a>
				</c:if>
			</c:if>
		</center>
	</div>
</body>
</html>