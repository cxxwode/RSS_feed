package com.iphone.rssfeed.util;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.iphone.model.RssFeed;
import com.iphone.rssfeed.manager.FeedNewsService;
import com.iphone.rssfeed.manager.RssFeedService;
import com.sun.syndication.io.FeedException;

public class RssFeedNewsRefresh {

	ApplicationContext ctx=new ClassPathXmlApplicationContext("beans.xml");
	RssFeedService rfs=(RssFeedService)ctx.getBean("rssFeedService");
	RssFeed rfd = null;
	FeedNewsService fns = (FeedNewsService)ctx.getBean("feedNewsService");
	public void RssFeedNewsRefreshDo() throws MalformedURLException, IllegalArgumentException, IOException, FeedException
	{		
		List l = rfs.findAll();
		System.out.println(l.size());		
		for(Object o:l)
		{
			rfd = (RssFeed)o;
			System.out.println(rfd.getFeedName());
			fns.saveFeedNewsByRssFeed(rfd);
		}
	}
}
