<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<br/><h2>✅ 장소등록 ✅</h2><br/>
<form name="frm" enctype="multipart/form-data">
	<table id="tbl">
		<tr>
			<th width=300>장소코드</th>
			<td ><input type="text" name="p_code" value="${p_code}" size=45 readonly/></td>
			<th width=300>장소명</th>
			<td><input type="text" name="p_name" placeholder="장소명을 입력해주세요." size=50/></td>
		</tr>
		<tr>
			<th>지역</th>
			<td><input type="text" name="p_location" placeholder="예)서울 서초동" size=45 /></td>
			<th>예약가능일</th>
			<td>
				<input type="text" name="yy" size=2 value="${yy}" placeholder="yyyy" />-
				<input type="text" name="MM" size=1 value="${MM}" placeholder="mm" />-
				<input type="text" name="dd" size=1 value="${dd}" placeholder="dd" />
			</td>
		</tr>
		<tr>
			<th>이용가격</th>
			<td><input type="text" name="p_price" size=41 placeholder="1시간 기준 가격을 입력해주세요."/> 원</td>
			<th>최대인원</th>
			<td><input type="text" name="p_person" size=46 placeholder="최대 인원수를 입력해주세요."/> 명</td>
		</tr>
		<tr>
			<th>시설대표안내</th>
			<td>
				<label><input type="radio" name="p_info" value="인터넷/WIFI" /> 인터넷/WIFI🌍</label>
				<label><input type="radio" name="p_info" value="주차가능" /> 주차가능🚗</label><br/>
				<label><input type="radio" name="p_info" value="내부 화장실" /> 내부 화장실🚽</label>
				<label><input type="radio" name="p_info" value="음식물 반입가능" /> 음식물 반입가능🥗</label>
			</td>
			<th>공간타입</th>
			<td>
				<select name="p_type">
					<option value="스터디룸">스터디룸</option>
					<option value="파티룸">파티룸</option>
					<option value="연습실">연습실</option>
					<option value="촬영스튜디오">촬영스튜디오</option>
					<option value="독립오피스">독립오피스</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>상품이미지</th>
			<td>
				<input type="file" name="p_image" style="display:none;" accept="image/*"/>
				<img src="/noimage.jpg" id="image" width=320 style="text-align:center;"/>
			</td>
			<th>상세설명</th>
			<td>
				<textarea rows="12" cols="52" name="p_detail" placeholder="추가 상세설명을 입력해주세요."></textarea>
			</td>
		</tr>
	</table>
	<br/><div id="pagination">
		<input type="submit" value="장소등록" />
		<input type="reset" value="등록취소" />
		<input type="button" value="목록이동" onClick="location.href='/place/list'"/>
	</div>
</form>

<script>
	$("#image").on("click", function(){
		$(frm.p_image).click();
	});
	
	//상품등록하기
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("상품을 등록할까요?")) return;
		frm.action="/place/insert";
		frm.method="post";
		frm.submit();
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