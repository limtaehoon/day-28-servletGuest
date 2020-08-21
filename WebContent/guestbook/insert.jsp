<%@page import="javafx.scene.control.Tab"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
$(document).ready(function(){
	ygetData(1,"","");//페이지 로드시 전체리스트 보기
	
	$("#btnsearch").on("click",function(){//검색버튼 클릭
		getData(1,$("#field").val(),$("#word").val());
	})
	
	$("#send").click(function(){
		if(${sessionScope.login==null}){
			alert("로그인을 하세요");
			return false;
		}
		var name = $("#name").val();
		var content = $("#content").val();
		var grade = $("input:radio[name=grade]:checked").val();
		var postString
		="name="+name+"&content="+content+"&grade="+grade
		$.ajax({
			type:"post",
			url:"create.gb",
			data:postString,
			success:function(d){
				//alert(d);
				$("#result").html(d);
				
			},
			beforeSend:showRequest,/*가기전에 이거먼저 처리 하라*/
			error:function(e){
				alert("error:"+e);
				}
		});//ajax
		})//send
})//document

//전체내용 보는함수
function getData(pageNum, field, word) {
	
	$.get("list.gb",{"pageNum":pageNum,"field":field,"word":word},
function(d){/*val()에서 괄호에 값들어가면 그 값으로 바뀜 테그는 html*/
		$("#result").html(d);	
	})
}
function showRequest() {
	if($("#name").val()==""){
		alert("이름을 입력");
		return false;
	}	
	if($("#content").val()==""){
		alert("내용을 입력");
		return false;
	}if($("input:radio[name=grade]:checked").length==0){
		alert("평가를 입력");
		return false;
	}
	return true;	
}
function textCount(obj,target) {//target:nameCount,contnetCount
	var len =$("#"+obj.id).val().length;//자기 자신(obj)의 길이
	if(obj.size<len){
		alert("글자수 초과");
		return false;
	}
	$("#"+target).text(len);//target 의 텍스트 길이
}
function fview(num) {
	alert(num);
	$.getJSON("view.gb",{"num":num},function(d){
		var htmlStr="";
		htmlStr+="<table>";
		htmlStr+="<tr>";
		htmlStr+="<td>작성자</td>";
		htmlStr+="<td>"+d.content+"</td>";
		htmlStr+="</tr>";
		htmlStr+="<tr>";
		htmlStr+="<td>작성일</td>";
		htmlStr+="<td>"+d.created+"</td>";
		htmlStr+="</tr>";
		htmlStr+="</table>";
		$("#view").html(htmlStr);
	});
	
}
//삭제하기
function fdelete(num, name) {
	if(confirm("["+name+"]의 게시물을 삭제할까요")){
	$.get("delete.gb?num="+num,function(d){
		$("#result").html(d);
	})
	
}
}
</script>
</head>
<body>
<c:if test="${sessionScope.login==null}">
<a href ="login.jsp">로그인</a>
</c:if>
<c:if test="${sessionScope.login!=null}">
	${login }님 반갑습니다.
	<a href="logout.gb">로그아웃</a>
</c:if>
<br/><br/>

<form method="post" action="create.gb">
<table  align="center" width=900px>
<tr>
		<td align="center">글쓴이</td> 
		<td>
		<input type="text" id="name" size = 20 name="name" 
		onkeyup="textCount(this,'nameCount')">
		*20글자이내
		(<span id="nameCount" style="color: red">0</span>)
	  </td>
</tr>
<tr>
<td align="center">내 용</td>
	<td>
	<input type="text" size="70" id="content" name="content" 
	onkeyup="textCount(this,'contentCount')">
	*20글자이내
		(<span id="contentCount" style="color: red">0</span>)
	</td>
</tr>
<tr>
	<td align="center">평가 </td>
	<td><input type="radio" name="grade" value="excellent"
	checked="checked">아주잘함(excellent)
	<input type="radio" name="grade" value="good"> 잘함(good)
	<input type="radio" name="grade" value="normal"> 보통(normal)
	<input type="radio" name="grade" value="fail"> 노력(fail)
	</td>
</tr>
<tr>
	<td colspan="2">
 	<input type="submit" value="sumbit전송" > 
 	<input type="button" value="ajax 버튼전송" id="send"> 
</td>
</tr>
<tr>

</tr>
</table>
</form>
<br><br>
<div align="right">
<form name="search" id="search">
<select name="field" id="field">
<option value="name">이름</option>
<option value="content">내용</option>
</select>
<input type="text" name="word" id="word">
<input type="button" value="찾기" id="btnsearch">
</form>
</div>
<br><br>
<div id="result" align="center"></div>
<hr>
<div id="view">
</div>


</body>
</html>