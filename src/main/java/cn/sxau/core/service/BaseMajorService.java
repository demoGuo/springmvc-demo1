package cn.sxau.core.service;

import java.util.List;

import cn.sxau.core.po.BaseMajor;
public interface BaseMajorService {
	public List<BaseMajor> findMajorBydeptId(String deptId);
	public List<BaseMajor> findMajorBydeptId1(String deptId);
	public BaseMajor findMajorById(String majorId);
	public int createMajor(BaseMajor baseMajor );
	public int editMajor(BaseMajor baseMajor);
	public int editMajor1(String majorId,int s);
}
