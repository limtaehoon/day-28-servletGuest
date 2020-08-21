<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
개수: ${count}
<table align="center" width="500px" border=1>
<thead>
<tr>
		<td>번호</td>
		<td>seq</td> 
		<td>이름</td>
		<td>평가</td>
		<td>날짜</td>
		<c:if test="${login!=null}">
		<td>삭제</td>
		</c:if>
</tr>
</thead>

<tbody>
 
    <c:forEach items ="${arr}" var="guest" varStatus="st"><%/*list.jsp의 모든 값을 members로 보냄  mem:변수*/ %>
    
   <tr>
	    <td>${rowNo-st.index}</td>
	    <td>${guest.num}</td>
	    <td><a href="javascript:fview(${guest.num})">${guest.name}</a></td>
	    <td>${guest.grade}</td>
	    <td>${guest.created}</td>
	    <c:if test="${sessionScope.login!=null}">
	    	<td><a href="javascript:fdelete(${guest.num},'${guest.name }')">삭제</a></td>
   		</c:if>
 	</tr>
    </c:forEach>
 </tbody>

</table>
<div align = "center">
<c:if test="${pu.startPage>pu.pageBlock }"><!-- 이전 -->
<a href="javascript:getData(${pu.startPage-pu.pageBlock },'${pu.field}','${pu.word}')">[이전]</a>
</c:if>
<c:forEach begin="${pu.startPage }" end="${pu.endPage }" var="i">
	<c:if test="${i==pu.currentPage }"><!-- 현재 페이지 -->
	<c:out value="${i}"/>
	</c:if>
	<c:if test="${i!=pu.currentPage }"><!-- 현재페이지가 아닌경우 링크부터 -->
	<a href ="javascript:getData(${i})">${i}</a>
	</c:if>
</c:forEach>
<c:if test="${pu.endPage<pu.totPage }"></c:if>
<a href ="javascript:getData(${pu.endPage+1},'${pu.field}','${pu.word}')">[다음]</a>
</div>