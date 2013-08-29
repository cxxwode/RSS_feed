package com.iphone.test;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.iphone.model.FeedNews;
import com.iphone.model.RssFeed;
import com.iphone.rssfeed.manager.FeedNewsService;
import com.iphone.rssfeed.manager.RssFeedService;
import com.sun.syndication.io.FeedException;

public class Test {

	ApplicationContext ctx=new ClassPathXmlApplicationContext("beans.xml");
	@org.junit.Test
	public void test() throws MalformedURLException, IllegalArgumentException, IOException, FeedException {
		//RssFeedDaoImpl rf=(RssFeedDaoImpl)ctx.getBean("RssFeedDAO");
		RssFeedService rfs=(RssFeedService)ctx.getBean("rssFeedService");
//		RssFeed rssfeed=new RssFeed();
//		rssfeed.setFeedName("国内焦点 ");
//		rssfeed.setFeedUrl("http://blog.sina.com.cn/rss/xlhd001.xml ");
		//rf.save(rssfeed);	
//		rfs.add(rssfeed);
//		rfs.deleteByRssFeedId(10);
		List l = rfs.findAll();
		System.out.println(l.size());
		//List l = rf.getAllRssFeed();
//		RssFeed rfd = null;
		FeedNewsService fns = (FeedNewsService)ctx.getBean("feedNewsService");
		List<FeedNews> f = fns.getByPager(36, 2, 10);
		for(FeedNews o:f)
		{
			System.out.println(o.getId() + "-" + o.getNewsTitle() + "-" + o.getNewsAuthor());
		}
//		System.out.println(rfd.getFeedName());
				
	}

}
