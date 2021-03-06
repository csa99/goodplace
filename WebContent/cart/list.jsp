<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${user.u_id==null}">
	<br/><h2>π μ°λͺ©λ‘ π</h2><br/>
	<table id="empty">
		<tr class="title"><th>π° λ‘κ·ΈμΈμ΄ νμν νμ΄μ§μλλ€ π°</th></tr>
	</table>
</c:if>
<c:if test="${user.u_id!=null}">
<br/><h2>π μ°λͺ©λ‘ π</h2><br/>
<c:if test="${cartList.size()==0 || cartList==null}">
	<table id="empty">
		<tr class="title"><th>π° μ°ν μ₯μκ° μμ΄μ π°</th></tr>
	</table>
</c:if>
<c:if test="${cartList.size()>0}">
	<div id="btn">
		<button id="btnAll"><b>μ μ²΄μ₯μμμ½</b></button>
		<button id="btnSel"><b>μ νμ₯μμμ½</b></button>
	</div>
	<table id="carttbl">
		<tr class="title">
			<th width=30><input type="checkbox" id="chkAll" /></th>
			<th width=80>μ₯μμ½λ</th>
			<th width=100>νμ</th>
			<th width=230>μ₯μλͺ</th>
			<th width=100>μκ°λΉ κΈμ‘</th>
			<th width=150>μ΄μ©μκ°</th>
			<th width=100>μμ½κΈμ‘</th>
			<th width=30>μ­μ </th>
		</tr>
		<c:forEach items="${cartList}" var="vo">
			<tr class="row">
				<td><input type="checkbox" class="chk" /></td>
				<td class="p_code">${vo.p_code}</td>
				<td class="p_type">${vo.p_type}</td>
				<td class="p_name">${vo.p_name}</td>
				<td class="p_price">${vo.p_price}</td>
				<td>
					<input type="text" value="${vo.r_time}" class="r_time" size=1 />μκ°
					<button class="btnUpdate">μμ </button>
				</td>
				<td class="sum">${vo.r_time*vo.p_price}</td>
				<td><button class="btnDelete">β</button></td>
			</tr>
		</c:forEach>
	</table><br/>
	<div id="orderInfo">
		<h2>π μμ½μ λ³΄ π</h2>
		<table id="tblOrder"></table>
		<script id="tempOrder" type="text/x-handlebars-template">
			<tr class="title">
				<th>μ₯μμ½λ</th>
				<th>μ₯μλͺ</th>
				<th>μκ°λΉ κΈμ‘</th>
				<th>μ΄μ©μκ°</th>
				<th>μμ½κΈμ‘</th>
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
					<th class="title" width=300>μμ½μλͺ</th>
					<td><input type="text" name="name" size=50 value="${user.u_name}"></td>
				</tr>
				<tr>
					<th class="title" width=300>μ΄λ©μΌ</th>
					<td><input type="text" name="email" size=50 value="${user.u_email}"/></td>
				</tr>
				<tr>
					<th class="title" width=300>μ νλ²νΈ</th>
					<td><input type="text" name="tel" size=50 value="${user.u_tel}" /></td>
				</tr>
				<tr>
					<th class="title" width=300>κ²°μ λ°©λ²</th>
					<td>
						<label><input type="radio" name="paytype" style="text-align:center;" value="0" checked />λ¬΄ν΅μ₯μκΈ</label>
						<label><input type="radio" name="paytype" style="text-align:center;" value="1" />μΉ΄λκ²°μ </label>
					</td>
				</tr>
			</table>
			<div id="btnbox" style="text-align:center; margin-top:20px;">
				<input type="submit" value="μμ½νκΈ°" />
				<input type="reset" value="μμ½μ·¨μ" />
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
	if(!confirm("μνμ μ£Όλ¬Έν κΉμ?")) return;
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

//μ μ²΄μν μ£Όλ¬Έ ν΄λ¦­ μ
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

//μ νμν μ£Όλ¬Έ ν΄λ¦­ μ
$("#btnSel").on("click", function(){
	if($("#carttbl .row .chk:checked").length==0){
		alert("μ νν μνμ΄ μμ΅λλ€.");
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

//μμ λ²νΌ ν΄λ¦­ μ
$("#carttbl").on("click", ".row .btnUpdate", function(){
	var row=$(this).parent().parent();
	var p_code=row.find(".p_code").html();
	var r_time=row.find(".r_time").val();
	if(!confirm(p_code+("μ μλμ μμ ν κΉμ?"))) return;
	
	$.ajax({
		type:"get",
		url:"/cart/update",
		data:{"p_code":p_code, "r_time":r_time},
		success:function(){
			alert("μμ μλ£!");
			location.href="/cart/list";
		}
	});
});

//μ­μ λ²νΌ ν΄λ¦­ μ
$("#carttbl").on("click", ".row .btnDelete", function(){
	var p_code=$(this).parent().parent().find(".p_code").html();
	if(!confirm(p_code+("μ(λ₯Ό) μ°λͺ©λ‘μμ μ­μ ν κΉμ?"))) return;
	$.ajax({
		type:"get",
		url:"/cart/delete",
		data:{"p_code":p_code},
		success:function(){
			alert("μ­μ μλ£!");
			location.href="/cart/list";
		}
	});
});

//μ μ²΄ μ νμ μ²΄ν¬ν κ²½μ°
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

//κ° νμ μ²΄ν¬λ°μ€λ₯Ό ν΄λ¦­ν κ²½μ°
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