<!DOCTYPE html>
<html lang="zh">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>基于Git的实验代码管理系统</title>

<meta name="keywords" content="LightYear,光年,后台模板,后台管理系统,光年HTML模板">
<meta name="description"
	content="LightYear是一个基于Bootstrap v3.3.7的后台管理系统的HTML模板。">
<meta name="author" content="yinqi">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/css/materialdesignicons.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/style.min.css"
	rel="stylesheet">
</head>

<body>
	<div class="lyear-layout-web">
		<div class="lyear-layout-container">
			<!--左侧导航-->
			<aside class="lyear-layout-sidebar">


				<div id="logo" style="height:55px">
      <p></p>
          <h4 align="center">基于Git的实验代码管理系统</h4>
      </div>
      <div class="lyear-layout-sidebar-scroll"> 
        
        <nav class="sidebar-main">
          <ul class="nav nav-drawer">
            <li class="nav-item"> <a href="${pageContext.request.contextPath }/teacher/toindex"><i class="mdi mdi-home"></i> 首页</a> </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-bank"></i> 选题管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="${pageContext.request.contextPath }/teacher/totitlelist">我的课题</a> </li>
                <li> <a href="${pageContext.request.contextPath }/teacher/toSelecttitlelist">查看选题学生</a> </li>
                
              </ul>
            </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-file-outline"></i> 技术文档管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="${pageContext.request.contextPath }/teacher/projBooklist">已审核技术文档</a> </li>
                <li> <a href="${pageContext.request.contextPath }/teacher/projBooklist1">待审核技术文档</a> </li>
              </ul>
            </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-file-outline"></i> 程序代码管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="${pageContext.request.contextPath }/teacher/openReportlist">已审核程序代码</a> </li>
                <li> <a href="${pageContext.request.contextPath }/teacher/openReportlist1">待审核程序代码</a> </li>
              </ul>
            </li>

            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-attachment"></i> 附件</a>
              <ul class="nav nav-subnav">
                <li> <a href="${pageContext.request.contextPath }/teacher/thesisAttachmentlist">下载学生附件</a> </li>
              </ul>
            </li>

            <li class="nav-item nav-item-has-subnav active open">
              <a href="javascript:void(0)"><i class="mdi mdi-scale-balance"></i> 总评</a>
              <ul class="nav nav-subnav">
                <li class="active"> <a href="${pageContext.request.contextPath }/teacher/studentScore">学生成绩总评</a> </li>
              </ul>
            </li>
          </ul>
        </nav>
        
        <div class="sidebar-footer">
          
        </div>
      </div>

			</aside>
			<!--End 左侧导航-->

			<!--头部信息-->
			<header class="lyear-layout-header">

				<nav class="navbar navbar-default">
					<div class="topbar">

						<div class="topbar-left">
							<div class="lyear-aside-toggler">
								<span class="lyear-toggler-bar"></span> <span
									class="lyear-toggler-bar"></span> <span
									class="lyear-toggler-bar"></span>
							</div>
							<span class="navbar-page-title"> 学生成绩总评 </span>
						</div>

						<ul class="topbar-right">
							<li class="dropdown dropdown-profile"><a
								href="javascript:void(0)" data-toggle="dropdown"> <span
									style="color: black">${USER_INFO.tName} <span
										class="caret"></span></span>
							</a>
								<ul class="dropdown-menu dropdown-menu-right">
									<li><a
										href="${pageContext.request.contextPath }/teacher/topersonInfo"><i
											class="mdi mdi-account"></i> 个人信息</a></li>
									<li><a
										href="${pageContext.request.contextPath }/teacher/toeditPwd"><i
											class="mdi mdi-lock-outline"></i> 修改密码</a></li>
									<li class="divider"></li>
									<li><a
										href="${pageContext.request.contextPath }/logout"><i
											class="mdi mdi-logout-variant"></i> 退出登录</a></li>
								</ul></li>

						</ul>

					</div>
				</nav>

			</header>
			<!--End 头部信息-->
			<div class="modal fade" id="reviewInfoModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="exampleModalLabel">答辩评分详情</h4>
						</div>
						<div class="modal-body">
							<form id="studentScore_form">
							<input hidden="hidden" type="text" id="s_Id" name="sId">			
										<div class="form-group">
											<div class="form-group">
											<label for="replyLeader" class="control-label">答辩组组长：</label>
											<input readOnly type="text" class="form-control" name="replyLeader" id="replyLeader" />
											<label for="reviewScore" class="control-label">答辩组组长评分：</label>
											<input readOnly type="text" class="form-control" name="reviewScore" id="reviewScore" />
											<label for="review_Comments" class="control-label">答辩组长评语：</label>
												<textarea readOnly style="height: 100px"
													class="form-control" id="review_Comments" name="reviewComments"></textarea>
											</div>
											<p></p>
											
											<div class="form-group">
											<label for="replyLeader1" class="control-label">评阅教师：</label>
											<input readOnly type="text" class="form-control" name="memberTName1" id="memberTName1" />
											<label for="reviewScore1" class="control-label">评阅教师评分评分：</label>
											<input readOnly type="text" class="form-control" name="reviewScore1" id="reviewScore1" />
											<label for="review_Comments" class="control-label">评阅教师评语：</label>
												<textarea readOnly style="height: 100px"
													class="form-control" id="review_Comments1" name="reviewComments"></textarea>
											</div>
											<p></p>
											
											<div class="form-group">
											<label for="replyLeader2" class="control-label">评阅教师：</label>
											<input readOnly type="text" class="form-control" name="memberTName2" id="memberTName2" />
											<label for="reviewScore2" class="control-label">评阅教师评分评分：</label>
											<input readOnly type="text" class="form-control" name="reviewScore2" id="reviewScore2" />
											<label for="review_Comments" class="control-label">评阅教师评语：</label>
												<textarea readOnly style="height: 100px"
													class="form-control" id="review_Comments2" name="reviewComments"></textarea>
											</div>
											</div>
											
							</form>
						</div>
						<div class="modal-footer">
						
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
						</div>
					</div>
				</div>
			</div>
			<!--页面主要内容-->
			<main class="lyear-layout-content">

			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-toolbar clearfix">
							<form id="form_query"
									action="${pageContext.request.contextPath }/teacher/studentScore"
									class="pull-right search-bar" method="post"">
									<input id="page" name="pageNum" type="hidden" value="1" />
								</form>
							</div>
							<div class="card-body">
								<p></p>
								<div class="table-responsive">
									<table class="table table-bordered" id="tbodyID">
										<thead>
											<tr>
												<th>序号</th>
												<th>选题名称</th>
												<th>学生</th>
												<th>批次</th>
												<th>指导教师</th>
												<th>指导教师评语</th>
												<th>指导教师评分</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="selectTitle" items="${pageInfo.list }"
												varStatus="state">
												<tr>
													<td>${ state.index + 1}</td>
													<td>${selectTitle.titlName}</td>
													<td>${selectTitle.sId}${selectTitle.sName}</td>
													<td><c:if test="${selectTitle.sName!=null}">${selectTitle.batch }</c:if></td>
													<td>${USER_INFO.tName }</td>
													<td><c:if test="${selectTitle.sName!=null}"><input data-toggle="modal"
														data-target="#commentsInfoModal1" type="button" class="btn btn-primary btn-xs" id="comment"
																	name="search2" value='编辑' onclick="getcomment1('${selectTitle.tComments }','${selectTitle.sId }','${selectTitle.tScore }','${selectTitle.titlId }')"></c:if></td>
													<td><c:if test="${selectTitle.sName!=null}">${selectTitle.tScore }</c:if></td>

												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="row">
									<!--文字信息-->
									<div class="col-md-6">当前第 ${pageInfo.pageNum} 页.总共
										${pageInfo.pages} 页.一共 ${pageInfo.total} 条记录</div>
									<!--点击分页-->
									<div class="col-md-6">
										<nav aria-label="Page navigation">
											<div align="right">
												<ul class="pagination">

													<li><a href=""javascript:jumpPage(1)">首页</a></li>

													<!--上一页-->
													<li><c:if test="${pageInfo.hasPreviousPage}">
															<a href="javascript:jumpPage(${pageInfo.pageNum-1})"
																aria-label="Previous"> <span aria-hidden="true">«</span>
															</a>
														</li></c:if>

													<!--循环遍历连续显示的页面，若是当前页就高亮显示，并且没有链接-->
													<c:forEach items="${pageInfo.navigatepageNums}"
														var="page_num">
														<c:if test="${page_num == pageInfo.pageNum}">
															<li class="active"><a href="#">${page_num}</a></li>
														</c:if>
														<c:if test="${page_num != pageInfo.pageNum}">
															<li><a href="javascript:jumpPage(${page_num})">${page_num}</a></li>
														</c:if>
													</c:forEach>

													<!--下一页-->
													<li><c:if test="${pageInfo.hasNextPage}">
															<a href="javascript:jumpPage(${pageInfo.pageNum+1})"
																aria-label="Next"> <span aria-hidden="true">»</span>
															</a>
														</c:if></li>

													<li><a href="javascript:jumpPage(${pageInfo.pages})">尾页</a></li>
												</ul>
											</div>
										</nav>
									</div>
								</div>

							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="commentsInfoModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="exampleModalLabel">评语详情</h4>
						</div>
						<div class="modal-body">
							<form id="selectById_title_form">
										<div class="form-group">
											<label for="message-text" class="control-label">内容：</label>
											<div class="example-box">
												<textarea readonly style="height: 200px" name="replyComments" id="replyComments"
													class="form-control" ></textarea>
											</div>
											<p></p>
											
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
						</div>
					</div>
				</div>
			</div>
			</main>
			<!--End 页面主要内容-->
			<div class="modal fade" id="commentsInfoModal1" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="exampleModalLabel">评语详情</h4>
						</div>
						<div class="modal-body">
							<form id="studentScore_form1">
							<input hidden="hidden" type="text" id="sId" name="sId">
							<input hidden="hidden" type="text" id="titlId" name="titlId">
										<div class="form-group">
											<label for="message-text" class="control-label">内容：</label>
											<div class="example-box">
												<textarea maxlength="255" style="height: 200px"
													class="form-control" id="tComments" name="tComments"></textarea>
											</div>
											<p></p>
											<div class="form-group">
											<label for="message-text" class="control-label">指导教师评分：</label>
											<div class="example-box">
												<input type="text" maxlength="3" class="form-control" name="tScore" id="tScore" ime-mode:disabled" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false"/>
											</div>
											</div>
											
							</form>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="saveStudentScore()">保存</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/perfect-scrollbar.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/main.min.js"></script>

		
	<script type="text/javascript">
	
	
	
	function jumpPage(pageNumber){
		  // 先修改访问的页码
		  document.getElementById("page").value = pageNumber;
		  // 手动提交表单
		  document.getElementById("form_query").submit();
	  };
	  
	  //检验上传文件的类型
	  function fileChange(target,id) {   
          var fileSize = 0;   
          var filetypes =[".zip",".rar"];   
          var filepath = target.value;   
          if(filepath){  
        	  var isnext = false;   
              var fileend = filepath.substring(filepath.indexOf("."));   
              if(filetypes && filetypes.length>0){    
                  for(var i =0; i<filetypes.length;i++){  
                      if(filetypes[i]==fileend){   
                    	  isnext = true;   
                    	  break;   
                    	  }   
                      }   
                  }   
              if(!isnext){  
                  alert("只能上传 .zip .rar 格式的文件！");   
                  target.value ="";   
                  return false;   
                  }   
              }else{   
            	  return false;   
            	  }   
          if (isIE && !target.files) {   
        	  var filePath = target.value;   
        	  var fileSystem = new ActiveXObject("Scripting.FileSystemObject");   
        	  if(!fileSystem.FileExists(filePath)){   
        		  alert("附件不存在，请重新输入！");   
        		  return false;   
        		  }   
        	  var file = fileSystem.GetFile (filePath);   
        	  fileSize = file.Size;   
        	  } else {   
        		  fileSize = target.files[0].size;   
        		  }   
          
          if(size<=0){   
        	  alert("附件大小不能为0M！");   
        	  target.value ="";   
        	  return false;   
        	  }   
          
          }   
	  
	  //删除附件
	  function deleteThesisAttachment(fId) {
		  if(confirm('确实要删除该附件吗?')) {
				$.post("<%=basePath%>file/filedelete",{"fId":fId},
				function(data){
				            if(data =="OK"){
				                alert("附件删除成功！");
				                window.location.reload();
				            }else if(data =="FAIL"){
				                alert("删除附件失败！");
				                window.location.reload();
				            }
				        });
		  }
	  }
	  
	  
	  //检验是否已选择上传文件
	  function check() { 
		  if(f1.file.length==0||f1.file.value==""){
			  alert("请选择上传文件！");
			  return false;
		  }
	  }
	  
	  
	  //下载技术文档
	  function getfId (fId) {
		  $.post("<%=basePath%>file/filedown",{"fId":fId}
					);
	  }
	  
	    
	    //查看指导教师建议 getcomment
	    function getcomment1(tComments,sId,tScore,titlId) {
	    	$("#titlId").val(titlId);
			$("#tComments").val(tComments);
			$("#sId").val(sId);
			$("#tScore").val(tScore);
			
		}
	    
	    //保存指导教师建议和成绩
	    function saveStudentScore() {
	    	if($("#tScore").val()==""){
	    		alert("请输入指导教师评分！");
	    	}
	    	$.post("<%=basePath%>teacher/editStudentScore",
	    			$("#studentScore_form1").serialize(),
	    			function(data){
	    			        if(data =="OK"){
	    			            alert("保存成功！");
	    			            window.location.reload();
	    			        }else{
	    			            alert("保存失败！");
	    			            window.location.reload();
	    			        }
	    			    });
	    	
	    	
	    }
	    
	    function getcomment(tComments) {
	    	var c = tComments;
		            $("#replyComments").val(c);

	    }
	    
	    
	    
	    
	    //将日期转化为指定格式
	    Date.prototype.format = function(fmt) { 
	        var o = { 
	           "M+" : this.getMonth()+1,                 //月份 
	           "d+" : this.getDate(),                    //日 
	           "h+" : this.getHours(),                   //小时 
	           "m+" : this.getMinutes(),                 //分 
	           "s+" : this.getSeconds(),                 //秒 
	           "S"  : this.getMilliseconds()             //毫秒 
	       }; 
	       if(/(y+)/.test(fmt)) {
	               fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	       }
	        for(var k in o) {
	           if(new RegExp("("+ k +")").test(fmt)){
	                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	            }
	        }
	       return fmt; 
	   }       

	</script>
</body>
</html>