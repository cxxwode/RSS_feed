package com.iphone.rssfeed.DaoImpl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.iphone.model.FeedNews;
import com.iphone.rssfeed.Dao.FeedNewsDao;
import com.iphone.rssfeed.util.PageNoUtil;

public class FeedNewsDaoImpl implements FeedNewsDao{
	
	private HibernateTemplate hibernateTemplate;
	@Override
	public void save(FeedNews feedNews) {
		// TODO Auto-generated method stub
		hibernateTemplate.save(feedNews);		
	}
	
	@Override
	public void del(FeedNews feedNews) {
		// TODO Auto-generated method stub
		hibernateTemplate.delete(feedNews);
	}
	@Override
	public List<FeedNews> getAllFeedNews() {
		// TODO Auto-generated method stub
		String hql = "from FeedNews";
		List<FeedNews> list = hibernateTemplate.find(hql);
		return list;
	}
	
	@Override
	public List<FeedNews> getFeedNewsByFeedId(int feedId) {
		// TODO Auto-generated method stub

		String hql = "from FeedNews where feedId = ?";
		List<FeedNews> list = hibernateTemplate.find(hql, feedId);
		return list;
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Override
	public void update(FeedNews feedNews) {
		// TODO Auto-generated method stub
		this.hibernateTemplate.update(feedNews);
	}

	@Override
	public List<FeedNews> getById(int id) {
		String hql = "from FeedNews where id = ?";
		List<FeedNews> list = this.hibernateTemplate.find(hql,id);
		return list;
	}

	@Override
	public void deleteFeedNewsByFeedId(int feedId) {
		String hql = "from FeedNews where feedId = ?";
		List<FeedNews> list = this.hibernateTemplate.find(hql, feedId);
		for(Object o: list){
			FeedNews feednew = (FeedNews)o;
			this.hibernateTemplate.delete(feednew);
		}
		
	}


	public List getListForPage(final String hql, final int offset,
			final int length) {
		
		List list1 = this.hibernateTemplate.executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				// TODO Auto-generated method stub
				List list2 = PageNoUtil.getList(session, hql, offset, length);
				return list2;
			}
		});
		return list1;
	}

	
}
