package com.iphone.rssfeed.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.orm.hibernate3.HibernateTemplate;

import com.iphone.model.RssFeed;
import com.iphone.rssfeed.Dao.RssFeedDao;

public class RssFeedDaoImpl implements RssFeedDao{
	
	private HibernateTemplate hibernateTemplate;
	

	@Override
	public List<RssFeed> getRssFeedByURL(String url) {
		// TODO Auto-generated method stub
		String sql = "from RssFeed where feedUrl = ?";
		return this.hibernateTemplate.find(sql, url);
		
	}
	@Override
	public void save(RssFeed rssFeed)
	{
		this.hibernateTemplate.save(rssFeed);
	}
	@Override
	public void del(RssFeed rssFeed) {
		// TODO Auto-generated method stub
		this.hibernateTemplate.delete(rssFeed);
	}
	@Override
	public RssFeed getRssFeedById(int feedId) {
		// TODO Auto-generated method stub
		Object o = hibernateTemplate.load(RssFeed.class, feedId);		
		return (RssFeed)o;
	}
	
	
	@Override
	public List<RssFeed> getAllRssFeed()
	{
		String hql = "from RssFeed";
		List<RssFeed> list = hibernateTemplate.find(hql);
		return list;
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}
	
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}



//	public RssFeed getRssFeed() { 
//		return rssFeed;
//	}
//
//	public void setRssFeed(RssFeed rssFeed) {
//		this.rssFeed = rssFeed;
//	}
//	
//	public SyndFeed getFeed() throws MalformedURLException, IOException, IllegalArgumentException, FeedException
//	{
//		java.util.Properties systemsettings = System.getProperties();
//		systemsettings.put("http.proxyhost", "mywebcache.com");
//		systemsettings.put("http.proxyport", "8080");
//		System.setProperties(systemsettings);
//	  
//		//String urlstr = "http://rss.sina.com.cn/news/marquee/ddt.xml";
//		String urlstr=rssFeed.getFeedUrl(); 
//		URLConnection feedurl = new URL(urlstr).openConnection();
//		feedurl.setRequestProperty("user-agent", "mozilla/4.0 (compatible; msie 5.0; windows nt; digext)");
//		SyndFeedInput input = new SyndFeedInput();
//		SyndFeed feed = input.build(new XmlReader(feedurl));
//		return feed;		
//	}

}
