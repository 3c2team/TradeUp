<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-menu-fixed"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="../assets/"
  data-template="vertical-menu-template-free"
>
<head>
  <meta charset="utf-8" />
  <meta
    name="viewport"
    content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
  />

  <title>TRADEUP | 거래내역</title>

  <meta name="description" content="" />

  <!-- Favicon -->
<!--   <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" /> -->

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
<!--   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin /> -->
  <link
    href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
    rel="stylesheet"
  />
	
	<!-- top css -->
	<jsp:include page="../inc/style.jsp"></jsp:include>
  <!-- Icons. Uncomment required icon fonts -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/fonts/boxicons.css" />
  <!-- Core CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/css/demo.css" />
  <!-- Vendors CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
  <!-- Page CSS -->
  <!-- Helpers -->
  <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/helpers.js"></script>
  <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
  <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
  <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/config.js"></script>
	<style type="text/css">
		.product{
		    display: flex;
    		align-items: center;
		}
		.product_info{
			margin-left: 20px;
		    display: flex;
		    flex-direction: column;
		}
	</style>
</head>

<body>
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<%-- 사이드 메뉴 --%>
			<jsp:include page="inc/side_menu.jsp"></jsp:include>  
			<div class="layout-page" style="background: white;">
				<div class="content-wrapper">
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">거래내역 /</span> 거래 방법 내역</h4>
						<!--/Table -->
						<div class="card">
							<h5 class="card-header">거래 내역</h5>
							<div class="table-responsive text-nowrap">
								
								<!-- -------------------------------------------------------------- -->
										<div id="layoutSidenav_content">
										<main>
											<div class="row">
												<div class="col-xl-6">
													<div class="card mb-4">
														<br>
														<div class="card-header">
															<i class="fas fa-chart-bar me-1"></i> 거래 방법 현황
														</div>
														<br>
														<div class="card-body">
															<canvas id="myPieChart" width="100%" height="40"></canvas>
														</div>
													</div>
												</div>
												
												<div class="col-xl-6" id="reservation_confirm_term_right">
													<form action="TransactionSearch" method="post">	
														<div class="calanderWrap" align="center">
															<br>
															<input type="date" id="startDate" name="startDate"> - <input type="date" id="endDate" name="endDate" >
<!-- 															<button type="submit" class="badge bg-label-prohibition" id="search_btn">조회</button> -->
<!-- 																<button type="submit" class="btn default" id="search_btn" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #5F12D3 ;">조회</button> -->
																<button class="btn default" id="search_btn" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #5F12D3 ;">조회</button>
														</div>
													</form>
													<br>
													<div class="table-responsive text-nowrap">
														<table class="table">
															<thead>
																<tr>
																	<th>거래방법</th>
																	<th>건수</th>
																	<th>수수료 금액</th>
																</tr>
															</thead>
															<tbody class="table-border-bottom-0">
																<tr>
																	<td>
																		<div class="product pay-type" >
																			<div class="product_info"><strong>업페이</strong></div>
																		</div>
																	</td>
																	<td>
																		<div class="product pay-type">
																			<div class="product_info"><strong>${TransactionCount.uppayCount }</strong></div>
																		</div>
																	</td>
																	<td>
																		<div class="product pay-type">
												                        	<span class="badge bg-label-prohibition"><fmt:formatNumber value="${TransactionCount.uppay }" pattern="#,###" /> 원</span>	
																		</div>
																	</td>
																</tr>
																<tr>
																	<td>
																		<div class="product pay-type">
																			<div class="product_info"><strong>카카오페이</strong></div>
																		</div>
																	</td>
																	<td>
																		<div class="product pay-type">
																			<div class="product_info"><strong>${TransactionCount.kakaopayCount }</strong></div>
																		</div>
																	</td>
																	<td>
												                        <span class="badge bg-label-prohibition"><fmt:formatNumber value="${TransactionCount.kakaopay }" pattern="#,###" />원</span>	
																	</td>
																</tr>
																<tr>
																	<td>
																		<div class="product pay-type" >
																			<div class="product_info"><strong>무통장</strong></div>
																		</div>
																	</td>
																	<td>
																		<div class="product pay-type">
																			<div class="product_info"><strong>${TransactionCount.bankCount }</strong></div>
																		</div>
																	</td>
																	<td>
												                        <span class="badge bg-label-prohibition"><fmt:formatNumber value="${TransactionCount.bankTransfer }" pattern="#,###" /> 원</span>	
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</main>
									</div>
								
								
								<!-- -------------------------------------------------------------- -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="layout-overlay layout-menu-toggle"></div>
    <!-- / Layout wrapper -->

	<%-- 바텀 메뉴 --%>
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/jquery/jquery.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/popper/popper.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/bootstrap.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script> --%>
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin/product_sales.js"></script> --%>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
    <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin_scripts.js"></script> --%>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/demo/admin_pay_pie_chart.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_datatable.js"></script>
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin_calender.js"></script> --%>
	</body>
</html>
