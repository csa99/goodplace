<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${user.u_id==null}">
	<br/><h2>💌 찜목록 💌</h2><br/>
	<table id="empty">
		<tr class="title"><th>😰 로그인이 필요한 페이지입니다 😰</th></tr>
	</table>
</c:if>
<c:if test="${user.u_id!=null}">
<br/><h2>💌 찜목록 💌</h2><br/>
<c:if test="${cartList.size()==0 || cartList==null}">
	<table id="empty">
		<tr class="title"><th>😰 찜한 장소가 없어요 😰</th></tr>
	</table>
</c:if>
<c:if test="${cartList.size()>0}">
	<div id="btn">
		<button id="btnAll"><b>전체장소예약</b></button>
		<button id="btnSel"><b>선택장소예약</b></button>
	</div>
	<table id="carttbl">
		<tr class="title">
			<th width=30><input type="checkbox" id="chkAll" /></th>
			<th width=80>장소코드</th>
			<th width=100>타입</th>
			<th width=230>장소명</th>
			<th width=100>시간당 금액</th>
			<th width=150>이용시간</th>
			<th width=100>예약금액</th>
			<th width=30>삭제</th>
		</tr>
		<c:forEach items="${cartList}" var="vo">
			<tr class="row">
				<td><input type="checkbox" class="chk" /></td>
				<td class="p_code">${vo.p_code}</td>
				<td class="p_type">${vo.p_type}</td>
				<td class="p_name">${vo.p_name}</td>
				<td class="p_price">${vo.p_price}</td>
				<td>
					<input type="text" value="${vo.r_time}" class="r_time" size=1 />시간
					<button class="btnUpdate">수정</button>
				</td>
				<td class="sum">${vo.r_time*vo.p_price}</td>
				<td><button class="btnDelete">❌</button></td>
			</tr>
		</c:forEach>
	</table><br/>
	<div id="orderInfo">
		<h2>📝 예약정보 📝</h2>
		<table id="tblOrder"></table>
		<script id="tempOrder" type="text/x-handlebars-template">
			<tr class="title">
				<th>장소코드</th>
				<th>장소명</th>
				<th>시간당 금액</th>
				<th>이용시간</th>
				<th>예약금액</th>
			</tr>
		{{#each .}}
			<tr class="row">
				<td class="pcode">{{p_code}}</td>
				<td>{{p_name}}</td>
				<td class="price">{{p_price}}</td>
				<td class="time">{{r_time}}</td>
				<td>{{sum}}</td>
			</tr>
		{{/each}}
		</script>
		<form name="frm">
			<br/><table id="tblInfo">
				<tr>
					<th class="title" width=300>예약자명</th>
					<td><input type="text" name="name" size=50 value="${user.u_name}"></td>
				</tr>
				<tr>
					<th class="title" width=300>이메일</th>
					<td><input type="text" name="email" size=50 value="${user.u_email}"/></td>
				</tr>
				<tr>
					<th class="title" width=300>전화번호</th>
					<td><input type="text" name="tel" size=50 value="${user.u_tel}" /></td>
				</tr>
				<tr>
					<th class="title" width=300>결제방법</th>
					<td>
						<label><input type="radio" name="paytype" style="text-align:center;" value="0" checked />무통장입금</label>
						<label><input type="radio" name="paytype" style="text-align:center;" value="1" />카드결제</label>
					</td>
				</tr>
			</table>
			<div id="btnbox" style="text-align:center; margin-top:20px;">
				<input type="submit" value="예약하기" />
				<input type="reset" value="예약취소" />
			</div>
		</form>
	</div>
</c:if>
</c:if>
<script>

Handlebars.registerHelper("nf", function(sum){
	var regexp = /\B(?=(\d{3})+(?!\d))/g; 
	return sum.toString().replace(regexp, ",");
});

</script>

<script>
$("#orderInfo").hide();

$(frm).on("submit", function(e){
	e.preventDefault();
	if(!confirm("상품을 주문할까요?")) return;
	var name=$(frm.name).val();
	var tel=$(frm.tel).val();
	var email=$(frm.email).val();
	var paytype=$("input[name='paytype']:checked").val();
	//alert(name+"\n"+tel+"\n"+email+"\n"+paytype);
	$.ajax({
		type:"post",
		url:"/reserve/insert",
		data:{"name":name, "tel":tel, "email":email, "paytype":paytype},
		success:function(r_code){
			$("#tblOrder .row").each(function(){
				var p_code=$(this).find(".pcode").html();
				var r_price=$(this).find(".price").html();
				var r_time=$(this).find(".time").html();
				//alert(r_code + "\n" +p_code + "\n" + r_price + "\n" + r_time);
				$.ajax({
					type:"post",
					url:"/reserve/insert_place",
					data:{"r_code":r_code, "p_code":p_code, "r_price":r_price, "r_time":r_time},
					success:function(){}
				});
			});
		}
	});
	frm.action="/reserve/list";
	frm.method="get";
	frm.submit();
});

//전체상품 주문 클릭 시
$("#btnAll").on("click", function(){
	$("#orderInfo").show();
	var array=[];
	$("#carttbl .row .chk").each(function(){
		var row=$(this).parent().parent();
		var p_code=row.find(".p_code").html();
		var p_name=row.find(".p_name").html();
		var p_price=row.find(".p_price").html();
		var r_time=row.find(".r_time").val();
		var sum=row.find(".sum").html();
		var data={"p_code":p_code, "p_name":p_name, "p_price":p_price, "r_time":r_time, "sum":sum};

		array.push(data);
	});
	//console.log(array);
	var temp=Handlebars.compile($("#tempOrder").html());
	$("#tblOrder").html(temp(array));
});

//선택상품 주문 클릭 시
$("#btnSel").on("click", function(){
	if($("#carttbl .row .chk:checked").length==0){
		alert("선택한 상품이 없습니다.");
		return;
	}
	$("#orderInfo").show();
	
	var array=[];
	$("#carttbl .row .chk:checked").each(function(){
		var row=$(this).parent().parent();
		var p_code=row.find(".p_code").html();
		var p_name=row.find(".p_name").html();
		var r_time=row.find(".r_time").val();
		var p_price=row.find(".p_price").html();
		var sum=row.find(".sum").html();
		var data={"p_code":p_code, "p_name":p_name, "p_price":p_price, "r_time":r_time, "sum":sum};
		array.push(data);
	});
	//console.log(array);
	var temp=Handlebars.compile($("#tempOrder").html());
	$("#tblOrder").html(temp(array));
});

//수정버튼 클릭 시
$("#carttbl").on("click", ".row .btnUpdate", function(){
	var row=$(this).parent().parent();
	var p_code=row.find(".p_code").html();
	var r_time=row.find(".r_time").val();
	if(!confirm(p_code+("의 수량을 수정할까요?"))) return;
	
	$.ajax({
		type:"get",
		url:"/cart/update",
		data:{"p_code":p_code, "r_time":r_time},
		success:function(){
			alert("수정완료!");
			location.href="/cart/list";
		}
	});
});

//삭제버튼 클릭 시
$("#carttbl").on("click", ".row .btnDelete", function(){
	var p_code=$(this).parent().parent().find(".p_code").html();
	if(!confirm(p_code+("을(를) 찜목록에서 삭제할까요?"))) return;
	$.ajax({
		type:"get",
		url:"/cart/delete",
		data:{"p_code":p_code},
		success:function(){
			alert("삭제완료!");
			location.href="/cart/list";
		}
	});
});

//전체 선택을 체크한 경우
$("#chkAll").on("click", function(){
	if($(this).is(":checked")){
		$("#carttbl .row .chk").each(function(){
			$(this).prop("checked", true);
		});
	}else{
		$("#carttbl .row .chk").each(function(){
			$(this).prop("checked", false);
		});
	}
});

//각 행의 체크박스를 클릭한 경우
$("#carttbl").on("click", ".row .chk", function(){
	var num1=$("#carttbl .row .chk").length;
	var num2=$("#carttbl .row .chk:checked").length;
	if(num1==num2){
		$("#chkAll").prop("checked", true);
	}else{
		$("#chkAll").prop("checked", false);
	}
});

</script>