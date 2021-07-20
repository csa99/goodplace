<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<br/><h2>📑 장소정보 📑</h2><br/>
<c:if test="${user.u_id=='manager'}">
<form name="frm" enctype="multipart/form-data">
	<table id="tbl">
		<tr>
			<th width=150>장소코드</th>
			<td ><input type="text" name="p_code" value="${vo.p_code}" size=45 readonly/></td>
			<th width=150>장소명</th>
			<td colspan=3><input type="text" name="p_name" value="${vo.p_name}" size=50/></td>
		</tr>
		<tr>
			<th>지역</th>
			<td><input type="text" name="p_location" value="${vo.p_location}" size=45 /></td>
			<th>예약가능일</th>
			<td colspan=3>
				<input type="text" name="yy" value="${yy}" size=2 /> - 
				<input type="text" name="MM" value="${MM}" size=1 /> - 
				<input type="text" name="dd" value="${dd}" size=1 />
			</td>
		</tr>
		<tr>
			<th>이용가격</th>
			<td><input type="text" name="p_price" size=41 value="${vo.p_price}" /> 원</td>
			<th>최대인원</th>
			<td colspan=3><input type="text" name="p_person" size=46 value="${vo.p_person}" /> 명</td>
		</tr>
		<tr>
			<th>시설대표안내</th>
			<td>
				<label><input type="radio" name="p_info" value="인터넷/WIFI" <c:out value="${vo.p_info=='인터넷/WIFI'?'checked':''}"/>> 인터넷/WIFI🌍</label>
				<label><input type="radio" name="p_info" value="주차가능" <c:out value="${vo.p_info=='주차가능'?'checked':''}"/>> 주차가능🚗</label><br/>
				<label><input type="radio" name="p_info" value="내부 화장실" <c:out value="${vo.p_info=='내부 화장실'?'checked':''}"/>> 내부 화장실🚽</label>
				<label><input type="radio" name="p_info" value="음식물 반입가능" <c:out value="${vo.p_info=='음식물 반입가능'?'checked':''}"/>> 음식물 반입가능🥗</label>
			</td>
			<th>공간타입</th>
			<td>
				<select name="p_type">
					<option value="스터디룸" <c:out value="${vo.p_type=='스터디룸'?'selected':''}"/>>스터디룸</option>
					<option value="파티룸" <c:out value="${vo.p_type=='파티룸'?'selected':''}"/>>파티룸</option>
					<option value="연습실" <c:out value="${vo.p_type=='연습실'?'selected':''}"/>>연습실</option>
					<option value="촬영스튜디오" <c:out value="${vo.p_type=='촬영스튜디오'?'selected':''}"/>>촬영스튜디오</option>
					<option value="독립오피스" <c:out value="${vo.p_type=='독립오피스'?'selected':''}"/>>독립오피스</option>
				</select>
			</td>
			<th width=110>예약상태</th>
			<td>
				<label><input type="checkbox" name="p_status" <c:out value="${vo.p_status=='0'?'checked':''}"/>>예약완료</label>
			</td>
		</tr>
		<tr>
			<th>상품이미지</th>
			<td>
				<input type="file" name="p_image" style="display:none;" accept="image/*"/>
				<c:if test="${vo.p_image==null}">
               		<img src="/noimage.jpg" width=320 id="image"/>
            	</c:if>
            	<c:if test="${vo.p_image!=null}">
					<img src="/place/img/${vo.p_image}" id="image" width=300 />
				</c:if>
			</td>
			<th>상세설명</th>
			<td colspan=3>
				<textarea rows="12" cols="52" name="p_detail" >${vo.p_detail}</textarea>
			</td>
		</tr>
	</table>
	<br/><div id="pagination">
		<input type="submit" value="장소수정" />
		<input type="reset" value="등록취소" />
		<input type="button" value="장소삭제" id="btnDelete"/>
		<input type="button" value="목록이동" onClick="location.href='/place/list'"/>
	</div>
</form>
</c:if>
<c:if test="${user.u_id!='manager'}">
<form name="frm" enctype="multipart/form-data">
	<table id="tbl" style="text-align:justify;">
		<tr>
			<th width=170>장소코드</th>
			<td width=300>${vo.p_code}</td>
			<th width=170>장소명</th>
			<td width=300>${vo.p_name}</td>
		</tr>
		<tr>
			<th width=150>지역</th>
			<td width=200>${vo.p_location}</td>
			<th width=150>예약가능일</th>
			<td colspan=3>${yy}년  ${MM}월  ${dd}일</td>
		</tr>
		<tr>
			<th>이용가격</th>
			<td>${vo.p_price}원</td>
			<th>최대인원</th>
			<td colspan=3>${vo.p_person}명</td>
		</tr>
		<tr>
			<th>시설대표안내</th>
			<td>${vo.p_info}</td>
			<th>공간타입</th>
			<td>${vo.p_type}</td>
		</tr>
		<tr>
			<th>상품이미지</th>
			<td>
				<c:if test="${vo.p_image==null}">
               		<img src="/noimage.jpg" width=320 id="image" />
            	</c:if>
            	<c:if test="${vo.p_image!=null}">
					<img src="/place/img/${vo.p_image}" id="image" width=300 />
				</c:if>
			</td>
			<th>상세설명</th>
			<td colspan=3>${vo.p_detail}</td>
		</tr>
	</table>
	<br/><div id="pagination">
		<input type="button" value="목록이동" onClick="location.href='/place/list'"/>
	</div>
</form>
</c:if>

<script>

	//예약상태 변경 시
	$(frm.p_status).on("click", function(){
		if($(frm.p_status).is(":checked")){
			$(frm.p_status).val(0);
		}else {
			$(frm.p_status).val(1);
		}
	});

	//상품수정하기
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("장소정보를 수정할까요?")) return;
		frm.action="/place/update";
		frm.method="post";
		frm.submit();
	});
	
	//상품삭제하기
	$("#btnDelete").on("click", function(){
		if(!confirm("장소정보를 삭제할까요?")) return;
		location.href="/place/delete?p_code="+"${vo.p_code}";
	});

	$("#image").on("click", function(){
		$(frm.p_image).click();
	});
	
	//이미지 미리보기
	$(frm.p_image).on("change", function(){
		var reader=new FileReader();
		reader.onload=function(e){
			$("#image").attr("src", e.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	});
	
</script>