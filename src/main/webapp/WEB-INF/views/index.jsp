<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>     
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>   
<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <title>Final Project</title>
   <!-- CSS -->
   <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
   <link rel="stylesheet" type="text/css" href="../../resources/lib/owl/owl.carousel.css">
	<link rel="stylesheet" type="text/css" href="../../resources/lib/owl/owl.theme.default.css">
	<script src="../../resources/lib/jquery/jquery-3.4.1.min.js"></script>
	<script src="../../resources/lib/owl/owl.carousel.min.js"></script>
   <link rel="stylesheet" type="text/css" href="../../resources/css/common.css">
   <link rel="stylesheet" type="text/css" href="../../resources/css/main.css">
   <link rel="stylesheet" type="text/css" href="../../resources/css/headerfooter.css">
   <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">

   <script>
   		$(document).ready(function(){

   			var owl = $('.owl-carousel');
			owl.owlCarousel({
			    items:1,
			    loop:true,
			    margin:0,
			    autoplay:true,
			    autoplayTimeout:7500,
			    autoplayHoverPause:false
			});
			$('.play').on('click',function(){
			    owl.trigger('play.owl.autoplay',[2000])
			})
			$('.stop').on('click',function(){
			    owl.trigger('stop.owl.autoplay')
			})
			//$('.owl-dots').hide();

			$('nav .one').hover(function () {
			    if($(".callsenterSub").css("display") == "none"){
			       $('.callsenterSub').slideDown();
			       $("headerA").css("color","#f15b6d");
			    } else {
			       $('.callsenterSub').css("display", "none");
			       event.stopPropagation();
			       event.preventDefault();
			    }
			});
			
			$('#levelGOGO').on('click',function(){
				location.href="/level/commonTest";
			})
			
			$('#leaderGOGO').on('click',function(){
				location.href="/level/leaderTest";
			})
			

		});//ready
   </script>
</head>
<body>
	<div id="wrap">
		<%@ include file="./common/header.jsp" %>
		<div id="container">
			<div class="slider">
				<div class="owl-carousel owl-theme">
				    <div class="item item1">
				    	<img src="../../resources/img/StudyMain/slider2.jpeg">
				    	<div class="slidercontent">
							<h1>WelCome</h1>
							<h1>스콜피온이 처음이세요?</h1>
							<p>지금 레벨테스트하고 꼭 맞는 스터디를 안내받으세요!</p>
							<input type="button" name="levelGOGO" id="levelGOGO" value="시작하기">
						</div>
					</div>
				    <div class="item item2">
						<img src="../../resources/img/StudyMain/slider4.png">
						<div class="slidercontent">
							<h1>스콜피온은?</h1>
							<p>각양각색의 해외경험 리더와 함께하는 스터디 매칭 플랫폼입니다.</p>
						</div>
					</div>
				    <div class="item item3">
				    	<img src="../../resources/img/StudyMain/studySlider01.jpeg">
				    	<div class="slidercontent">
							<h1>스터디 리더에 관심이 있으신가요?</h1>
							<p>스터디의 호스트가 되어 영어의 즐거움을 선사하세요!</p>
							<input type="button" name="leaderGOGO" id="leaderGOGO" value="시작하기">
						</div>
					</div>
				</div>
			</div><!-- slider -->
			<section class="studyListWrap">
				<div class="inner">
					<h1>스콜피온은</h1>
					<h1>각양각색의 <b>해외경험 리더</b>와 함께하는</h1>
					<h1><b>오프라인 스터디 매칭 플랫폼</b> 입니다.</h1>
					<div class="studyListContent">
						<!-- <div class="studyList">
							Empty
						</div>
						<div class="studyList">
							Empty
						</div>
						<div class="studyList">
							Empty
						</div> -->
					</div>
				</div>
			</section>
			<section class="howLike">
				<div class="inner">
					<div class="howLikeTitle">
						<h1>스콜피온!</h1>
						<h2>어떤점이 좋나요?</h2>
					</div>
					<ul>
						<li>
							<div class="icon icon1"></div>
							<h2>내게 꼭 맞는 수준별 스터디</h2>
							<h3>초급, 중급, 고급레벨로<br> 진행되는 스터디에요!</h3>
						</li>
						<li>
							<div class="icon icon2"></div>
							<h2>최대 6-8명의 소수 정예</h2>
							<h3>도란도란 정예 멤버로<br>꼭 맞는 사람들끼리 시작해요</h3>
						</li>
						<li>
							<div class="icon icon3"></div>
							<h2>다양한 지역 및 시간대</h2>
							<h3>평일 낮부터 밤, 그리고 주말까지!<br>내게 딱 맞는 시간대를 찾아보세요!</h3>
						</li>
					</ul>
				</div>
			</section>
			<section class="levelTestGo">
				<div class="inner">
					<div class="levelTestContent">
						<h1><b>일단 레벨테스트부터</b><br> 시작해보세요!</h1>
						<h2>무료로 내영어 레벨을 파악하고<br>꼭 맞는 스터디를 안내 받으세요!</h2>
						<a id="levelTestIndex" onclick="nono()">레벨테스트 시작</a>
					</div>
					<div class="levelTestImg">
					</div>
				</div>
			</section>
			<div class="inner">
			<div class="box">
	            <div class="loader6"></div>
       		 </div>
       		 </div>
			<section class="LeaderGo">
				<div class="inner">
					<div class="LeaderGoContent">
						<h1><b>스터디 리더에</b><br>관심이 있으신가요?</h1>
						<h2>내가 편한 지역, 편한 시간에 스터디를 개설해<br>학생들과의 유쾌한 교류를 시작해보세요.</h2>
						<a href="/common/leaderTest">리더 시작하기!</a>
					</div>
					<div class="LeaderGoImg">
					</div>
				</div>
			</section>
		</div><!-- container -->
		<%@ include file="./common/footer.jsp" %>
	</div><!-- wrap -->
</body>
<script>
	function nono(){
		alert("로그인 후 상단 메뉴를 통해 이용해주세요!");
	}
</script>

</html>