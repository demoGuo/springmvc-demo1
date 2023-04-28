package cn.sxau.core.web.controller;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.sxau.core.po.Admin;
import cn.sxau.core.po.Student;
import cn.sxau.core.po.Teacher;
import cn.sxau.core.po.User;
import cn.sxau.core.service.AdminService;
import cn.sxau.core.service.StudentService;
import cn.sxau.core.service.TeacherService;

@Controller
public class UserController {

	@Autowired
	private StudentService studentService;
	@Autowired
	private TeacherService teacherService;
	@Autowired
	private AdminService adminService;


		@RequestMapping("/")
		public String hello(){
			return "forward:index.jsp";
		}
	/**
	 * 用户登录
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String usercode, String password, String role, Model model, HttpSession session) {
		if(role.equals("学生")) {

			Student student = studentService.findStudent(usercode, password);
			if(student!=null) {
				User user = new User();
				user.setRole(role);
				session.setAttribute("USER", user);
				session.setAttribute("USER_INFO", student);
				return "redirect:student/toindex";
			}
		}
		else if(role.equals("教师")) {
			
			Teacher teacher = teacherService.findTeacher(usercode, password);
			if(teacher!=null) {
				User user = new User();
				user.setRole(role);
				session.setAttribute("USER", user);
				session.setAttribute("USER_INFO", teacher);
				return "redirect:teacher/toindex";
			}
		}
		else if(role.equals("管理员")) {
			Admin admin = adminService.findAdmin(usercode, password);
			if(admin!=null) {
				User user = new User();
				user.setRole(role);
				session.setAttribute("USER", user);
				session.setAttribute("USER_INFO", admin);
				return "redirect:admin/toindex";
			}
		}
		
		model.addAttribute("msg", "账号或密码错误，请重新输入！");
		return "login";
	}
	
	/**
	 * 退出登录
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
	    // 清除Session
	    session.invalidate();
	    // 重定向到登录页面的跳转方法
	    return "redirect:tologin";
	}
	
	/**
	 * 向用户登陆页面跳转
	 */
	@RequestMapping(value = "/tologin", method = RequestMethod.GET)
	public String toLogin() {
	    return "login";
	}
	

}
