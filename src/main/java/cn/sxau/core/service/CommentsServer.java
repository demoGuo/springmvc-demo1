package cn.sxau.core.service;

import cn.sxau.core.po.Comments;

public interface CommentsServer {

	public Comments getcommentsById(Long cId);
	public Comments getcomments(Long fId);
	public int createComments(Comments comments);

}
