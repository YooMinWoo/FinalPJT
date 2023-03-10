<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.card.mb-4{
	padding-left: 3rem !important;
	padding-right: 3rem !important;
}

</style>
<script src="${path }/resources/a00_com/jquery.min.js"></script>
<link rel="icon" type="image/x-icon" href="${path }/resources/sneat-1.0.0/assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${path }/resources/sneat-1.0.0/assets/js/config.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		console.log($("[name=risklevel]").val())
		$("#uptBtn").click(function(){			
			if(confirm("?????? ???????????????????")){
				$("option").attr("disabled", false)
				$("#form1").attr("action","${path}/project_riskUpdate.do");
				$("#form1").submit();
			}
		})
		$("#delBtn").click(function(){			
			if(confirm("?????? ???????????????????")){
				$("option").attr("disabled", false)
				$("#form1").attr("action","${path}/project_riskDelete.do");
				$("#form1").submit();
			}
		})
		$("#goMain").click(function(){
			location.href="${path}/project_pagingRisk.do"			
		});
		var ename="${emp.ename}"
		console.log(ename)
 		if(${emp.auth!=2}){
			$("[name=risklevel]").attr('readonly',true)
			$("[name=riskpriority]").attr('readonly',true)
			$("[name=riskmoniter]").attr('readonly',true)
			$("[name=riskstate]").attr('readonly',true)
			if($("[name=riskmoniter]").val()==ename){
				$("[name=risklevel]").attr('readonly',false)
				$("[name=riskpriority]").attr('readonly',false)
				$("[name=riskstate]").attr('readonly',false)
			}
		}
		$("#riskmoniter").click(function(){
			if(${emp.auth!=2}){
				alert("pm??? ??????")
			}
		})
		$("#risklevel, #riskpriority, #riskstate").click(function(){
			if($("[name=riskmoniter]").val()!=ename && ${emp.auth!=2}){
				alert("pm??? ???????????? ??????")
			}
		})
		
	});
</script>
</head>

<body style="overflow-x: hidden">
   <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->
	<jsp:include page="/mainMenubar.jsp"></jsp:include>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
        <jsp:include page="/mainTop.jsp"></jsp:include>
		  

          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->
			
            <div class="container-xxl flex-grow-1 container-p-y">
 
           <h4 class="fw-bold py-3 mb-4">???????????? > <small class="text-muted">????????? ??????</small></h4>
           
           <div class="card mb-4 pb-3">
           		<div class="card-body">
           			<div class="input-form col-md-12 mx-auto">
				        <h4 class="text-primary">????????? ??????</h4>
				        <form method="post" id="form1" class="validation-form" novalidate>
				          <div class="row">
				            <div class="col-md-6 mb-3">
				              <label for="riskno">???????????????</label>
				              <input type="text" name="riskno" class="form-control" id="riskno" 
				              		value="${risk.riskno}" readonly required>
				              <div class="invalid-feedback">
				                ??????????????????.
				              </div>
				            </div>
				          </div>  
				          <div class="mb-3">
				            <label for="subject">??????</label>
				            <input name="riskname" value="${risk.riskname}" type="text" class="form-control  ckValid" id="riskname" placeholder="?????? ??????" required>
				            <div class="invalid-feedback">
				              ????????? ??????????????????.
					           </div>
						  </div>
				          <div class="row">      
					          <div class="col-md-6 mb-3">
					            <label for="risklevel">?????????</label>
					            <select class="form-control" name="risklevel" id="risklevel" required>
					            	<option selected disabled value="${risk.risklevel}">${risk.risklevel}</option>
					            	<option disabled="disabled">--------------------------------------------------------------------------------------</option>
					            	<option value="??????">??????</option>
					            	<option value="??????">??????</option>
					            	<option value="??????">??????</option>
					            </select>
					          </div> 
					          <div class="col-md-6 mb-3">
					            <label for="riskpriority">?????????</label>
					            <select class="form-control" name="riskpriority" id="riskpriority" required>
					            	<option selected disabled value="${risk.riskpriority}">${risk.riskpriority}</option>
					            	<option disabled="disabled">--------------------------------------------------------------------------------------</option>
					            	<option value="1">1</option>
					            	<option value="2">2</option>
					            	<option value="3">3</option>
					            </select>
					          </div> 	          
				          </div> 
				          <div class="row">
				            <div class="col-md-6 mb-3">
				              <label for="riskmoniter" >???????????? </label>
				              <input type="text" name="riskmoniter"  class="form-control" 
				              		value="${risk.riskmoniter }" id="riskmoniter" >
				              <div class="invalid-feedback">
				                ??????????????????.
				              </div>
				            </div>
				            <div class="col-md-6 mb-3">
				              <label for="riskstate" >???????????????</label>
				              <input type="text" name="riskstate"  class="form-control" 
				              		value="${risk.riskstate }" id="riskstate" >
				              <div class="invalid-feedback">
				                ??????????????????.
				              </div>
				            </div>
				          </div> 
				          <div class="mb-4"></div>
				          <button id="uptBtn" class="btn btn-warning btn-lg btn-block" type="button">????????? ??????</button>
				          <button id="delBtn" class="btn btn-danger   btn-lg btn-block" type="button">????????? ??????</button>
				          <button id="goMain" class="btn btn-info   btn-lg btn-block" type="button">?????? ??????</button>
				        </form>
				      </div>
           		</div>
         	</div>
         	  <!-- /card -->
			<div class="card mb-4 pb-3">
           		<div class="card-body">
           			<div class="input-form col-md-12 mx-auto">
				        <h4 class="mb-3">?????????</h4>
				        <form method="post" id="form2" class="validation-form" novalidate>
				          <div class="row">
				            <div class="col-md-6 mb-3">
				              <input type="hidden" value="${risk.riskno}">
				            </div>
				          </div>  
				          <div class="mb-3">
				            <label for="subject">?????????</label>
				            <input name="" value="" type="text" class="form-control  ckValid" id="" placeholder="????????? ??????" required>
						  </div>
				          <div class="mb-4"></div>
				          
				        </form>
				      </div>
           		</div>
         	</div> 
            </div>
            <!-- / Content -->

	

           
          </div>
          <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
      </div>
      </div>

      <!-- Overlay -->
      <div class="layout-overlay layout-menu-toggle"></div>
   
 

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/libs/popper/popper.js"></script>
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/js/bootstrap.js"></script>
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="${path }/resources/sneat-1.0.0/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${path }/resources/sneat-1.0.0/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</body>
</html>