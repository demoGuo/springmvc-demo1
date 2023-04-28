package cn.sxau.core.web.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import cn.sxau.core.po.BaseDept;
import cn.sxau.core.po.BaseMajor;
import cn.sxau.core.po.OpenReport;
import cn.sxau.core.po.ProjBook;
import cn.sxau.core.po.ScoreProportion;
import cn.sxau.core.po.SelectTitle;
import cn.sxau.core.po.Student;
import cn.sxau.core.po.Teacher;
import cn.sxau.core.po.ThesisAttachment;
import cn.sxau.core.po.Title;
import cn.sxau.core.po.Title1;
import cn.sxau.core.service.BaseMajorService;
import cn.sxau.core.service.OpenReportService;
import cn.sxau.core.service.ProjBookService;
import cn.sxau.core.service.ScoreProportionService;
import cn.sxau.core.service.SelectTitleService;
import cn.sxau.core.service.StudentService;
import cn.sxau.core.service.TeacherService;
import cn.sxau.core.service.ThesisAttachmentService;
import cn.sxau.core.service.TitleService;

@Controller
public class TeacherController {
	
	private static final int PAGE_SIZE = 5;
	
	@Autowired
	private TeacherService teacherService;
	
	@Autowired
	private BaseMajorService baseMajorService;
	
	@Autowired
	private TitleService titleService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private SelectTitleService selectTitleService;
	
	@Autowired
	private ProjBookService projBookService;
	
	@Autowired
	private OpenReportService openReportService;

	
	@Autowired
	private ThesisAttachmentService thesisAttachmentService;
	
	@Autowired
	private ScoreProportionService scoreProportionService;
	
	@InitBinder
	 protected void initBinder(WebDataBinder binder) {
	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	 }
	
	/**
	 * 向教师权限选择页面跳转
	 */
	@RequestMapping(value = "/teacher/roleset", method = RequestMethod.GET)
	public String roleset(HttpSession session) {
		return "views/user/teacher/roleset";
	}
	
