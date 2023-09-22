<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>rep_list</title>
    <!-- 신고 게시판 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
#title {
    width: 600px;
    height: 100px;
    background-color: white;
    text-align: center;
    margin : auto;
    margin-top:60px;
    color: #FFA629;
    font-family: 'Bagel Fat One', cursive;        
    text-shadow: 1px 1px 2px #D1D1D1;
    font-size: 60pt;
    border: none;
    padding-top: 10px;
    justify-content: center; /* 가로 가운데 정렬 */
    align-items: center; /* 세로 가운데 정렬 */
    display: flex; /* Flexbox 사용 */
}
#repWrapper{
        width: 1130px;
        margin: auto;
        font-family: 'Noto Sans KR', sans-serif;
    }
#repWrapper > ul > li:first-child {
        text-align: center;
        font-size:14pt;
        height:40px;
        vertical-align:middle;
        line-height:30px;
}
#liSearchOption {clear:both;}
#liSearchOption > div {
	margin:0 auto; 
	margin-top: 30px; 
	width:auto; 
	height:100px;
	display:flex;
	justify-content:center;
}
.center {
        text-align : center;
}

.sidebar {
	width: 15%;
	background-color: white;
	font-size: 15pt;
	float: left;
	text-align: left;
	padding: 20px;
	box-sizing: border-box;
	margin-top: 160px;
	margin-right: 10px;
}
.sidebar-menu li {
  margin-bottom: 10px;
  list-style-type: none; 
  text-align: left;
}
.sidebar-menu a {
  text-decoration: none;
  color: #333;
}
.table{
	width:1500px;
	margin:0 auto;
	float: right;
	margin-top: 100px;
	
}
footer{
		width:1920px;
		display:flex;
		margin:auto;
		margin-top:20px;
		margin-bottom: 20px;
	}
	
/* paging */
.paging{
	text-align: center;
}

table tfoot ol.paging {
	list-style: none;
	display:flex;
	justify-content:center;
}

table tfoot ol.paging li {
	float: left;
	margin-right: 8px;
	text-align: center;
}

table tfoot ol.paging li a {
	display: block;
	padding: 3px 7px;
	border: 1px solid #FFA629;
	color: #2f313e;
	font-weight: bold;
	
}

table tfoot ol.paging li a:hover {
	background: #FFA629;
	color: white;
	font-weight: bold;
}
.button{
	background-color: #FFA629;
	color: #f8f8ff;
	border: none;
	width: 80px;
    height: 40px;
    font-size: 15pt;
	border-radius: 10px;
}
</style>

<script type="text/javascript"
	 src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js">
</script>
<script type="text/javascript">
	function write_go() {
		//글쓰기로 이동하는 함수
		location.href = "/rep_insertForm.do";
		f.submit();
}  
</script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<!-- 헤더 구역 -->
	<header>
		<jsp:include page="../home/home_top.jsp" />
	</header>

<div id="repWrapper" style="width: 1920px;">
	<!-- 사이드바 구역 -->
	<div class="sidebar">
   <ul class="sidebar-menu">
      <li class="notice"><a href="/sup_list.do">공지사항</a></li>
      <hr>
      <li class="faq"><a href="/faq_list.do">자주 묻는 질문</a></li>
      <hr>
      <li class="qna" ><a href="/qna_list.do">1:1 문의</a></li>
      <hr>
      <li class="report" style="font-weight: bold;"><a href="/rep_list.do">신고</a></li>
     </ul>
  </div>
  <!-- 게시판 리스트 구역 -->
  <div>
	<p id="title">신고</p>
	</div>
  <div class="rep_list">
	<table class="table">
  <thead>
    <tr>
      <th scope="col">No.</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">작성 날짜</th>
    </tr>
  </thead>
  <tbody>
  <c:choose>
	<c:when test="${empty rep_list}">
		<tr>
			<td colspan="4"><h2 style="text-align: center;">자료가 존재하지 않습니다.</h2></td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="r" items="${rep_list}" varStatus="vs">
			<tr>
			<!-- 제목을 누르면 해당 게시글의 상세정보 페이지로 이동 -->
			<td>${r.rep_idx}</td>
			<td>
	
				<c:if test="${r.rep_lock == '1' }">
					<c:choose>
						
						<c:when test="${r.User_VO.user_id || r.User_VO.type == '0'}">
							<c:out value="${r.rep_title}"></c:out>
						</c:when>
						<c:otherwise>비밀글입니다.</c:otherwise>
					</c:choose>
				</c:if>
				<%--
				<c:if test="${r.rep_lock == '0' }">
					<c:out value="${r.rep_title }"></c:out>
				</c:if>
				 --%>
				<a href="/rep_onelist.do?rep_idx=${r.rep_idx}">${r.rep_title}</a>
			</td>
			<td>${r.user_id }</td>
			<td>${r.rep_date.substring(0,10)}</td>
			</tr>
		</c:forEach>
	</c:otherwise>
	</c:choose>
</tbody>
<tfoot>
	<tr>
		<td colspan="4">
			<ol class="paging"> 
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
						<li class="disable">이전으로</li>
					</c:when>
					<c:otherwise>
						<li><a
							href="/rep_list.do?cPage=${paging.beginBlock-paging.pagePerBlock }">이전으로</a></li>
					</c:otherwise>
				</c:choose>
				<!-- 페이지번호들 -->
				<c:forEach begin="${paging.beginBlock }"
					end="${paging.endBlock }" step="1" var="k">
					<!--  현재 페이지는 링크 X, 나머지 페이지는 해당 페이지로 이동하게 링크 처리 -->
					<c:if test="${ k == paging.nowPage}">
						<li class="now">${k}</li>
					</c:if>
					<c:if test="${ k != paging.nowPage}">
						<li><a href="/rep_list.do??cPage=${k}">${k}</a></li>
					</c:if>
				</c:forEach>

				<!-- 이후 버튼 -->
				<c:choose>
					<c:when test="${paging.endBlock >= paging.totalPage }">
						<li class="disable">다음으로</li>
					</c:when>
					<c:otherwise>
						<li><a
							href="/rep_list.do?cPage=${paging.beginBlock+paging.pagePerBlock }">다음으로</a></li>
					</c:otherwise>
				</c:choose>
			</ol>
		</td>
		<td>
        	<input type="button" value="글쓰기" class="button" onclick=" write_go()">
       </td>
	</tr>
	 
</tfoot>
</table>
</div>
		<!-- 검색 창 구역  -->
		<center>
            <li id='liSearchOption' style="display: block;">
            	<form action="qnasearch.do?page=1" method="post">
                <div>
                    <select name="searchtype" >
                        <option value="lo_list">제목</option>
                        <option value="lo_content">내용</option>
                        <option value="user_id">작성자</option>                        
                    </select>
                    <input type="search" name="keyword">
                    <input type="submit" value="검색" class="button">
                </div>
                </form>
             </li>
   </div>
	</center>
<footer>
		<jsp:include page="/WEB-INF/views/home/home_bottom.jsp" />
	</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>