<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	    padding-top:50px;
	    margin-left:100px;
	    border-radius:50px;
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
	
	#myimg-add-btn{
		border-radius:10px;
		width:100px;
		font-size: 15px;
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
    	
    	function updateBtnState() {
			if(isNicknameValid){
				$("#edit-button").prop("disabled", false).css("background-color", "#FFA629").css("cursor", "pointer").css("color","white");
			}else{
				$("#edit-button").prop("disabled", true).css("background-color", "#F3F1EF").css("cursor", "default").css("color","#C4C4C4");
			}
		}
    	
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
		<div id="update-myprofileform">
			<div style="font-size: 40px; font-weight: bold; color:#FFA629;">회원 정보 수정</div>
			<div>
				<img src="resources/images/home/mainbanner_eduexplain.png" id="myimg" />
			</div>
			<div id="myimg-add-delete">
				<button id="myimg-add-btn" style="cursor:pointer;"> 사진 추가 </button>
			</div>
			
			<div id="my-nickname">
				<label>닉네임 : </label><input type="text" id="nickname" value="${sessionScope.nickname}" maxlength="20" style="width:280px;">
			</div>
			<div id="nickCheck" style="width:350px;"></div>
			
			<div id="update-email">
				이메일 : <input type="text" value="${sessionScope.email}" readonly>
			</div>
			
			<div id="edit-remove">
				<button id="edit-button" disabled>수정하기</button><!-- 수정 완료 후 변경 완료한 아이디를 가지고 프로필 페이지로  -->
				<div id="edit-remove-line"></div>
				<button id="remove-button" style="cursor:pointer;">회원탈퇴</button><!-- 누르면 비번 찾기 페이지로 이동  -->
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/home/home_bottom.jsp" />
	</footer>
</body>
</html>