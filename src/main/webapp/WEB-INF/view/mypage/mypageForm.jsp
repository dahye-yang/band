<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>my profile</title>
<style>
input::-webkit-inner-spin-button {
	appearance: none;
	-moz-appearance: none;
	-webkit-appearance: none;
}

.no_dot {
	list-style-type: none;
}
</style>
<link rel="styleshee" href="${pageContext.servletContext.contextPath }/resource/style/style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
</head>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<body>
	
	<div class="sticky-top" style="background-color: #F0F0F0">
		<div class="mx-auto" style="width: 1034px;">
			<div class="">
				<div class="d-flex justify-content-between" style="height: 55px;">
					<div
						class="d-flex justify-content-start gap-4 align-items-center">
						<div
							style="font-size: 20px; font-weight: bold; margin-top: 6px;">
							<a class="navbar-brand" href="${contextPath }/index"> 
								<img alt="밴드로고" src="${contextPath }/resource/band.png" width="80px" height="40">
							</a>
						</div>
						<div class="input-group">
							<input type="text" class="form-control"
								placeholder="밴드, 페이지, 게시글 검색"
								aria-label="Recipient's username"
								aria-describedby="button-addon2"
								style="font-size: 12px; width: 260px; height: 30px; margin-top: 5px">
							<button class="btn btn-outline-secondary" type="button"
								id="button-addon2"
								style="font-size: 12px; height: 29px; margin-top: 5px; border: none; background-color: white">
								<i class="bi bi-search"></i>
							</button>
						</div>
					</div>
					<div class="d-flex justify-content-end gap-4 align-items-center"
						style="color: black;">
						<div style="font-size: 13px">새글 피드</div>
						<div style="font-size: 13px">찾기</div>
						<div>
							<i class="bi bi-bell-fill"></i>
						</div>
						<div>
							<i class="bi bi-chat-dots-fill"></i>
						</div>
						<div class="dropdown">
							<button
								class="btn  dropdown-toggle rounded-circle"
								type="button" data-bs-toggle="dropdown" aria-expanded="false"
								style="width: 35px; height: 50px; background-color: transparent; border: none;">
								<img
									src="${fn:startsWith(profileImageUrl, 'http') ? '':contextPath }${profileImageUrl}"
									class="rounded-circle" alt="프로필" width="35" height="35">
							</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="${contextPath }/my/profile" style="font-size: 13px">내 정보</a></li>
								<li><a class="dropdown-item" href="${contextPath }/my/post" style="font-size: 13px">내가 쓴 글</a></li>
								<li><a class="dropdown-item" href="${contextPath }/signout" style="font-size: 13px">로그아웃</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container mt-3">
		<h4 class="text-left">내 정보</h4>
		<div class="row gx-2">
			<!-- 반응형 웹 1번째 -->
			<!-- multipart/form-data기능을 처리하기 -->
			<div class="col-md-4 p-2 d-flex justify-content-center text-center">
				<form method="post" enctype="multipart/form-data"
					action="${pageContext.servletContext.contextPath }/my/profile/imageNickname">

					<!-- 파일의 경우에는 get방식으로는 할수 없다. Body-->

					<div>

						<c:choose>
							<c:when
								test=" ${user.profile.profileImageUrl  eq '/resource/bandIcon/1.jpg'}">
								<img src="${contextPath }/resource/bandIcon/1.jpg" width="200"
									height="200" class="rounded-circle" style="cursor: pointer;"
									onclick="document.querySelector('#profileImage').click();"
									id="profileImageViewDefault" />
							</c:when>
							<c:otherwise>
								<img
									src="${fn:startsWith(profileImgUrl, 'http') ? '':contextPath }${profileImgUrl }"
									width="200" height="200" class="rounded-circle mt-4 mb-4"
									style="cursor: pointer;"
									onclick="document.querySelector('#profileImage').click();"
									id="profileImageView" />

							</c:otherwise>

						</c:choose>

					</div>
					<!-- 미리보기 기능을 위해서 -->
					<div style="display: none">
						<input type="file" class="form-control" id="profileImage"
							accept="image/*" name="profileImage" />
					</div>

					<div>
						<input type="text" class="form-control"
							value="${profile.profileNickName }" name="nickname" />
					</div>
					<div>
						<button type="submit" class="form-control btn btn-secondary mt-2">변경</button>
					</div>
				</form>
			</div>
			<!-- 반응형 웹 2번째 -->
			<div class="col-md-8 p-2">

				<div class="card p-2 ms-3" style="width: 50rem; height: 15rem;">
					<div class="card-body">
						<div class="ps-6">
							기본정보 <i class="bi bi-info-circle"></i>
						</div>
						<div class="d-flex justify-content-start p-2">
							<div class="me-4">
								<c:choose>
									<c:when
										test=" ${user.profile.profileImageUrl  eq '/resource/bandIcon/1.jpg'}">
										<img src="${contextPath }/resource/bandIcon/1.jpg" width="65"
											height="65" class="rounded-circle" style="cursor: pointer;" />
									</c:when>
									<c:otherwise>
										<img
											src="${fn:startsWith(profileImgUrl, 'http') ? '':contextPath }${profileImgUrl }"
											width="65" height="65" class="rounded-circle mt-4 mb-4"
											style="cursor: pointer;" />

									</c:otherwise>
								</c:choose>
							</div>
							<div class="d-flex flex-column">
								<div class="ps-6">아이디</div>
								<div class="fw-bold fs-1">${profile.profileUserId }</div>
							</div>
						</div>

						<form class="input-group mb-3" onsubmit="phoneCheck(event);" action ="${pageContext.servletContext.contextPath }/my/profile/defaultChange" method="post">
								<span class="input-group-text" id="inputGroup-sizing-default"><i
									class="bi bi-telephone"></i></span> <input type="number"
									name="phoneNumber" class="form-control"
									aria-label="Sizing example input"
									aria-describedby="inputGroup-sizing-default"
									value="${findUser.phoneNumber }" id="phoneNumber"
									maxlength="11"  required>
								<button class="btn btn-outline-secondary" >변경</button>
						</form>



					</div>
				</div>




			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=473e136e176bb93e3ce7b6dd00c8bfa9&libraries=services"></script>
	<script>
		//이미지 미리보기 스크립트
		document.querySelector("#profileImage").onchange = function(e) {
			if (e.target.files[0]) {
				var fileReader = new FileReader();
				fileReader.readAsDataURL(e.target.files[0]);
				fileReader.onload = function(e) {
					console.log(e.target.result);
					document.querySelector("#profileImageView").src = e.target.result;
				}
			}
		};
		
		function phoneCheck(event) {
			const num = document.querySelector("#phoneNumber").value;
			console.log(num);
			const pattern = /^(010|011|016|017|018|019)(.+)(.{4})$/
			console.log(!pattern.test(num));
			// event.preventDefault();
			
			if(!pattern.test(num)) {
				alert("휴대폰번호 형식이 올바르지 않습니다. 다시 확인해주세요")
				event.preventDefault();
			}
		}
	</script>
</body>
</html>



