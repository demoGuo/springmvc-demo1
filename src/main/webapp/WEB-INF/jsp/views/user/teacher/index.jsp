<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基于Git的实验代码管理系统</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/materialdesignicons.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/style.min.css" rel="stylesheet">
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
            <li class="nav-item active"> <a href="${pageContext.request.contextPath }/teacher/toindex" onclick="location.reload()"><i class="mdi mdi-home"></i> 首页</a> </li>
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
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-scale-balance"></i> 总评</a>
              <ul class="nav nav-subnav">
                <li> <a href="${pageContext.request.contextPath }/teacher/studentScore">学生成绩总评</a> </li>
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
              <span class="lyear-toggler-bar"></span>
              <span class="lyear-toggler-bar"></span>
              <span class="lyear-toggler-bar"></span>
            </div>
            <span class="navbar-page-title"> 首页 </span>
          </div>
          
          <ul class="topbar-right">
          
            <li class="dropdown dropdown-profile">
              <a href="javascript:void(0)" data-toggle="dropdown">
                <span style="color:black">${USER_INFO.tName} <span class="caret"></span></span>
              </a>
              <ul class="dropdown-menu dropdown-menu-right">
                <li> <a href="${pageContext.request.contextPath }/teacher/topersonInfo"><i class="mdi mdi-account"></i> 个人信息</a> </li>
                <li> <a href="${pageContext.request.contextPath }/teacher/toeditPwd"><i class="mdi mdi-lock-outline"></i> 修改密码</a> </li>
                <li class="divider"></li>
                <li> <a href="${pageContext.request.contextPath }/logout"><i class="mdi mdi-logout-variant"></i> 退出登录</a> </li>
              </ul>
            </li>

          </ul>
          
        </div>
      </nav>
      
    </header>
    <!--End 头部信息-->
    
    <!--页面主要内容-->
    <main class="lyear-layout-content">
      <div class="container-fluid">
        <div class="row">
        
            <div class="col-lg-6" style="width:50%">
            <div class="card">
              <div class="card-header"><h4>${USER_INFO.tId  }${USER_INFO.tName  } 教师课题选题情况</h4></div>
              <div class="card-body">
                <canvas id="selTitle" width="280" height="475"></canvas>
              </div>
            </div>
          </div>
        <div class="col-lg-6">
            <div class="card">
              <div class="card-header"><h4>${USER_INFO.tId  }${USER_INFO.tName  }所带学生毕业设计完成情况</h4></div>
              <div class="card-body">
                <canvas id="chart-vbar-2" width="400" height="250"></canvas>
              </div>
            </div>
          </div>
        </div>
      </div>
					
    </main>
    <!--End 页面主要内容-->
  </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main.min.js"></script>

<!--图表插件-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/Chart.js"></script>
<script type="text/javascript">
var sum = ${sum};
var s = ${s};
var s1 = ${s1};
var sumProjBook = ${sumProjBook};
var sumOpenReport = ${sumOpenReport};
new Chart($("#selTitle"), {
    type: 'doughnut',
    data: {
        labels: ["已选课题数", "待选课题数", "已被选择但未被指导教师确认的课题数"],
        datasets: [{
            data: [s, sum-s-s1, s1],
            backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)']
        }]
    },
    options: {
        responsive: false
    }
});


new Chart($("#chart-vbar-2"), {
    type: 'bar',
    data: {
        labels: ["技术文档", "程序代码"],
        datasets: [{
            label: "已完成人数",
            backgroundColor: "rgba(51,202,185,0.5)",
            borderColor: "rgba(0,0,0,0)",
            hoverBackgroundColor: "rgba(51,202,185,0.7)",
            hoverBorderColor: "rgba(0,0,0,0)",
            data: [sumProjBook, sumOpenReport]
        },
        {
            label: "未完成人数",
            backgroundColor: "rgba(255,206,86,0.5)",
            borderColor: "rgba(0,0,0,0)",
            hoverBackgroundColor: "rgba(255,206,86,0.7)",
            hoverBorderColor: "rgba(0,0,0,0)",
            data: [s-sumProjBook, s-sumOpenReport]
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</script>
</body>
</html>