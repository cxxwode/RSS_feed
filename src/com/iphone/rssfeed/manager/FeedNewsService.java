package com.iphone.rssfeed.manager;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.List;

import com.iphone.model.FeedNews;
import com.iphone.model.RssFeed;
import com.iphone.rssfeed.DaoImpl.FeedNewsDaoImpl;
import com.iphone.rssfeed.util.RssFeedUtil;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.FeedException;

public class FeedNewsService {
	
	private FeedNewsDaoImpl feedNewsDaoImpl;
	private RssFeedUtil rssFeedUtil;
	
	public FeedNewsService()
	{
		rssFeedUtil=new RssFeedUtil();
	}
	
	public FeedNewsDaoImpl getFeedNewsDaoImpl() {
		return feedNewsDaoImpl;
	}

	public void setFeedNewsDaoImpl(FeedNewsDaoImpl feedNewsDaoImpl) {
		this.feedNewsDaoImpl = feedNewsDaoImpl;
	}
	public void saveFeedNewsByTime()
	{
		
	}
	
	public void saveFeedNewsByRssFeed(RssFeed rssFeed) throws MalformedURLException, IllegalArgumentException, IOException, FeedException
	{
		String str="未读";
		SyndFeed feed=rssFeedUtil.getFeed(rssFeed.getFeedUrl());
		List list = feed.getEntries();
		for (int i=0; i< list.size(); i++) {
			SyndEntry entry = (SyndEntry)list.get(i);
			FeedNews feedNews=new FeedNews();
			feedNews.setFeedId(rssFeed.getId());
			feedNews.setNewsTitle(entry.getTitle().trim());
			feedNews.setNewsUrl(entry.getUri());
			feedNews.setNewsAuthor(entry.getAuthor().trim());
			feedNews.setReadOrNot(str);
			feedNews.setFavorite(0);
			feedNews.setNewsPublishedDate(entry.getPublishedDate());
			feedNewsDaoImpl.save(feedNews);
		}
	}
	
	public List<FeedNews> getFeedNews()
	{
		return this.feedNewsDaoImpl.getAllFeedNews();
		
	}
	
	public List<FeedNews> getFeedNewsByFeedId(int feedId){
		
		return this.feedNewsDaoImpl.getFeedNewsByFeedId(feedId);
	}
	
	public void updateFeedNews(FeedNews feedNews){
		this.feedNewsDaoImpl.update(feedNews);
	}
	
	public List<FeedNews> getFeedNewsById(int Id){
		
		return this.feedNewsDaoImpl.getById(Id);
	}
	
	public void deleteFeedNewsByFeedId(int feedId){
		this.feedNewsDaoImpl.deleteFeedNewsByFeedId(feedId);
	}
	
	public List<FeedNews> getByPager(int feedId, int start, int limit){
		String hql = "from FeedNews where feedId = " + feedId;
		return this.feedNewsDaoImpl.getListForPage(hql, start, limit);
	}
	public void test(){
		this.getFeedNewsByFeedId(1);
	}

}
