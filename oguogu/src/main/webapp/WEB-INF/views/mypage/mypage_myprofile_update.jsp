<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#update-myprofile{
		width:1920px;
		margin:auto;
		display: flex;
		margin-top:50px;
	}
	
	#update-myprofileform{
		width:1500px;
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    background-color: #FBF9D9;
	    padding-top:20px;
	    margin-left:100px;
	    border-radius:50px;
	}
	
	#myimg-add-btn,#myimg-delete-btn {
	    cursor: pointer;
	    display: inline-block;
	    background-color: lightgray;
	    padding:10px;
	    text-align:center;
	    color: #fff;
	    border: none;
	    border-radius:10px;
		width:100px;
		font-size: 15px;
	}
	
	#myprofileform button{
		border:none;
	}
	
	#myimg{
		width:200px;
		height:200px;
		border-radius:50px;
	}
	
	#update-myprofile div{
		margin:10px 0;
	}
	
	#edit-remove button{
		width:350px;
		height:50px;
		border-radius:10px;
		background-color:#FFA629;
		font-size: 20px;
		color:#fff0f5;
	}
	
	#update-myprofileform input[type="text"]{
		height:30px;
		border:none;
	 	font-size: 20px;
	 	border-radius:5px;
	}
	
	#edit-remove-line{
		height:1px;
		width:350px;
		background-color: black;
	}
	
	#update-email input{
		user-select: none;
	 	pointer-events: none;
	 	width:280px;
	}
	
	footer{
        width:1920px;
        display:flex;
        margin:auto;
        margin-top:20px;
        margin-bottom: 20px;
    }
</style>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	
    	var isNicknameValid = false;
    	var isfileimg = false;
    	
    	//닉네임 버튼 활성화 체크 함수
    	function updateBtnState() {
			if(isNicknameValid || isfileimg){
				$("#edit-button").prop("disabled", false).css("background-color", "#FFA629").css("cursor", "pointer").css("color","white");
			}else{
				$("#edit-button").prop("disabled", true).css("background-color", "#F3F1EF").css("cursor", "default").css("color","#C4C4C4");
			}
		}
    	
    	
    	//닉네임 유효성 검사
    	$("#nickname").on("input", function() {
	    	  nick_input = $("#nickname").val();
	    	  var pattern = /^[A-Za-z0-9가-힣].{1,20}$/; 

	    	  if (pattern.test(nick_input)) {
	    	    $.ajax({
	    	      url: "/nicknameChk.do",
	    	      dataType: "json",
	    	      method: "post",
	    	      data: {
	    	        "nickname": nick_input
	    	      },
	    	      success: function(data) {
	    	        if (data == 1) {
	    	          $("#nickCheck").text("다른 닉네임을 사용해주세요.").css("color", "red");
	    	          isNicknameValid = false;
	    	        } else if (data == 0) {
	    	          $("#nickCheck").text("사용 가능한 닉네임입니다.").css("color", "green");
	    	          isNicknameValid = true;
	    	        }
	    	        updateBtnState();
	    	      },
	    	      error: function() {
	    	        alert("오류 발생");
	    	      }
	    	    });
	    	    updateBtnState();
	    	  } else {
	    	    $("#nickCheck").text("닉네임 조건에 맞지 않습니다.").css("color", "red");
	    	    isNicknameValid = false;
	    	  }
	    	  updateBtnState();
	    	});

		$("#myimg-delete-btn").on("click", function() {
		    // 파일 입력 요소 초기화
		    $("#fileInput").val("");
		    // 이미지 제거
		    $("#myimg").attr("src", "resources/images/home/mainbanner_eduexplain.png"); // 이미지의 src 속성을 비워서 이미지를 제거합니다.
		    isfileimg = true;
		    updateBtnState();
		});
		
    	
		//파일 첨부와 미지 변수
         const $fileInput = $('#fileInput');
         const $imgElement = $('#myimg');

         // 파일 입력 요소의 변경 이벤트를 감지합니다.
         $fileInput.on('change', function () {
             var selectedFile = $fileInput[0].files[0]; // 첫 번째 선택한 파일을 가져옵니다.
             
             // 파일을 이미지로 미리보기합니다.
             if (selectedFile) {
                 var reader = new FileReader();

                 reader.onload = function (e) {
                     // 이미지 파일을 읽어서 이미지 요소에 표시합니다.
                     $imgElement.attr('src', e.target.result);
                 };

                 reader.readAsDataURL(selectedFile);
                 
                 isfileimg = true;
                 updateBtnState();
             }
         });

        //업데이트 버튼
     	function update_go() {
			
		}

		//닉네임 버튼 체크 함수 활성화
    	updateBtnState();
		
    });
</script>
</head>
<body>
	<header>
		<jsp:include page="../home/home_top.jsp" />
	</header>
	<div id="update-myprofile">
		<div style="margin-right:70px;">
			<jsp:include page="mypage-sidebar.jsp" />
		</div>
		<form id="update-myprofileform" enctype="multipart/form-data" method="post">
			<div style="font-size: 40px; font-weight: bold; color:#FFA629;">회원 정보 수정</div>
			<c:choose>
				<c:when test="${uvo.user_fname}">
					<img src="resources/images/${uvo.user_fname}" id="myimg" />							
				</c:when>
				<c:otherwise>
					<img src="resources/images/home/mainbanner_eduexplain.png" id="myimg" />			
				</c:otherwise>
			</c:choose>
			<div>
			</div>
			
			<div id="myimg-add-delete">
				<label for="fileInput" id="myimg-add-btn" style="margin-right:15px;">
					사진 추가<input type="file" id="fileInput" name="file" accept="img/*" style="display: none;">
				</label>
				<label id="myimg-delete-btn">삭제</label>
			</div>
			
			<div id="my-nickname">
				<label>닉네임 : </label><input type="text" id="nickname" value="${uvo.nickname}" maxlength="20" style="width:280px;">
			</div>
			<div id="nickCheck" style="width:350px;"></div>
			
			<div id="update-email">
				이메일 : <input type="text" value="${uvo.email}" readonly>
			</div>
			
			<div id="edit-remove">
				<button id="edit-button" onclick="update_go()">수정하기</button><!-- 수정 완료 후 변경 완료한 아이디를 가지고 프로필 페이지로  -->
				<div id="edit-remove-line"></div>
				<button id="remove-button" style="cursor:pointer;">회원탈퇴</button><!-- 누르면 비번 찾기 페이지로 이동  -->
			</div>
		</form>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/home/home_bottom.jsp" />
	</footer>

</body>
</html>