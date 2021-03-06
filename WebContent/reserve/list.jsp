<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<c:if test="${user.u_id==null}">
	<br/><h2>π μμ½λ΄μ­ π</h2><br/>
	<table id="empty">
		<tr class="title"><th>π° λ‘κ·ΈμΈμ΄ νμν νμ΄μ§μλλ€ π°</th></tr>
	</table>
</c:if>
<c:if test="${user.u_id!=null}">
<br/><h2>π μμ½λ΄μ­ π</h2><br/>
<div id="divCondition">
	<div style="float:left;">
		<select id="key">
			<option value="r_code" selected>μμ½λ²νΈ</option>
			<option value="u_name">μμ½μλͺ</option>
			<option value="u_tel">μμ½μμ°λ½μ²</option>
			<option value="u_email">μμ½μμ΄λ©μΌ</option>
		</select>
		<input type="text" id="word" placeholder="κ²μμ΄λ₯Ό μλ ₯νμΈμ."/>
		<span id="count"></span>
	</div>
	<div style="float:right;">
		<select id="order">
			<option value="r_code" selected>μμ½λ²νΈ</option>
			<option value="u_name">μμ½μλͺ</option>
		</select>
		<select id="desc">
			<option value="asc">μ€λ¦μ°¨μ</option>
			<option value="desc" selected>λ΄λ¦Όμ°¨μ</option>
		</select>
		<select id="perpage">
			<option value="5" selected>5κ°μ©μΆλ ₯</option>
			<option value="10">10κ°μ©μΆλ ₯</option>
			<option value="15">15κ°μ©μΆλ ₯</option>
			<option value="20">20κ°μ©μΆλ ₯</option>
		</select>
	</div>
</div>

<br/><table id="placetbl"></table><br/>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<th width=100>μμ½λ²νΈ</th>
		<th width=230>μμ½μλͺ</th>
		<th width=150>μμ½μμ°λ½μ²</th>
		<th width=150>μμ½μμ΄λ©μΌ</th>
		<th width=150>μμ½μ μμΌ</th>
		<th>μμΈμμ½μ λ³΄</th>
	</tr>
	{{#each array}}
	<tr class="row" r_paytype="{{r_paytype}}" r_status="{{r_status}}">
		<td class="r_code">{{r_code}}</td>
		<td class="u_name">{{u_name}}</td>
		<td class="u_tel">{{u_tel}}</td>
		<td class="u_email">{{u_email}}</td>
		<td class="r_date">{{r_date}}</td>
		<td><button>π</button></td>
	</tr>
	{{/each}}
</script>

<div id="pagination">
	<button id="btnPre"><b>μ΄μ </b></button>
	<span id="pageInfo"></span>
	<button id="btnNext"><b>λ€μ</b></button>
</div><br/>

<hr/><br/>

<table id="orderinfo">
	<tr>
		<th class="title" width=100>μμ½μλͺ</th>
		<td class="u_name" width=200></td>
		<th class="title" width=100>μ°λ½μ²</th>
		<td class="u_tel" width=200></td>
		<th class="title" width=100>μ΄λ©μΌ</th>
		<td class="u_email" width=200></td>
	</tr>
	<tr>
		<th class="title" width=100>κ²°μ λ°©λ²</th>
		<td class="r_paytype" width=200></td>
		<th class="title" width=100>μ²λ¦¬μν</th>
		<td class="r_status" width=200></td>
		<th class="title" width=100>μμ½μ μμΌ</th>
		<td class="r_date" width=200></td>
	</tr>
</table><br/>

<!-- κ΅¬λ§€μνλͺ©λ‘ -->
<table id="oplist"></table>
<script id="temp1" type="text/x-handlebars-template">
	<tr class="title">
		<th width=30>μ₯μμ½λ</th>
		<th width=150>μ₯μλͺ(νμ)</th>
		<th width=80>μ΄μ©μμ μΌ</th>
		<th width=50>μκ°λΉ κΈμ‘</th>
		<th width=50>μ΄μ©μκ°</th>
		<th width=80>μ΄ κΈμ‘</th>
	</tr>
	{{#each .}}
	<tr class="rows">
		<td width=50>{{p_code}}</td>
		<td width=150>{{p_name}}({{p_type}})</td>
		<td width=80>{{p_date}}</td>
		<td width=50>{{nf p_price}}μ</td>
		<td width=50>{{r_time}}μκ°</td>
		<td width=80>{{nf sum}}μ</td>
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
		$("#orderinfo .u_name").html(row.find(".u_name").html()); //ν΄λμ€κ° λ€μμΈ κ² μ°Ύμμ
		$("#orderinfo .u_tel").html(row.find(".u_tel").html()); 
		$("#orderinfo .u_email").html(row.find(".u_email").html());
		$("#orderinfo .r_date").html(row.find(".r_date").html());
		
		var paytype=row.attr("r_paytype")=="0" ? "λ¬΄ν΅μ₯μκΈ":"μΉ΄λκ²°μ ";
		$("#orderinfo .r_paytype").html(paytype);
		var status=row.attr("r_status")=="0" ? "μμ½μ μ":"μμ½μλ£";
		$("#orderinfo .r_status").html(status);
		
		//κ΅¬λ§€μνλͺ©λ‘
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