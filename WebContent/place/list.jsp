<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<br/><h2>👀 장소보기 👀</h2><br/>
<div id="divCondition">
	<div style="float:left;">
		<select id="key">
			<option value="p_code">--전체--</option>
			<option value="p_type" selected>장소타입</option>
		</select>
		<select id="word">
			<option value="" selected>--전체--</option>
			<option value="스터디룸">스터디룸</option>
			<option value="파티룸">파티룸</option>
			<option value="연습실">연습실</option>
			<option value="촬영스튜디오">촬영스튜디오</option>
			<option value="독립오피스">독립오피스</option>
		</select>
		<span id="count"></span>
	</div>
	<div style="float:right;">
		<select id="order">
			<option value="p_location">지역</option>
			<option value="p_name">장소명</option>
			<option value="p_person">인원수</option>
			<option value="p_price">이용가격</option>
			<option value="p_code" selected>장소코드</option>
		</select>
		<select id="desc">
			<option value="asc">오름차순</option>
			<option value="desc" selected>내림차순</option>
		</select>
		<select id="perpage">
			<option value="4">4개씩출력</option>
			<option value="8" selected>8개씩출력</option>
			<option value="12">12개씩출력</option>
			<option value="16">16개씩출력</option>
		</select>
	</div>
</div>

<div id="placetbl"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each array}}
	<div class="box" p_type="{{p_type}}" p_code="{{p_code}}" p_name="{{p_name}}" p_price={{p_price}}>
		<div class="p_location"><b>{{p_location}}</b></div>
		<div class="p_image"><img src="{{pntImage p_image}}" style="width:200px; height:140px; cursor:pointer;"
					  onClick="location.href='/place/read?p_code={{p_code}}'"/></div>
		<div class="p_code">{{p_code}}</div>
		<div class="p_name"><span><b>{{p_name}}</b></span></div>
		<div class="p_price">{{nf p_price}}원/1h기준</div>
		<div class="p_person">최대 {{p_person}}명</div>
		<div class="p{{p_status}}" style="font-size:12px; margin-top:5px;"><b>{{status p_status}}</b></div>
	</div>
	{{/each}}
</script>

<script>
	Handlebars.registerHelper("pntImage", function(p_image){
		if(!p_image){
			return "/noimage.jpg";
		}else{
			return "/place/img/"+p_image;
		}
	});

	Handlebars.registerHelper("nf", function(p_price){
		var regexp = /\B(?=(\d{3})+(?!\d))/g; 
		return p_price.toString().replace(regexp, ",");
	});
	
	Handlebars.registerHelper("status", function(p_status){
		if(p_status=="0"){
			return "예약완료❌";
		}else{
			return "예약가능⭕";
		}
	});
</script>

<div id="pagination">
	<button id="btnPre"><b>이전</b></button>
	<span id="pageInfo"></span>
	<button id="btnNext"><b>다음</b></button>
</div>

<script>

	var url="/place/list.json";
	
	$("#placetbl").on("click", ".box .p1", function(){
		var box=$(this).parent();
		var p_type=box.attr("p_type");
		var p_code=box.attr("p_code");
		var p_name=box.attr("p_name");
		var p_price=box.attr("p_price");
		var r_time=1;
		if(!confirm(p_name+"을(를) 찜목록에 추가할까요?")) return;
		
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{"p_type":p_type, "p_code":p_code, "p_name":p_name, "p_price":p_price, "r_time":r_time},
			success:function(){
				if(!confirm("찜목록으로 이동할까요?")) return;
				location.href="/cart/list";
			}
		});
	});

	
</script>
<script src="/script.js"></script>