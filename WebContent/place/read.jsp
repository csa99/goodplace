<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<br/><h2>π μ₯μμ λ³΄ π</h2><br/>
<c:if test="${user.u_id=='manager'}">
<form name="frm" enctype="multipart/form-data">
	<table id="tbl">
		<tr>
			<th width=150>μ₯μμ½λ</th>
			<td ><input type="text" name="p_code" value="${vo.p_code}" size=45 readonly/></td>
			<th width=150>μ₯μλͺ</th>
			<td colspan=3><input type="text" name="p_name" value="${vo.p_name}" size=50/></td>
		</tr>
		<tr>
			<th>μ§μ­</th>
			<td><input type="text" name="p_location" value="${vo.p_location}" size=45 /></td>
			<th>μμ½κ°λ₯μΌ</th>
			<td colspan=3>
				<input type="text" name="yy" value="${yy}" size=2 /> - 
				<input type="text" name="MM" value="${MM}" size=1 /> - 
				<input type="text" name="dd" value="${dd}" size=1 />
			</td>
		</tr>
		<tr>
			<th>μ΄μ©κ°κ²©</th>
			<td><input type="text" name="p_price" size=41 value="${vo.p_price}" /> μ</td>
			<th>μ΅λμΈμ</th>
			<td colspan=3><input type="text" name="p_person" size=46 value="${vo.p_person}" /> λͺ</td>
		</tr>
		<tr>
			<th>μμ€λνμλ΄</th>
			<td>
				<label><input type="radio" name="p_info" value="μΈν°λ·/WIFI" <c:out value="${vo.p_info=='μΈν°λ·/WIFI'?'checked':''}"/>> μΈν°λ·/WIFIπ</label>
				<label><input type="radio" name="p_info" value="μ£Όμ°¨κ°λ₯" <c:out value="${vo.p_info=='μ£Όμ°¨κ°λ₯'?'checked':''}"/>> μ£Όμ°¨κ°λ₯π</label><br/>
				<label><input type="radio" name="p_info" value="λ΄λΆ νμ₯μ€" <c:out value="${vo.p_info=='λ΄λΆ νμ₯μ€'?'checked':''}"/>> λ΄λΆ νμ₯μ€π½</label>
				<label><input type="radio" name="p_info" value="μμλ¬Ό λ°μκ°λ₯" <c:out value="${vo.p_info=='μμλ¬Ό λ°μκ°λ₯'?'checked':''}"/>> μμλ¬Ό λ°μκ°λ₯π₯</label>
			</td>
			<th>κ³΅κ°νμ</th>
			<td>
				<select name="p_type">
					<option value="μ€ν°λλ£Έ" <c:out value="${vo.p_type=='μ€ν°λλ£Έ'?'selected':''}"/>>μ€ν°λλ£Έ</option>
					<option value="νν°λ£Έ" <c:out value="${vo.p_type=='νν°λ£Έ'?'selected':''}"/>>νν°λ£Έ</option>
					<option value="μ°μ΅μ€" <c:out value="${vo.p_type=='μ°μ΅μ€'?'selected':''}"/>>μ°μ΅μ€</option>
					<option value="μ΄¬μμ€νλμ€" <c:out value="${vo.p_type=='μ΄¬μμ€νλμ€'?'selected':''}"/>>μ΄¬μμ€νλμ€</option>
					<option value="λλ¦½μ€νΌμ€" <c:out value="${vo.p_type=='λλ¦½μ€νΌμ€'?'selected':''}"/>>λλ¦½μ€νΌμ€</option>
				</select>
			</td>
			<th width=110>μμ½μν</th>
			<td>
				<label><input type="checkbox" name="p_status" <c:out value="${vo.p_status=='0'?'checked':''}"/>>μμ½μλ£</label>
			</td>
		</tr>
		<tr>
			<th>μνμ΄λ―Έμ§</th>
			<td>
				<input type="file" name="p_image" style="display:none;" accept="image/*"/>
				<c:if test="${vo.p_image==null}">
               		<img src="/noimage.jpg" width=320 id="image"/>
            	</c:if>
            	<c:if test="${vo.p_image!=null}">
					<img src="/place/img/${vo.p_image}" id="image" width=300 />
				</c:if>
			</td>
			<th>μμΈμ€λͺ</th>
			<td colspan=3>
				<textarea rows="12" cols="52" name="p_detail" >${vo.p_detail}</textarea>
			</td>
		</tr>
	</table>
	<br/><div id="pagination">
		<input type="submit" value="μ₯μμμ " />
		<input type="reset" value="λ±λ‘μ·¨μ" />
		<input type="button" value="μ₯μμ­μ " id="btnDelete"/>
		<input type="button" value="λͺ©λ‘μ΄λ" onClick="location.href='/place/list'"/>
	</div>
</form>
</c:if>
<c:if test="${user.u_id!='manager'}">
<form name="frm" enctype="multipart/form-data">
	<table id="tbl" style="text-align:justify;">
		<tr>
			<th width=170>μ₯μμ½λ</th>
			<td width=300>${vo.p_code}</td>
			<th width=170>μ₯μλͺ</th>
			<td width=300>${vo.p_name}</td>
		</tr>
		<tr>
			<th width=150>μ§μ­</th>
			<td width=200>${vo.p_location}</td>
			<th width=150>μμ½κ°λ₯μΌ</th>
			<td colspan=3>${yy}λ  ${MM}μ  ${dd}μΌ</td>
		</tr>
		<tr>
			<th>μ΄μ©κ°κ²©</th>
			<td>${vo.p_price}μ</td>
			<th>μ΅λμΈμ</th>
			<td colspan=3>${vo.p_person}λͺ</td>
		</tr>
		<tr>
			<th>μμ€λνμλ΄</th>
			<td>${vo.p_info}</td>
			<th>κ³΅κ°νμ</th>
			<td>${vo.p_type}</td>
		</tr>
		<tr>
			<th>μνμ΄λ―Έμ§</th>
			<td>
				<c:if test="${vo.p_image==null}">
               		<img src="/noimage.jpg" width=320 id="image" />
            	</c:if>
            	<c:if test="${vo.p_image!=null}">
					<img src="/place/img/${vo.p_image}" id="image" width=300 />
				</c:if>
			</td>
			<th>μμΈμ€λͺ</th>
			<td colspan=3>${vo.p_detail}</td>
		</tr>
	</table>
	<br/><div id="pagination">
		<input type="button" value="λͺ©λ‘μ΄λ" onClick="location.href='/place/list'"/>
	</div>
</form>
</c:if>

<script>

	//μμ½μν λ³κ²½ μ
	$(frm.p_status).on("click", function(){
		if($(frm.p_status).is(":checked")){
			$(frm.p_status).val(0);
		}else {
			$(frm.p_status).val(1);
		}
	});

	//μνμμ νκΈ°
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("μ₯μμ λ³΄λ₯Ό μμ ν κΉμ?")) return;
		frm.action="/place/update";
		frm.method="post";
		frm.submit();
	});
	
	//μνμ­μ νκΈ°
	$("#btnDelete").on("click", function(){
		if(!confirm("μ₯μμ λ³΄λ₯Ό μ­μ ν κΉμ?")) return;
		location.href="/place/delete?p_code="+"${vo.p_code}";
	});

	$("#image").on("click", function(){
		$(frm.p_image).click();
	});
	
	//μ΄λ―Έμ§ λ―Έλ¦¬λ³΄κΈ°
	$(frm.p_image).on("change", function(){
		var reader=new FileReader();
		reader.onload=function(e){
			$("#image").attr("src", e.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	});
	
</script>