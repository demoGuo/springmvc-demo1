<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>基于Git的实验代码管理系统</title>
</head>
<body">
<script type="text/javascript">
window.onload =function() { 
	var fType="${fType}";
	alert("上传成功！");
	if(fType=='技术文档'){
		location.href = "${pageContext.request.contextPath }/student/projBooklist" ;
	}else if(fType=='程序代码'){
		location.href = "${pageContext.request.contextPath }/student/openReportlist" ;
	}
	else if(fType=='附件'){
		location.href = "${pageContext.request.contextPath }/student/thesisAttachmentlist" ;
	}
};
</script>
</body>
</html>