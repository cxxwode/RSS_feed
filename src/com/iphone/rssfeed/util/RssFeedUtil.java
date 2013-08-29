package com.iphone.rssfeed.util;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.iphone.rssfeed.manager.FeedNewsService;
import com.iphone.rssfeed.manager.RssFeedService;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

public class RssFeedUtil {
	
	private static ApplicationContext ctx = new ClassPathXmlApplicationContext("beans.xml");
	
	public SyndFeed getFeed(String rssFeedUrl) throws MalformedURLException, IOException, IllegalArgumentException, FeedException 
	{
		String urlstr;
		java.util.Properties systemsettings = System.getProperties();
		systemsettings.put("http.proxyhost", "mywebcache.com");
		systemsettings.put("http.proxyport", "8080");
		System.setProperties(systemsettings);
		
		if(rssFeedUrl!=null)
		{
			//String urlstr = "http://rss.sina.com.cn/news/marquee/ddt.xml";
//			http://blog.sina.com.cn/rss/THEBUND.xml
//			http://tech.163.com/special/00091JPQ/rssit.xml
			urlstr=rssFeedUrl; 
		}
		else{
		 urlstr = "http://rss.sina.com.cn/news/marquee/ddt.xml";
		}
		URLConnection feedurl = new URL(urlstr).openConnection();
		feedurl.setRequestProperty("user-agent", "mozilla/4.0 (compatible; msie 5.0; windows nt; digext)");
		SyndFeedInput input = new SyndFeedInput();
		SyndFeed feed = input.build(new XmlReader(feedurl));
		return feed;		
	}
	
	public FeedNewsService getFeedNewsService() {
		FeedNewsService fns = (FeedNewsService) ctx.getBean("feedNewsService");
		return fns;
	}
	
	public RssFeedService getRssFeedService() {
		RssFeedService rfs = (RssFeedService) ctx.getBean("rssFeedService");
		return rfs;
	}

}
