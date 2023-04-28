package cn.sxau.core.service;

import cn.sxau.core.po.ScoreProportion;

public interface ScoreProportionService {
	public ScoreProportion getScoreProportion(String proportionId);
	int update(ScoreProportion scoreProportion);
}
