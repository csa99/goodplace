<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<c:if test="${user.u_id==null}">
	<br/><h2>📅 예약내역 📅</h2><br/>
	<table id="empty">
		<tr class="title"><th>😰 로그인이 필요한 페이지입니다 😰</th></tr>
	</table>
</c:if>
<c:if test="${user.u_id!=null}">
<br/><h2>📅 예약내역 📅</h2><br/>
<div id="divCondition">
	<div style="float:left;">
		<select id="key">
			<option value="r_code" selected>예약번호</option>
			<option value="u_name">예약자명</option>
			<option value="u_tel">예약자연락처</option>
			<option value="u_email">예약자이메일</option>
		</select>
		<input type="text" id="word" placeholder="검색어를 입력하세요."/>
		<span id="count"></span>
	</div>
	<div style="float:right;">
		<select id="order">
			<option value="r_code" selected>예약번호</option>
			<option value="u_name">예약자명</option>
		</select>
		<select id="desc">
			<option value="asc">오름차순</option>
			<option value="desc" selected>내림차순</option>
		</select>
		<select id="perpage">
			<option value="5" selected>5개씩출력</option>
			<option value="10">10개씩출력</option>
			<option value="15">15개씩출력</option>
			<option value="20">20개씩출력</option>
		</select>
	</div>
</div>

<br/><table id="placetbl"></table><br/>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<th width=100>예약번호</th>
		<th width=230>예약자명</th>
		<th width=150>예약자연락처</th>
		<th width=150>예약자이메일</th>
		<th width=150>예약접수일</th>
		<th>상세예약정보</th>
	</tr>
	{{#each array}}
	<tr class="row" r_paytype="{{r_paytype}}" r_status="{{r_status}}">
		<td class="r_code">{{r_code}}</td>
		<td class="u_name">{{u_name}}</td>
		<td class="u_tel">{{u_tel}}</td>
		<td class="u_email">{{u_email}}</td>
		<td class="r_date">{{r_date}}</td>
		<td><button>🔍</button></td>
	</tr>
	{{/each}}
</script>

<div id="pagination">
	<button id="btnPre"><b>이전</b></button>
	<span id="pageInfo"></span>
	<button id="btnNext"><b>다음</b></button>
</div><br/>

<hr/><br/>

<table id="orderinfo">
	<tr>
		<th class="title" width=100>예약자명</th>
		<td class="u_name" width=200></td>
		<th class="title" width=100>연락처</th>
		<td class="u_tel" width=200></td>
		<th class="title" width=100>이메일</th>
		<td class="u_email" width=200></td>
	</tr>
	<tr>
		<th class="title" width=100>결제방법</th>
		<td class="r_paytype" width=200></td>
		<th class="title" width=100>처리상태</th>
		<td class="r_status" width=200></td>
		<th class="title" width=100>예약접수일</th>
		<td class="r_date" width=200></td>
	</tr>
</table><br/>

<!-- 구매상품목록 -->
<table id="oplist"></table>
<script id="temp1" type="text/x-handlebars-template">
	<tr class="title">
		<th width=30>장소코드</th>
		<th width=150>장소명(타입)</th>
		<th width=80>이용예정일</th>
		<th width=50>시간당 금액</th>
		<th width=50>이용시간</th>
		<th width=80>총 금액</th>
	</tr>
	{{#each .}}
	<tr class="rows">
		<td width=50>{{p_code}}</td>
		<td width=150>{{p_name}}({{p_type}})</td>
		<td width=80>{{p_date}}</td>
		<td width=50>{{nf p_price}}원</td>
		<td width=50>{{r_time}}시간</td>
		<td width=80>{{nf sum}}원</td>
	</tr>
	{{/each}}
</script>
</c:if>

<script>

Handlebars.registerHelper("nf", function(p_price){
	var regexp = /\B(?=(\d{3})+(?!\d))/g; 
	return p_price.toString().replace(regexp, ",");
});

Handlebars.registerHelper("nf", function(sum){
	var regexp = /\B(?=(\d{3})+(?!\d))/g; 
	return sum.toString().replace(regexp, ",");
});

</script>

<script>
	var url="/reserve/list.json";
	
	$("#orderinfo").hide();
	
	$("#placetbl").on("click", ".row button", function(){
		$("#orderinfo").show();
		var row=$(this).parent().parent();
		$("#orderinfo .u_name").html(row.find(".u_name").html()); //클래스가 네임인 것 찾아서
		$("#orderinfo .u_tel").html(row.find(".u_tel").html()); 
		$("#orderinfo .u_email").html(row.find(".u_email").html());
		$("#orderinfo .r_date").html(row.find(".r_date").html());
		
		var paytype=row.attr("r_paytype")=="0" ? "무통장입금":"카드결제";
		$("#orderinfo .r_paytype").html(paytype);
		var status=row.attr("r_status")=="0" ? "예약접수":"예약완료";
		$("#orderinfo .r_status").html(status);
		
		//구매상품목록
		var r_code=row.find(".r_code").html();
		
		$.ajax({
			type:"get",
			url:"/reserve/oplist.json",
			data:{"r_code":r_code},
			dataType:"json",
			success:function(result){
				var temp=Handlebars.compile($("#temp1").html());
				$("#oplist").html(temp(result));
			}
		});
	});
</script>
<script src="/script.js"></script>