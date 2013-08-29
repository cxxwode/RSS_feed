package com.iphone.rssfeed.Dao;

import java.util.List;

import com.iphone.model.FeedNews;

public interface FeedNewsDao {

	public List<FeedNews> getById(int id);
	public void save(FeedNews feedNews);
	public void del(FeedNews feedNews);
	public void update(FeedNews feedNews);
	public List<FeedNews> getAllFeedNews();
	public List<FeedNews> getFeedNewsByFeedId(int feedId);
	public void deleteFeedNewsByFeedId(int feedId);
	public List getListForPage(final String hql, final int offset,
			final int length);
}
