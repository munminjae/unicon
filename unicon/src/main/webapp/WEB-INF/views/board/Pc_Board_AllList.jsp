<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" />

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

<script>
	function fn_articleForm(isLogOn, articleForm, loginForm) {
		if (isLogOn != '' && isLogOn != 'false') {
			location.href = articleForm;
		} else {
			alert("로그인 후 글쓰기가 가능합니다.")
			location.href = loginForm + '?action=/board/articleForm2.do';
		}
	}
</script>
<title>PC 게시판</title>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
<div class="main main-raised">
	<div class="section section-basic">
		<div class="container">			
			<div class="container" align="center">
				<div style="float:left;">			
					<h2 class="title" align="left">PC Notice</h2>
					<h6 align="left">PC 플랫폼 게임 관련 내용만 작성해주세요.</h6>
				</div>
				<form id="searchForm" action="${contextPath}/board/Pc_Board_AllList.do" method="get">
					<div style="float:right;">
						<nav class="navbar navbar-expand-lg bg-white" style="margin-top:40px;">
							<div class="container" align="center">
								<div class="container">										
									<input type="text" class="form-control" placeholder="Search"
									name="searchKeyword"/>
								</div>
								<input type='hidden' name='currentPageNo' value="${pagingCreatorDTO.pagingDTO.currentPageNo}">
								<input type='hidden' name='recordsPerPage' value="${pagingCreatorDTO.pagingDTO.recordsPerPage}">
								<button type="submit" class="btn btn-white btn-just-icon btn-round">
									<i class="material-icons">search</i>
								</button>
							</div>
						</nav>
					</div>
					<div style="float:right;">
						<nav class="navbar navbar-expand-lg bg-white" style="margin-top:40px;">
							<div class="container" align="center">
								<select class="form-control selectpicker" data-style="btn btn-link"
								style="text-align-last:center;" name="searchType">
									<option value="T">제목</option>
									<option value="C">내용</option>
									<option value="I">글쓴이</option>
									<option value="TC">제목+내용</option>
									<option value="TI">제목+글쓴이</option>
									<option value="TCI">제목+내용+글쓴이</option>
								</select>
							</div>
						</nav>
					</div>
				</form>
				<!-- 도경 추가 -->
				<table class="table" id="dataTable" style="align-content:center;">
					<tr align="center">
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<c:if test="${noticeList!=null}">
						<c:forEach var="notice" items="${noticeList}" varStatus="noticeNum">
							<tr align="center">
								<td width="5%" style="color: blue; vertical-align:middle;">공지</td>
								<td width="35%" align="left" style="vertical-align:middle;">
									<span style="padding-right: 30px"></span>
									<a href="${contextPath}/board/noticeView.do?boardno=${notice.boardno}&status=${status}">${notice.title }</a>
								</td>
								<td width="10%" style="vertical-align:middle;">관리자</td>
								<td width="10%" style="vertical-align:middle;">
									<fmt:formatDate value="${notice.writedate}" pattern="YYYY-MM-dd HH:mm:ss" />
								</td>
								<td width="10%" style="vertical-align:middle;">${notice.viewcount}</td>
							</tr>
						</c:forEach>
					</c:if>
					<tbody>
						<c:choose>
							<c:when test="${boardList == null}">
								<tr height="10">
									<td colspan="4">
										<p align="center">
											<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
										</p>
									</td>
								</tr>
							</c:when>
							<c:when test="${boardList != null}">
								<c:forEach var="board" items="${boardList}" varStatus="boardNum">
									<tr align="center">
										<td width="5%" style="vertical-align:middle;">${boardNum.count}</td>											
										<td align='left' width="35%" style="vertical-align:middle;">
											<span style="padding-right: 30px"></span>
											<a class='cls1' href="${contextPath}/board/viewArticle2.do?boardNO=${board.boardNO}">${board.title}</a>
										</td>
										<td width="10%" style="vertical-align:middle;">${board.id}</td>
										<td width="10%" style="vertical-align:middle;">
											<fmt:formatDate value="${board.writeDate }" pattern="YYYY-MM-dd HH:mm:ss" />
										</td>
										<td width="10%" style="vertical-align:middle;">${board.viewCount}</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</tbody>
				</table>
				<div class="container" align="right">
					<button class ="btn btn-primary btn-round" onclick="javascript:fn_articleForm('${isLogOn}','${contextPath}/board/articleForm2.do','${contextPath}/member/loginForm.do')">
						<i class="material-icons">create</i>&nbsp;&nbsp;글쓰기
					</button>
					<button class="btn btn-primary btn-round"
                  onclick="location.href='${contextPath}/board/timeLineSelect.do'">
                  <i class="material-icons">timeline</i>&nbsp;&nbsp;타임라인
               </button>
				</div>
				<div class="container" align="center">
					<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
						<ul class="pagination justify-content-center">
							<!-- 맨 앞으로 버튼 -->
								<li class="page-item">
									<%-- <a href="${displayPagingNo - displayPagingNo + 1}" aria-controls="dataTable" class="page-link">맨 앞으로</a> --%>
									<a href="${pagingCreatorDTO.realFirstPageNO}"
									aria-controls="dataTable" class="page-link">맨 앞으로</a>
								</li>
								<!-- 이전으로 버튼 -->
								<c:if test="${pagingCreatorDTO.isPrev}">
									<li class="paginate_button page-item previous"
										id="dataTable_previous">
										<a href="${pagingCreatorDTO.startPageNo - pagingCreatorDTO.pageNoCnt}"
										aria-controls="dataTable" class="page-link">Previous</a>
									</li>
								</c:if>
								<c:forEach var="displayPagingNo"
									begin="${pagingCreatorDTO.startPageNo}"
									end="${pagingCreatorDTO.endPageNo }">
									<li class="paginate_button page-item ${pagingCreatorDTO.pagingDTO.currentPageNo == displayPagingNo ? 'active' : '' }">
										<a href="${displayPagingNo}" aria-controls="dataTable"
										class="page-link">${displayPagingNo}</a>
									</li>
								</c:forEach>
								<c:if test="${pagingCreatorDTO.isNext}">
									<li class="paginate_button page-item next" id="dataTable_next">
										<a href="${pagingCreatorDTO.endPageNo + 1 }"
										aria-controls="dataTable" class="page-link">Next</a>
									</li>
								</c:if>
								<!-- 맨 끝으로 버튼 -->
								<li class="paginate_button page-item">
									<a href="${pagingCreatorDTO.realMajimakPageNO - 1}"
									aria-controls="dataTable" class="page-link">맨 끝으로</a>
								</li>
							</ul>
						</div>
					</div>
				</div>						
			<form id="actionForm" action="${contextPath}/board/Pc_Board_AllList.do" method='get'>
				<input type='hidden' name='currentPageNo'
				value="${pagingCreatorDTO.pagingDTO.currentPageNo}">
				<input type='hidden' name='recordsPerPage'
				value="${pagingCreatorDTO.pagingDTO.recordsPerPage}">
				<input type='hidden' name='searchKeyword'
				value="${pagingCreatorDTO.pagingDTO.searchKeyword}">
				<input type='hidden' name='searchType'
				value="${pagingCreatorDTO.pagingDTO.searchType}">
			</form>
		</div>
	</div>
</div>
<jsp:include page="../bootstrap/footer.jsp"/>
</body>
<script type="text/javascript">
$(document).ready(function() {
	var actionForm = $("#actionForm");
	$(".page-link").on("click",function(e) {
		//클릭한 페이지번호의 <a>태그가 원래의 동작을 못하도록 함
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='currentPageNo']").val($(this).attr("href"));
		actionForm.submit(); //form을 보냄
	});
});

$(document).ready(function() {
	var actionForm = $("actionForm");
	$(".paginate_button a").on("click",function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='currentPageNo']").val($(this).attr("href"));
		actionForm.attr("action","${contextPath}/board01/listAllArticlesPaging");
		actionForm.submit();
	});
});
</script>
</html>