package cn.sxau.core.service;

import java.util.List;

import cn.sxau.core.po.BaseDept;
import cn.sxau.core.po.BaseMajor;
import cn.sxau.core.po.Student;

public interface StudentService {
	public Student findStudent(String sId, String sPwd);
	public Student findStudentById(String sId);
	public int editInfo(Student student);
	public int findStudentSum(String major);
	public List<Student> findStudnetBySeltitlState(String major);
	public List<Student> Studentlist(Student student);
	public int createStudent(Student student);
	public int editInfo1(BaseDept baseDept,String oldName);
	public int editInfo2(BaseMajor baseMajor);
}
