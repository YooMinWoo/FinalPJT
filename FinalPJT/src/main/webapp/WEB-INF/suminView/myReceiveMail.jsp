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
.demo-inline-spacing{
	display: flex;
    justify-content: flex-end; 
}
a.hover{
	color:blue;ss
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
		$("#readBtn").click(function(){
			if(confirm("?????? ?????????????????????????")){
				for(var idx=0; idx<$("input[name=chk]:checkbox").length; idx++){
					if($("input[name=chk]:checkbox")[idx].checked==true){
						var mailno = $("input[name=chk]:checkbox")[idx].value
						location.href="${path}/uptSendState.do?mailno="+mailno
					}
				}
				alert("???????????? ????????? ?????? ?????????????????????.")
			}
		})
		$("#delBtn").click(function(){
			if(confirm("?????????????????????????")){
				for(var idx=0; idx<$("input[name=chk]:checkbox").length; idx++){
					if($("input[name=chk]:checkbox")[idx].checked==true){
						var mailno = $("input[name=chk]:checkbox")[idx].value
						location.href="${path}/delReceiveMail.do?mailno="+mailno
					}
				}
				alert("???????????? ????????? ?????????????????????.")
			}
		})
		
		$("#replyBtn").click(function(){
			for(var idx=0; idx<$("input[name=chk]:checkbox").length; idx++){
				if($("input[name=chk]:checkbox")[idx].checked==true){
					var mailno = $("input[name=chk]:checkbox")[idx].value
					location.href="${path}/replyMail.do?mailno="+mailno
				}
			}
		})
		
		$("#allChk").click(function(){
		
			$("input[name=chk]").prop("checked", true)
		})
		
	})
	function goPage(cnt){
		$("[name=curPage]").val(cnt);
		var curPage=$("[name=curPage]").val()
		location.href="${path}/myReceiveMail.do?curPage="+curPage
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
 
           <h4 class="fw-bold py-3 mb-4">?????? > <small class="text-muted">?????? ?????????</small></h4>
           
           <div class="card mb-4 pb-3">
	           <div class="demo-inline-spacing">
	           <button id="allChk" type="button" class="btn rounded-pill btn-info">?????? ??????</button>
	         	<button id="readBtn" type="button" class="btn rounded-pill btn-primary">??????</button>
	         	<button id="replyBtn" type="button" class="btn rounded-pill btn-info">??????</button>
	         	<button id="delBtn" type="button" class="btn rounded-pill btn-danger">??????</button>
	         	</div>
	         	<div class="table-responsive text-nowrap">
	         	<input type="hidden" name="curPage" value="${sch.curPage}"/>
                  <table class="table">
                  	
                    <thead>
                      <tr>
                        <th></th>
                        <th style="text-align:center;">??????</th>
                        <th style="text-align:center;">?????? ??????</th>
                        <th style="text-align:center;">??????</th>
                        <th style="text-align:center;">?????? ??????</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                    <c:forEach var="mail" items="${myReceiveMail}">
                      <tr>
                        <td style="width:10px;"><i class="fab fa-angular fa-lg text-danger me-3"></i> 
                       	 <input type="checkbox" name="chk" value="${mail.mailno}"></td>
                       
                  		<c:if test="${mail.state=='0'}">
                  		 <td style="width:10px;">????????????</td>
                  		</c:if>
                  		<c:if test="${mail.state=='1'}">
                  		 <td style="width:10px;">??????</td>
                  		</c:if>
                  		<td style="width:10px;">${mail.sender }</td>
                  		
                  		 <td >
                  		<a style="color:#697a8d;" href="${path}/receiveDetail.do?mailno=${mail.mailno}"> ${mail.title}</a> </td>
                        <td style="text-align:center;">
                         <fmt:formatDate pattern='yyyy-MM-dd' value="${mail.receiveDte}"/> 
                        </td>
                      </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
                
                <nav aria-label="Page navigation" style="display: flex; justify-content: center;">
                          <ul class="pagination">
                        
                            <li class="page-item prev">
                              <a class="page-link" href="javascript:goPage(${sch.startBlock-1});"
                                ><i class="tf-icon bx bx-chevron-left"></i
                              ></a>
                            </li>
                            <c:forEach var="cnt" begin="${sch.startBlock}" 
								end="${sch.endBlock}">
								<li class="page-item ${sch.curPage==cnt?'active':''}">
								<a class="page-link" 
									href="javascript:goPage(${cnt});">${cnt}</a></li>
								</c:forEach>
                            <li class="page-item next">
                              <a class="page-link" href="javascript:goPage(${sch.endBlock+1});"
                                ><i class="tf-icon bx bx-chevron-right"></i
                              ></a>
                            </li>
                           
                          </ul>
                        </nav>
                       
         	</div>
         	  <!-- /card -->
            </div>
            <!-- / Content -->
			  <!-- Modal -->
			  
           
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