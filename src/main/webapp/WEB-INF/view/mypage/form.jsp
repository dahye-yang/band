<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="container mt-3">
	<h4>내 정보</h4>
	<div class="row gx-2">
		<!-- 반응형 웹 1번째 -->
		<!-- multipart/form-data기능을 처리하기 -->
		<div class="col-md-4 p-2">
		<form method="post" enctype="multipart/form-data"
			action="${pageContext.servletContext.contextPath }/my/profile">
			<input type="hidden" name="_method" value="put"/>
		<!-- 파일의 경우에는 get방식으로는 할수 없다. Body-->
			<h6>
				프로필 이미지
			</h6>
			<div>
				<img src="${fn:startsWith(sessionScope.logonAccount.profileImageUrl, '/upload') ? contextPath:'' }${sessionScope.logonAccount.profileImageUrl }" width="200"
					height="200" class="rounded-circle" style="cursor:pointer;"
					onclick="document.querySelector('#profileImage').click();"	
					id="profileImageView"
				/>
			</div>
			<!-- 미리보기 기능을 위해서 -->
			<div style="display:none">
				<input type="file" class="form-control" id="profileImage" accept="image/*" name="profileImage"/>
			</div>
			<h6>
				닉네임
			</h6>
			<div>
				<input type="text" class="form-control" value="${sessionScope.logonAccount.nickname }" name="nickname"/>
			</div>
			<div>
				<button type="submit" class="form-control btn btn-secondary mt-2">변경</button>
			</div>
		</form>
		</div>
		<!-- 반응형 웹 2번째 -->
		<div class="col-md-8 p-2">
				<h6>동네 설정</h6>
			<div style="height : 350px; background-color: #ddd" id="map"></div>
			<form action = "${pageContext.servletContext.contextPath }/settings" method="post">
				<input type="hidden" name="_method" value="patch"/>
			<div>
				<input type="text" class="form-control" id="address" name="address" readonly value="${sessionScope.logonAccount.address }"/>
					<input type="hidden" name="latitude" id="latitude" value="${sessionScope.logonAccount.latitude }" /> 
					<input type="hidden" name="longitude" id="longitude" value="${sessionScope.logonAccount.longitude }"/>
			</div>
			<div>
				<button type="submit" class="form-control btn btn-secondary mt-2">변경</button>
			</div>
			
			</form>
			
			
			
			</div>
		</div>
	</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=473e136e176bb93e3ce7b6dd00c8bfa9&libraries=services"></script>
<script>
	//이미지 미리보기 스크립트
	document.querySelector("#profileImage").onchange= function(e) {
		if(e.target.files[0]) {
			var fileReader = new FileReader();
			fileReader.readAsDataURL(e.target.files[0]);
			fileReader.onload = function(e) {
				console.log(e.target.result);
				document.querySelector("#profileImageView").src = e.target.result;
			}
		}
	};
	
	
</script>




