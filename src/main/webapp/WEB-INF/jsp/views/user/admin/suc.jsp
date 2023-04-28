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
            <li class="nav-item"> <a href="${pageContext.request.contextPath }/admin/toindex" onclick="location.reload()"><i class="mdi mdi-home"></i> 首页</a> </li>
            <li class="nav-item nav-item-has-subnav open active">
              <a href="javascript:void(0)"><i class="mdi mdi-human"></i> 用户管理</a>
              <ul class="nav nav-subnav">
                <li class="active"> <a href="${pageContext.request.contextPath }/admin/toteacherlist">教师信息管理</a> </li>
                <li> <a href="${pageContext.request.contextPath }/admin/tostudentlist">学生信息管理</a> </li>
              </ul>
            </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-application"></i> 系部/专业管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="${pageContext.request.contextPath }/admin/todeptlist">系部/专业</a> </li>
              </ul>
            </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-file"></i> 文件管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="${pageContext.request.contextPath }/admin/tofilelist">学生上传文件管理</a> </li>
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
							<span class="navbar-page-title"> 教师信息管理</span>
						</div>

						<ul class="topbar-right">
							<li class="dropdown dropdown-profile"><a
								href="javascript:void(0)" data-toggle="dropdown"> <span
									style="color: black">${USER_INFO.adminId} <span
										class="caret"></span></span>
							</a>
								<ul class="dropdown-menu dropdown-menu-right">
									
									<li><a
										href="${pageContext.request.contextPath }/admin/toeditPwd"><i
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

			<!--页面主要内容-->
			<main class="lyear-layout-content">

			<div class="container-fluid">
				<h1>数据导出成功请在E盘查看！</h1>
			</div>
			</main>
			<!--End 页面主要内容-->
			<div class="modal fade" id="newTeacherDialog" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="exampleModalLabel">教师信息详情</h4>
						</div>
						<div class="modal-body">
							<form id="create_teacher_form">
								<div class="form-group">
									<label for="new_tId" class="control-label">教师号：</label>
									<input  type="text" maxlength="25" class="form-control" id="new_tId" name="tId">
								</div>
								<div class="form-group">
									<label for="new_tName" class="control-label">教师名称：</label>
									<input  type="text" maxlength="16" class="form-control" id="new_tName" name="tName">
								</div>
								<div class="form-group">
									<label for="new_dept" class="control-label">所属系部：</label>
									<select class="form-control" id="new_dept" name="deptId" onchange="change()">
									<option value="-1">--请选择--</option>
									<c:forEach items="${BaseDept}" var="item">
								    <option value="${item.deptId}">
								    ${item.deptName }
								    </option>
							        </c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label for="new_title" class="control-label">职称</label>
									<input  type="text" maxlength="16" class="form-control" id="new_title" name="title">
								</div>
								<div class="form-group">
									<label for="new_duties" class="control-label">职务</label>
									<input  type="text" maxlength="16" class="form-control" id="new_duties" name="duties">
								</div>
								<div class="form-group">
									<label for="new_phone" class="control-label">手机</label>
									<input  type="text" maxlength="11" class="form-control" id="new_phone" name="phone">
								</div>
								<div class="form-group">
									<label for="new_email" class="control-label">邮箱</label>
									<input  type="text" maxlength="32" class="form-control" id="new_email" name="email">
								</div>
								<div class="form-group">
									<label for="new_power" class="control-label">是否专业负责人</label>
									<select class="form-control " id="new_power" name="power">
									<option value="-1">--请选择--</option>
									<option value="是">是</option>
									<option value="否">否</option>
									</select>
								</div>
								<div class="form-group">
									<label for="new_major" class="control-label">负责专业</label>
									<select class="form-control" id="new_major" name="majorId">

									</select>
								</div>
							</form>
						</div>
						<div class="modal-footer">
						    <button type="button" class="btn btn-primary" onclick="createTeacher()">添加教师</button>
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
	
	  function clearTeacher() {
		  $("#new_tId").val("");
		    $("#new_tName").val("");
		    $("#new_dept").val("-1");
		    $("#new_title").val("");
		    $("#new_duties").val("");
		    $("#new_phone").val("");
		    $("#new_email").val("");
		    $("#new_power").val("-1");
		    $("#new_major").html("");
		  
	  }
	  
	  function deleteTitle(tId,s) {
		  if(confirm('确实要删除/恢复该教师吗?')){
			  $.post("<%=basePath%>admin/deleteTeacher",{"tId":tId,"s":s},function(data){
					if(data =="OK"){
						alert("操作成功！");
						window.location.reload();
					}else{
						alert("操作失败！");
						window.location.reload();
					}
				});
		  }
	  }	  
	  
	  
		function editTeacher(tId) {
		    $.ajax({
		        type:"get",
		        url:"<%=basePath%>admin/getTeacherBytId",
		        data:{"tId":tId},
		        success:function(data) {
		            $("#tId").val(data.tId);
		            $("#tName").val(data.tName);
		            $("#dept").val(data.deptId);
		            $("#title").val(data.title);
		            $("#duties").val(data.duties);
		            $("#phone").val(data.phone);
		            $("#email").val(data.email);
		            $("#power").val(data.power);
		            if(data.majorId!=null){
		            	$("#major").val(data.majorId);
		            }
		            else $("#major").val();
		            
		        }
		    });
		}
	  
	  function saveTeacherinfo() {
		  var phone = document.getElementById('phone').value;
		  if($("#tId").val()=='') {
			  alert("请输入教师号！");
			  return;
		  }
		  if($("#tName").val()=='') {
			  alert("请输入教师姓名！");
			  return;
		  }
		  if($("#dept").val()=='-1') {
			  alert("请选择系别！");
			  return;
		  }
		  if(phone!='' && !(/^1[34578]\d{9}$/.test(new_phone))){ 
		        alert("手机号码有误，请重填");  
		        return false; 
		    } 
		  if($("#power").val()=='-1') {
			  alert("请选择是否为专业负责人！");
			  return;
		  }
		  if($("#power").val()=='是' && $("#major").val()=='') {
			  alert("请选择负责专业！");
			  return;
		  }
		  if($("#power").val()=='否') {
			  $("#major").val("");
		  }
		  $.post("<%=basePath%>admin/updateTeacher",$("#selectById_teacher_form").serialize(),function(data){
				if(data =="OK"){
					alert("教师信息更新成功！");
					window.location.reload();
				}else{
					alert("教师信息更新失败！");
					window.location.reload();
				}
			});
	  }
	  
	  function createTeacher() {
		  var new_phone = document.getElementById('new_phone').value;
		  if($("#new_tId").val()=='') {
			  alert("请输入教师号！");
			  return;
		  }
		  if($("#new_tName").val()=='') {
			  alert("请输入教师姓名！");
			  return;
		  }
		  if($("#new_dept").val()=='-1') {
			  alert("请选择系别！");
			  return;
		  }
		  if(new_phone!='' && !(/^1[34578]\d{9}$/.test(new_phone))){ 
		        alert("手机号码有误，请重填");  
		        return false; 
		    } 
		  if($("#new_power").val()=='-1') {
			  alert("请选择是否专业负责人！");
			  return;
		  }
		  if($("#new_power").val()=='是' && $("#new_major").val()=='') {
			  alert("请选择负责专业！");
			  return;
		  }
		  $.post("<%=basePath%>admin/createTeacher",
					$("#create_teacher_form").serialize(),function(data){
					        if(data =="OK"){
					            alert("添加教师成功！");
					            window.location.reload();
					        }else{
					            alert("添加教师失败！");
					            window.location.reload();
					        }
					    });
		  
	  }
	  
	  function change() {
		  var deptId = $("#new_dept").val();
		  if(dept=='-1') {
			  $("#new_major").html("");
			  return;
		  }
		  $.ajax({
			   type : "POST",
			   url : "<%=basePath%>admin/changeDept",
			   data : {"deptId":deptId},
			   dataType : "json",
			   success: function (date) {
                   var optionstring = "";
                   for (var j = 0; j < date.length;j++) {
                       optionstring += "<option value=\"" + date[j].majorId + "\" >" +date[j].majorName+" " + "</option>";
                       $("#new_major").html("<option value=''>请选择...</option> "+optionstring);
                   }
               },

               error: function (msg) {
                   layer.msg('数据出错了!!');
               }
			  });
	  }
	  
	  function change2() {
		  $("#major").html("");
		  var deptId = $("#dept").val();
		  if(deptId=='-1') {
			  $("#major").html("");
			  return;
		  }
		  $.ajax({
			   type : "POST",
			   url : "<%=basePath%>admin/changeDept",
			   data : {"deptId":deptId},
			   dataType : "json",
			   success: function (date) {
                   var optionstring = "";
                   for (var j = 0; j < date.length;j++) {
                       optionstring += "<option value=\"" + date[j].majorId + "\" >" +date[j].majorName+" " + "</option>";
                       $("#major").html("<option value='无'>请选择...</option> "+optionstring);
                   }
               },

               error: function (msg) {
                   layer.msg('数据出错了!!');
               }
			  });
	  }
	  
	  function change1(val) {
		  var deptId = val;
		  if(dept=='-1') {
			  $("#major").html("");
			  return;
		  }
		  $.ajax({
			   type : "POST",
			   url : "<%=basePath%>admin/changeDept",
			   data : {"deptId":deptId},
			   dataType : "json",
			   success: function (date) {
                   var optionstring = "";
                   for (var j = 0; j < date.length;j++) {
                       optionstring += "<option value=\"" + date[j].majorId + "\" >" +date[j].majorName+" " + "</option>";
                       $("#major").html("<option value=''>请选择...</option> "+optionstring);
                   }
               },

               error: function (msg) {
                   layer.msg('数据出错了!!');
               }
			  });
	  }
	</script>



</body>
</html>