package cn.sxau.core.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sxau.core.po.Comments;
import cn.sxau.core.po.Teacher;
import cn.sxau.core.service.CommentsServer;
import cn.sxau.core.service.OpenReportService;
import cn.sxau.core.service.ProjBookService;

@Controller
public class CommentsController {

	@Autowired
	private CommentsServer commentsServer;
	
	@Autowired
	private ProjBookService projBookService;
	
	@Autowired
	private OpenReportService openReportService;

	
	
	/**
	 * 查看建议详情ById
	 */
	@RequestMapping("/comments/getcommentsById")
	@ResponseBody
	public Comments getcommentsById(Long fId) {
		
		try {
			Comments comments =  commentsServer.getcomments(fId);
			return comments;
		}catch(Exception e) {
			return null;
		}

	}
	
	
	/**
	 * 生成建议(教师)
	 */
	@RequestMapping("/comments/createComments")
	@ResponseBody
	public String createComments(HttpSession session,HttpServletRequest request,Comments comments) {
		String agree = request.getParameter("agree");
		String role = request.getParameter("role");
		int rows = 0;
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		try {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String nowtime = df.format(new Date());
	        System.out.println(nowtime);// new Date()为获取当前系统时间
	        Date date = df.parse(nowtime);
	        comments.setDatetime(date);
	        comments.settId(teacher.gettId());
			rows = commentsServer.createComments(comments);
		} catch(Exception e) {
			
		}
		if(rows > 0){
			if(role.equals("技术文档")) {
				projBookService.updateAgreeByfId(comments.getfId(), agree);
			}
			else if(role.equals("程序代码")) {
				openReportService.updateAgreeByfId(comments.getfId(), agree);
			}
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	
}
