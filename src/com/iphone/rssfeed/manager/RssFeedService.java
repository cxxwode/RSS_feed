package com.iphone.rssfeed.manager;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

import com.iphone.model.RssFeed;
import com.iphone.rssfeed.DaoImpl.RssFeedDaoImpl;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

public class RssFeedService {
	
	private RssFeedDaoImpl rssFeedDaoImpl;

	public RssFeedDaoImpl getRssFeedDaoImpl() {
		return rssFeedDaoImpl;
	}

	public void setRssFeedDaoImpl(RssFeedDaoImpl rssFeedDaoImpl) {
		this.rssFeedDaoImpl = rssFeedDaoImpl;
	}

	public void add(RssFeed rd)
	{
		rssFeedDaoImpl.save(rd);
	}
	
	public void deleteByRssFeedId(int rssId)
	{
		this.rssFeedDaoImpl.del(rssFeedDaoImpl.getRssFeedById(rssId));
				
	}
	
	public List<RssFeed> findAll()
	{
		return rssFeedDaoImpl.getAllRssFeed();
	}
	
	public List<RssFeed> findByRssFeedUrl(String url){
	
		return  rssFeedDaoImpl.getRssFeedByURL(url);
	}
	
	public String test(String str){
		return str;
	}
	
//	public SyndFeed getFeed(String rssFeedUrl) throws MalformedURLException, IOException, IllegalArgumentException, FeedException 
//	{
//		java.util.Properties systemsettings = System.getProperties();
//		systemsettings.put("http.proxyhost", "mywebcache.com");
//		systemsettings.put("http.proxyport", "8080");
//		System.setProperties(systemsettings);
//	  
//		//String urlstr = "http://rss.sina.com.cn/news/marquee/ddt.xml";
//		String urlstr=rssFeedUrl; 
//		URLConnection feedurl = new URL(urlstr).openConnection();
//		feedurl.setRequestProperty("user-agent", "mozilla/4.0 (compatible; msie 5.0; windows nt; digext)");
//		SyndFeedInput input = new SyndFeedInput();
//		SyndFeed feed = input.build(new XmlReader(feedurl));
//		return feed;		
//	}

}
