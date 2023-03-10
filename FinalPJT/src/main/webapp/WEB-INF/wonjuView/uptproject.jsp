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
	padding-left: 15rem !important;
	padding-right: 15rem !important;
}
th{
	text-align: center !important;
}
tbody td{
	text-align: center;
	font-size: 0.8rem;
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
		$("#menu-item-project").addClass('active open');	
		$("#menu-item-project-myproject").addClass('active');	
		var prjno = "${projectInfo.prjno}"
		var gMindate="${ganttDate.mindate}"
		var gMaxdate="${ganttDate.maxdate}"
		

		// ?????? ?????? ??????
		$("#uptBtn").click(function(){
			 $("#uptProFrm").addClass('was-validated')
			 var regdteVal = $("[name=regdte]").val()
			 var deadlineVal = $("[name=deadline]").val()
			 var subjectVal = $("[name=subject]").val()
			 var deptidVal = $("[name=deptid]").val()
			 var openStatusVal = $("[name=openStatus]:checked").val()
			 
			 if(deadlineVal>regdteVal){
				 $("#deadCk").hide()
				 $("[name=deadline]").css('border-color','');
				 if(gMindate!=''){
					 if(gMindate>=regdteVal && gMaxdate<=deadlineVal){
						 $("#regCk").hide()
						 $("[name=regdte]").css('border-color','');
						 $("#deadCk").hide()
						 $("[name=deadline]").css('border-color','');
						 uptAjax(prjno,deptidVal,subjectVal,regdteVal,deadlineVal,openStatusVal)
					 }else if(gMindate<regdteVal && gMaxdate<=deadlineVal){
						 $("#regCk").show()
						 $("[name=regdte]").css('border-color','#ff3e1d');
						 $("#regCk").text('?????? ????????? ????????? ????????? ????????????')
						 $("#deadCk").hide()
						 $("[name=deadline]").css('border-color','');
					 }else if(gMaxdate>deadlineVal && gMindate>=regdteVal){
						 $("#deadCk").show()
						 $("[name=deadline]").css('border-color','#ff3e1d');
						 $("#deadCk").text('?????? ????????? ????????? ????????? ????????????')
						 $("#regCk").hide()
						 $("[name=regdte]").css('border-color','');
					 }else{
						 $("#deadCk").show()
						 $("[name=deadline]").css('border-color','#ff3e1d');
						 $("#deadCk").text('?????? ????????? ????????? ????????? ????????????')
						 $("#regCk").show()
						 $("[name=regdte]").css('border-color','#ff3e1d');
						 $("#regCk").text('?????? ????????? ????????? ????????? ????????????')
					 }
			 	}else{
			 		uptAjax(prjno,deptidVal,subjectVal,regdteVal,deadlineVal,openStatusVal)
			 	}
			 }else{
				 $("#deadCk").show()
				 $("[name=deadline]").css('border-color','#ff3e1d');
				 $("#deadCk").text('??????????????? ?????????????????? ????????? ????????????')
			 }
		})
		// ?????? ??????
		$("#delBtn").click(function(){
			let url="${path}/delProject.do?prjno="+prjno
			fetch(url,{method:'POST'}).then(function(response){
				return response.json()
			}).then(function(json){
				console.log(json.msg)
				if(json.msg=='????????????'){
					alert("???????????? ?????????????????????")
					location.href="${path}/allProject.do"
				}
			}).catch(function(err){
				console.log(err)
			})		
		})
		// ?????? ??????
		$("#clsBtn").click(function(){
			location.href="${path}/projectMain.do?prjno="+prjno
		})
		
	});
	function uptAjax(prjno,deptidVal,subjectVal,regdteVal,deadlineVal,openStatusVal){
		 if(deptidVal!=null && subjectVal!=''){
			 let url="${path}/uptProInfo.do?prjno="+prjno+"&subject="+subjectVal+
					 "&regdte="+regdteVal+"&deadline="+deadlineVal+"&deptid="+
					 deptidVal+"&openStatus="+openStatusVal
			  console.log(url)		 
			 fetch(url,{method: 'POST'}).then(function(response){
				 return response.json()
			 }).then(function(json){
				 if(json.msg=='????????????'){
					 if(confirm("???????????? ?????????????????????\n??????????????? ?????????????????????????")){
						 location.href="${path}/projectMain.do?prjno="+prjno
					 }
				 }
			 }).catch(function(err){
				 console.log(err)
			 })
		 }
	}
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
 
           <h4 class="fw-bold py-3 mb-4">???????????? > <small class="text-muted">???????????? ??????</small></h4>
           
           <div class="card mb-4 pb-3">
    
		      <h5 class="card-header pt-5 fw-bold">???????????? ??????</h5>
		      <p class="text-muted mb-3 px-4" style="font-size: 0.5rem;">
		      	??? ???????????? ?????? ????????? ????????? ??? ????????????.<br>
                ??? ?????? ????????? ????????? ??? ??? ?????? ??????????????????, ?????? ????????? ????????? ????????? ??? ??? ?????? ?????????????????????.
              </p>
		      <div class="card-body">
		       <!-- ?????? form  -->
		      <form class="needs-validation" id="uptProFrm">
		        <div class="mb-3 row">
		          <label for="html5-text-input" class="col-md-2 col-form-label">????????????</label>
		          <div class="col-md-10">
			           <select id="html5-text-input" class="form-select" name="deptid" required="required">
			            <c:forEach var="dept" items="${deptCom}">
							<option <c:if test="${dept.deptid==projectInfo.deptid}">selected</c:if>
							 value="${dept.deptid }">${dept.dname}</option>
				    	</c:forEach>
			          </select>
			          <div class="invalid-feedback">
					      ??????????????? ??????????????????
					  </div>
		          </div>
		        </div>
		        <div class="mb-3 row">
		          <label for="html5-search-input" class="col-md-2 col-form-label">???????????? ???</label>
		          <div class="col-md-10">
		            <input class="form-control" value="${projectInfo.subject}" type="text" name="subject" placeholder="???????????? ????????? ???????????????" id="html5-search-input" required="required">
		           	<div class="invalid-feedback">
					      ???????????? ?????? ??????????????????
					  </div>
		          </div>
		        </div>
		        <div class="mb-3 row">
		          <label for="html5-search-input" class="col-md-2 col-form-label">??????PM</label>
		          <div class="col-md-10">
		            <input class="form-control" type="text" value="${projectInfo.ename }" 
		            id="html5-search-input" readonly="readonly">
		          	<input type="hidden" name="tlid" value="${projectInfo.tlid}"><!-- ????????? ?????? pm ????????? -->
		          </div>
		        </div>
		         <div class="mb-3 row">
		          <label for="startDate" class="col-md-2 col-form-label">?????? ??????</label>
		          <div class="col-md-10"> 
		            <input class="form-control" name="regdte" id="startDate" type="date"
		             value="${projectInfo.regdte }" required="required">
		         	 <div class="invalid-feedback" id="regCk">
					    ???????????? ?????? ????????? ??????????????????
					  </div>
		          </div>
		        </div>
		         <div class="mb-3 row">
		          <label for="endDate" class="col-md-2 col-form-label">?????? ??????</label>
		          <div class="col-md-10">
		            <input class="form-control validCk" name="deadline" type="date" 
		            value="${projectInfo.deadline }" id="endDate" required="required">
		          	 <div class="invalid-feedback" id="deadCk">
					    ???????????? ?????? ????????? ??????????????????
					  </div>
		          </div>
		        </div>
		        <div class="mb-3 row">
		          <label for="html5-search-input" class="col-md-2 col-form-label">?????? ??????</label>
		          <div class="col-md-10">
			          <div class="form-check form-check-inline">
			              <input class="form-check-input" type="radio" name="openStatus" id="inlineRadio1" value="0" 
			              <c:if test="${projectInfo.openStatus eq '0' }">checked</c:if>>
			              <label class="form-check-label" for="inlineRadio1">?????? ??????</label>
			            </div>
		          	  <div class="form-check form-check-inline">
		                  <input class="form-check-input" type="radio" name="openStatus" id="inlineRadio2" value="1"
		                  <c:if test="${projectInfo.openStatus eq '1' }">checked</c:if>>
		                  <label class="form-check-label" for="inlineRadio2">?????? ??????</label>
		               </div>
		          </div>
		        </div>
		        <div class="card-footer">
			        <div class="d-flex justify-content-center">
			        <button id="uptBtn" type="button" class="btn btn-primary">??????</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			        <button id="clsBtn" type="button" class="btn btn-secondary">??????</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			        <button id="delBtn" type="button" class="btn btn-danger">??????</button>
			        </div>
		        </div>
		        </form>
		        <!-- form ??? -->
		      </div>
 
           </div>
         	<!-- /card -->
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