	/**
	 * 向教师主页面跳转
	 */
	@RequestMapping(value = "/teacher/toindex", method = RequestMethod.GET)
	public ModelAndView toIndex(HttpSession session) {
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		int sum = titleService.findTitleSum1(teacher.gettId(),"已审批");
		int s = selectTitleService.findSelTitleListByState2(teacher.gettId(),"同意");
		int s1 = selectTitleService.findSelTitleListByState2(teacher.gettId(),"待同意");
		int sumProjBook = 0;
		int sumOpenReport = 0;

		int sumThesis = 0;
		List<ProjBook> list = projBookService.findProjBookBytIdAndAgree1(null, teacher.gettId(), "通过");
		if(list!=null) {
			sumProjBook = list.size();
		}
		List<OpenReport> list1 = openReportService.findOpenReportBytIdAndAgree1(null, teacher.gettId(), "通过");
		if(list1!=null) {
			sumOpenReport = list1.size();
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("sum", sum);
		mv.addObject("s", s);
		mv.addObject("s1", s1);
		mv.addObject("sumProjBook", sumProjBook);
		mv.addObject("sumOpenReport", sumOpenReport);
		mv.setViewName("views/user/teacher/index");
	    return mv;
	}
	
	/**
	 * 向教师课题页面跳转
	 */
	@RequestMapping(value = "/teacher/totitlelist")
	public ModelAndView totitlelist(HttpSession session, @ModelAttribute("title") Title title,
			                                               @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		// pageNo 页码      pageSize 每页记录数
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<Title1>list = titleService.findTitleListBytId(title ,(String)teacher.gettId());
		List <BaseMajor> list1 = baseMajorService.findMajorBydeptId(teacher.getDeptId());
		PageInfo<Title1> pageInfo = new PageInfo<>(list,5);
		ModelAndView mv = new ModelAndView();
		mv.addObject("title", title);
		mv.addObject("BaseMajor", list1);
		mv.addObject("pageInfo", pageInfo);
		mv.setViewName("views/user/teacher/titlelist");
		return mv;
	}
	
	/**
	 * 获取选题学生信息
	 */
	@RequestMapping(value = "/teacher/getStudentInfoById")
	@ResponseBody
	public Student getStudentInfoById(String sId) {
		Student student = studentService.findStudentById(sId);
		return student;
	}
	
	/**
	 * 删除课题(教师)
	 */
	@RequestMapping(value = "/teacher/titledelete")
	@ResponseBody
	public String titledelete(Long titlId) {
		int rows = titleService.deleteTitle(titlId);
	    if(rows > 0){			
	        return "OK";
	    }else{
	        return "FAIL";			
	    }
	}
	
	/**
	 * 教师申请新课题
	 */
	@RequestMapping("/teacher/createTitle")
	@ResponseBody
	public String createTitle(Title title,HttpSession session) {
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		title.settId(teacher.gettId());
		title.setTitlState("已审批");
		title.setSelState("未被选择");
	    int rows = titleService.createTitle(title);
	    if(rows > 0){
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	/**
	 * 学生申请新课题
	 */
	@RequestMapping("/teacher/createTitle1")
	@ResponseBody
	public String createTitle1(Title title) {
		String sId = title.getsId();
		title.setTitlState("待指导教师审批");
		title.setSelState("已被选择");
		title.setsId(null);
	    int rows = titleService.createTitle(title);
	    System.out.println(title.getTitlId());
	    if(rows > 0){
	    	SelectTitle selectTitle = new SelectTitle();
	    	selectTitle.setsId(sId);
	    	selectTitle.setTitlId(title.getTitlId());
	    	selectTitle.setSeltitlState("待同意");
	    	selectTitleService.createSelectTitle(selectTitle);
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	/**
	 * 向选题学生页面跳转
	 */
	@RequestMapping(value = "/teacher/toSelecttitlelist")
	public ModelAndView toSelecttitlelist(HttpSession session, @ModelAttribute("title") Title title,
			                                                   @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		// pageNo 页码      pageSize 每页记录数
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<Title> list = selectTitleService.findSelTitleListByState3(title, teacher.gettId(), "待同意");
		PageInfo<Title> pageInfo = new PageInfo<>(list,5);
		ModelAndView mv = new ModelAndView();
		mv.addObject("title", title);
		mv.addObject("pageInfo", pageInfo);
		mv.setViewName("views/user/teacher/selectTitlelist");
		return mv;
	}
	
	/**
	 * 对学生选题情况进行操作
	 */
	@RequestMapping(value = "/teacher/editSelTitle")
	@ResponseBody
	public String editSelTitle(SelectTitle selectTitle) {
		String titlState = titleService.findTitleById(selectTitle.getTitlId()).getTitlState();
		int rows = selectTitleService.updateSelTitle(selectTitle);
		if(rows > 0){
			Title title = new Title();
			title.setTitlId(selectTitle.getTitlId());
			if(selectTitle.getSeltitlState().equals("同意") && titlState.equals("待指导教师审批")) {
				title.setTitlState("待审批");
				titleService.updateTitleById(title);
				SelectTitle selectTitle2 = new SelectTitle();
				selectTitle2.setsId(selectTitle.getsId());
				selectTitle2.setTitlId(selectTitle.getTitlId());
				selectTitle2.setSeltitlState("待专业负责人审批");
				selectTitleService.updateSelTitle(selectTitle2);
			}
			if(selectTitle.getSeltitlState().equals("同意")) {
				title.setSelState("已被选择");
				titleService.updateTitleSelStateById(title);
				SelectTitle selectTitle1 = new SelectTitle();
				selectTitle1.setTitlId(selectTitle.getTitlId());
				selectTitle1.setSeltitlState("待同意");
				selectTitleService.updateSelTitle1(selectTitle1);
			}
			if(selectTitle.getSeltitlState().equals("拒绝") && titlState.equals("待指导教师审批")) {
				title.setTitlState("审批不通过");
				titleService.updateTitleById(title);
			}
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	/**
	 * 学生技术文档列表(已审核)
	 */
	@RequestMapping("/teacher/projBooklist")
	public ModelAndView projBooklist(HttpSession session ,@ModelAttribute("projBook") ProjBook projBook ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<ProjBook>list = projBookService.findProjBookBytIdAndAgree(projBook, teacher.gettId(),"待通过");
		PageInfo<ProjBook> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/projbooklist");
		return mv;
	}
	
	/**
	 * 学生技术文档列表(待审核)
	 */
	@RequestMapping("/teacher/projBooklist1")
	public ModelAndView projBooklist1(HttpSession session ,@ModelAttribute("projBook") ProjBook projBook ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<ProjBook>list = projBookService.findProjBookBytIdAndAgree1(projBook, teacher.gettId(),"待通过");
		PageInfo<ProjBook> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/projbooklist1");
		return mv;
	}
	
	/**
	 * 学生程序代码列表(已审核)
	 */
	@RequestMapping("/teacher/openReportlist")
	public ModelAndView openReportlist(HttpSession session ,@ModelAttribute("openReport") OpenReport openReport ,
                                                            @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<OpenReport>list = openReportService.findOpenReportBytIdAndAgree(openReport, teacher.gettId(),"待通过");
		PageInfo<OpenReport> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/openReportlist");
		return mv;
	}
	
	/**
	 * 学生程序代码列表(待审核)
	 */
	@RequestMapping("/teacher/openReportlist1")
	public ModelAndView openReportlist1(HttpSession session ,@ModelAttribute("openReport") OpenReport openReport ,
                                                            @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<OpenReport>list = openReportService.findOpenReportBytIdAndAgree1(openReport, teacher.gettId(),"待通过");
		PageInfo<OpenReport> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/openReportlist1");
		return mv;
	}

	/**
	 * 学生附件列表
	 */
	@RequestMapping("/teacher/thesisAttachmentlist")
	public ModelAndView thesisAttachmentlist(HttpSession session ,@ModelAttribute("thesisAttachment") ThesisAttachment thesisAttachment ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, PAGE_SIZE);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<ThesisAttachment>list = thesisAttachmentService.findThesisAttachmentList1(thesisAttachment, (String)teacher.gettId());
		PageInfo<ThesisAttachment> pageInfo = new PageInfo<>(list,5);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/thesisAttachmentlist");
		return mv;
	}
	
	/**
	 * 学生成绩总评(教师视图)
	 */
	@RequestMapping("/teacher/studentScore")
	public ModelAndView studentScore (HttpSession session,@RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum){
		PageHelper.startPage(pageNum, 10);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<Title1>list = titleService.findTitleListBytId11((String)teacher.gettId());
		ScoreProportion scoreProportion = scoreProportionService.getScoreProportion("1");
		PageInfo<Title1> pageInfo = new PageInfo<>(list,10);
		ModelAndView mv = new ModelAndView();
		mv.addObject("pageInfo", pageInfo);
		mv.addObject("scoreProportion", scoreProportion);
		mv.setViewName("views/user/teacher/studentscore");
		return mv;
	}
	
	/**
	 * 修改评语和学生成绩(教师视图)
	 */
	@RequestMapping("/teacher/editStudentScore")
	@ResponseBody
	public String studentScore (SelectTitle selectTitle){
		System.out.println(selectTitle.getsId());
		System.out.println(selectTitle.getTitlId());
		System.out.println(selectTitle.gettScore());
		int rows = 0;
		try {
			rows = selectTitleService.updateSelTitle(selectTitle);
		} catch(Exception e) {
			
		}
	    if(rows > 0){
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	/**
	 * 向个人信息修改页面跳转(教师)
	 */
	@RequestMapping(value = "/teacher/topersonInfo")
	public String topersonInfo(HttpSession session) {
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		teacher = teacherService.findTeacher(teacher.gettId(), teacher.gettPwd());
		session.setAttribute("USER_INFO", teacher);
		return "views/user/teacher/personInfo";
	}
	
	/**
	 * 教师信息修改
	 */
	@RequestMapping(value = "/teacher/editInfo")
	@ResponseBody
	public String editInfo(Teacher teacher) {
		int rows =0;
		try{
			rows = teacherService.editInfo(teacher);
			}catch(Exception e){
				rows =0;
			}
		if(rows > 0){
	    	System.out.println("OK");
	        return "OK";
	    }else{
	    	System.out.println("FAIL");
	        return "FAIL";
	    }
	}
	
	
	/**
	 * 向密码修改页面跳转(教师)
	 */
	@RequestMapping(value = "/teacher/toeditPwd")
	public String toeditPwd(HttpSession session) {
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		teacher = teacherService.findTeacherById(teacher.gettId());
		session.setAttribute("USER_INFO", teacher);
		return "views/user/teacher/editPwd";
	}
	
	/**
	 * 教师密码修改
	 */
	@RequestMapping(value = "/teacher/editPwd")
	@ResponseBody
	public String editPwd(Teacher teacher) {
		int rows =0;
		try{
			rows = teacherService.editInfo(teacher);
			}catch(Exception e){
				
			}
		if(rows > 0){
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}

	
	/**
	 * 向已审核课题页面跳转
	 */
	@RequestMapping(value = "/teacher/leading/totitlelist")
	public ModelAndView titlelist(HttpSession session, @ModelAttribute("title") Title title,
			                                               @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		// pageNo 页码      pageSize 每页记录数
		PageHelper.startPage(pageNum, 10);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		title.setMajor(teacher.getMajor());
		title.setTitlState("待审批");
		List<Title1>list = titleService.findTitleListBytitlState(title);
		List<Student> list1= studentService.findStudnetBySeltitlState(teacher.getMajor());
		PageInfo<Title1> pageInfo = new PageInfo<>(list,10);
		ModelAndView mv = new ModelAndView();
		mv.addObject("title", title);
		mv.addObject("list1", list1);
		mv.addObject("pageInfo", pageInfo);
		mv.setViewName("views/user/teacher/leading/titlelist");
		return mv;
	}
	
	/**
	 * 向待审核课题页面跳转
	 */
	@RequestMapping(value = "/teacher/leading/totitlelist1")
	public ModelAndView titlelist1(HttpSession session, @ModelAttribute("title") Title title,
			                                               @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		// pageNo 页码      pageSize 每页记录数
		PageHelper.startPage(pageNum, 10);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		title.setMajor(teacher.getMajor());
		title.setTitlState("待审批");
		List<Title1>list = titleService.findTitleListBytitlState1(title);
		PageInfo<Title1> pageInfo = new PageInfo<>(list,10);
		ModelAndView mv = new ModelAndView();
		mv.addObject("title", title);
		mv.addObject("pageInfo", pageInfo);
		mv.setViewName("views/user/teacher/leading/titlelist1");
		return mv;
	}
	
	/**
	 * 专业负责人审核课题
	 */
	@RequestMapping(value = "/teacher/leading/checkTitle")
	@ResponseBody
	public String checkTitle(Title title) {
		SelectTitle selectTitle = new SelectTitle();
		selectTitle = selectTitleService.findBytitlId(title.getTitlId());
		if(selectTitle!=null) {
			if(title.getTitlState().equals("审批不通过") && selectTitle.getSeltitlState().equals("待专业负责人审批")) {
				selectTitle.setSeltitlState("拒绝");
				selectTitleService.updateSelTitle(selectTitle);
			}
			if(title.getTitlState().equals("已审批") && selectTitle.getSeltitlState().equals("待专业负责人审批")) {
				selectTitle.setSeltitlState("同意");
				selectTitleService.updateSelTitle(selectTitle);
			}
		}
		int rows = titleService.updateTitleById(title);
		if(rows > 0){
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	/**
	 * 给本专业未选择课题的学生手动分配课题
	 */
	@RequestMapping(value = "/teacher/leading/setStudent")
	@ResponseBody
	public String setStudent(HttpSession session,HttpServletRequest request,SelectTitle selectTitle) {
		selectTitle.setSeltitlState("同意");
		int rows =0;
		try{
			rows = selectTitleService.createSelectTitle(selectTitle);
			}catch(Exception e){
				
			}
		if(rows > 0){
			Title title = new Title();
			title.setTitlId(selectTitle.getTitlId());
			title.setSelState("已被选择");
			titleService.updateTitleSelStateById(title);
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	
	/**
	 * 查询已被指导教师审核通过的技术文档
	 */
	@RequestMapping("/teacher/leading/projBooklist")
	public ModelAndView ProjBooklist(HttpSession session ,@ModelAttribute("projBook") ProjBook projBook ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, 10);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<ProjBook>list = projBookService.findProjBookByMajorAndAgree(projBook, teacher.getMajor(), "通过");
		PageInfo<ProjBook> pageInfo = new PageInfo<>(list,10);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/leading/projbooklist");
		return mv;
	}
	
	/**
	 * 查询已被指导教师审核通过的程序代码
	 */
	@RequestMapping("/teacher/leading/openReportlist")
	public ModelAndView OpenReportlist(HttpSession session ,@ModelAttribute("openReport") OpenReport openReport ,
                                                            @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, 10);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<OpenReport>list = openReportService.findOpenReportByMajorAndAgree(openReport, teacher.getMajor(),"通过");
		PageInfo<OpenReport> pageInfo = new PageInfo<>(list,10);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/leading/openReportlist");
		return mv;
	}


	
	/**
	 * 查询学生上传的附件
	 */
	@RequestMapping("/teacher/leading/thesisAttachmentlist")
	public ModelAndView ThesisAttachmentlist(HttpSession session ,@ModelAttribute("thesisAttachment") ThesisAttachment thesisAttachment ,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum) {
		PageHelper.startPage(pageNum, 10);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<ThesisAttachment>list = thesisAttachmentService.findThesisAttachmentListByMajor(thesisAttachment, (String)teacher.getMajor());
		PageInfo<ThesisAttachment> pageInfo = new PageInfo<>(list,10);
        ModelAndView mv = new ModelAndView();
        mv.addObject("pageInfo", pageInfo);
        mv.setViewName("views/user/teacher/leading/thesisAttachmentlist");
		return mv;
	}
	
	/**
	 * 学生成绩总评(专业负责人视图)
	 */
	@RequestMapping("/teacher/leading/studentScore")
	public ModelAndView StudentScore (HttpSession session,@ModelAttribute("title") Title title,
			                                              @RequestParam(value="pageNum",required=false,defaultValue="1") int pageNum){
		PageHelper.startPage(pageNum, 10);
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<Title1>list = titleService.findTitleListBymajor(title,teacher.getMajor());
		ScoreProportion scoreProportion = scoreProportionService.getScoreProportion("1");
		PageInfo<Title1> pageInfo = new PageInfo<>(list,10);
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.addObject("pageInfo", pageInfo);
		mv.addObject("scoreProportion", scoreProportion);
		mv.setViewName("views/user/teacher/leading/studentScore");
		return mv;
	}
	
	/**
	 * 修改答辩评语和学生成绩(专业负责人视图)
	 */
	@RequestMapping("/teacher/leading/editStudentScore")
	@ResponseBody
	public String editStudentScore (SelectTitle selectTitle){
		int rows = 0;
		try {
			rows = selectTitleService.updateSelTitle(selectTitle);
		} catch(Exception e) {
			
		}
	    if(rows > 0){
	        return "OK";
	    }else{
	        return "FAIL";
	    }
	}
	

	/**
	 * 向创建答辩组页面跳转(专业负责人)
	 */
	@RequestMapping(value = "/teacher/leading/tocreateReply")
	public ModelAndView tocreateReply(HttpSession session) {
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		List<Teacher> list= teacherService.findTeacherBydept(teacher.getDept());
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("views/user/teacher/leading/newReply");
		return mv;
	}
	
	/**
	 * 向个人信息修改页面跳转(专业负责人)
	 */
	@RequestMapping(value = "/teacher/leading/topersonInfo")
	public String TopersonInfo(HttpSession session) {
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		teacher = teacherService.findTeacher(teacher.gettId(), teacher.gettPwd());
		session.setAttribute("USER_INFO", teacher);
		return "views/user/teacher/leading/personInfo";
	}	
	
	/**
	 * 向密码修改页面跳转(专业负责人)
	 */
	@RequestMapping(value = "/teacher/leading/toeditPwd")
	public String ToeditPwd(HttpSession session) {
		Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
		teacher = teacherService.findTeacherById(teacher.gettId());
		session.setAttribute("USER_INFO", teacher);
		return "views/user/teacher/leading/editPwd";
	}
	
	// 导出学生成绩信息
	@RequestMapping("/teacher/leading/export")
	public void export(HttpSession session,HttpServletResponse response) {
		
	HSSFWorkbook book = new HSSFWorkbook();
	//创建sheet
	HSSFSheet sheet = book.createSheet("学生成绩表");
	sheet.setDefaultColumnWidth(15);
	sheet.setColumnWidth(3, 40*256);
	sheet.setColumnWidth(5, 40*256);
	sheet.setColumnWidth(8, 40*256);
	sheet.setColumnWidth(11, 40*256);
	sheet.setColumnWidth(14, 40*256);

	//创建标题列
	HSSFRow titleRow = sheet.createRow(0);
	//创建表单单元格并设置值
	titleRow.createCell(0).setCellValue("编号");
	titleRow.createCell(1).setCellValue("学号");
	titleRow.createCell(2).setCellValue("学生姓名");
	titleRow.createCell(3).setCellValue("题目");
	titleRow.createCell(4).setCellValue("指导教师");
	titleRow.createCell(5).setCellValue("指导教师评语");
	titleRow.createCell(6).setCellValue("指导教师评分");
	titleRow.createCell(7).setCellValue("答辩组组长");
	titleRow.createCell(8).setCellValue("答辩组组长评语");
	titleRow.createCell(9).setCellValue("答辩组组长评分");
	titleRow.createCell(10).setCellValue("评阅教师");
	titleRow.createCell(11).setCellValue("评阅教师评语");
	titleRow.createCell(12).setCellValue("评阅教师评分");
	titleRow.createCell(13).setCellValue("评阅教师");
	titleRow.createCell(14).setCellValue("评阅教师评语");
	titleRow.createCell(15).setCellValue("评阅教师评分");
	titleRow.createCell(16).setCellValue("总成绩");
	
	Teacher teacher = (Teacher)session.getAttribute("USER_INFO");
	List<Title1>list = titleService.findTitleListBymajor2(teacher.getMajor());

	for (int i = 0; i < list.size(); i++) {

	Title1 title = list.get(i);

	HSSFRow row = sheet.createRow(i+1);
	
	row.createCell(0).setCellValue(i+1);
	row.createCell(1).setCellValue(title.getsId());
	row.createCell(2).setCellValue(title.getsName());
	row.createCell(3).setCellValue(title.getTitlName());
	row.createCell(4).setCellValue(title.gettName());
	if(title.gettComments()==null) {
		row.createCell(5).setCellValue("");
	}else {
		row.createCell(5).setCellValue(title.gettComments());
	}
	if(title.gettScore()==0) {
		row.createCell(6).setCellValue("");
	}else {
		row.createCell(6).setCellValue(title.gettScore());
	}
	
	if(title.getReplyScore()==null) {
		row.createCell(7).setCellValue("");
		row.createCell(8).setCellValue("");
		row.createCell(9).setCellValue("");
		row.createCell(10).setCellValue("");
		row.createCell(11).setCellValue("");
		row.createCell(12).setCellValue("");
		row.createCell(13).setCellValue("");
		row.createCell(14).setCellValue("");
		row.createCell(15).setCellValue("");
	}
	
	if(title.gettScore()==0 ||title.getReplyScore()==null) {
		row.createCell(16).setCellValue("成绩未全");
	}
	else {
		row.createCell(16).setCellValue(title.gettScore()*0.5 + title.getReplyScore());
	}
	
	}

	try {
	//设置响应头,响应的内容是为附件形式
	response.addHeader("Content-Disposition",
	"attachment;filename=" + new String("学生成绩表.xls".getBytes(), "ISO-8859-1"));
	book.write(response.getOutputStream());
	} catch (Exception e) {
	e.printStackTrace();
	}
	}
}
