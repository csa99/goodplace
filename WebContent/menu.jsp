<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="menuItem"><a href="/place/list"><b>장소보기</b></a></div>
<div class="menuItem"><a href="/cart/list"><b>찜목록</b></a></div>
<div class="menuItem"><a href="/reserve/list"><b>예약내역</b></a></div>

<c:if test="${user.u_id=='manager'}">
	<div class="menuItem"><a href="/place/insert"><b>장소등록</b></a></div>
</c:if>

<div id="loginbox" style="float:right;">
	<c:if test="${user.u_id==null}">
		<form name="frmLogin" method="post" action="login">
			<span><b>ID</b></span> <input type="text" name="id" size=10/>
			<span><b>PW</b></span> <input type="password" name="pass" size=10/>
			<input type="submit" value="login" />
		</form>
	</c:if>
	<c:if test="${user.u_id!=null}">
		<div id="logBox">
			<b><span>${user.u_name}</span>님, 안녕하세요🙋‍♂️</b>
			<button onClick="location.href='/user/logout'">Logout</button>
		</div>
	</c:if>
</div>

<script>
	$(frmLogin).on("submit", function(e){
		e.preventDefault();
		var id=$(frmLogin.id).val();
		var pass=$(frmLogin.pass).val();
		
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{"id":id, "pass":pass},
			success:function(result){
				if(result==0){
					alert("아이디가 존재하지 않습니다.");
					$(frmLogin.id).focus();
				}else if(result==2){
					alert("비밀번호가 맞지 않습니다.");
					$(frmLogin.pass).focus();
				}else{
					//alert("로그인 성공!");
					location.href="/home";
				}
			}
		});
	});
</script>