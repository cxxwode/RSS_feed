package com.iphone.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.codehaus.jackson.map.ObjectMapper;

import com.iphone.model.FeedNews;
import com.iphone.rssfeed.manager.FeedNewsService;
import com.iphone.rssfeed.util.RssFeedUtil;

public class FeedNewsServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	    resp.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/html");
	    PrintWriter out;
		String json = "{\"page\":\"1\",\"total\":2,\"records\":\"13\",\"rows\":[{\"id\":\"1\",\"invdate\":\"2007-10-01\",\"name\":\"Client 1\",\"amount\":\"100.00\",\"tax\":\"20.00\",\"total\":\"120.00\",\"note\":\"note 1\"},{\"id\":\"2\",\"invdate\":\"2007-10-03\",\"name\":\"Client 1\",\"amount\":\"200.00\",\"tax\":\"40.00\",\"total\":\"240.00\",\"note\":\"note 2\"},{\"id\":\"3\",\"invdate\":\"2007-10-02\",\"name\":\"Client 2\",\"amount\":\"300.00\",\"tax\":\"60.00\",\"total\":\"360.00\",\"note\":\"note invoice 3 & and amp test\"},{\"id\":\"4\",\"invdate\":\"2007-10-04\",\"name\":\"Client 3\",\"amount\":\"150.00\",\"tax\":\"0.00\",\"total\":\"150.00\",\"note\":\"no tax\"},{\"id\":\"5\",\"invdate\":\"2007-10-05\",\"name\":\"Client 3\",\"amount\":\"100.00\",\"tax\":\"0.00\",\"total\":\"100.00\",\"note\":\"no tax at all\"},{\"id\":\"6\",\"invdate\":\"2007-10-05\",\"name\":\"Client 1\",\"amount\":\"50.00\",\"tax\":\"10.00\",\"total\":\"60.00\",\"note\":\"\"},{\"id\":\"7\",\"invdate\":\"2007-10-05\",\"name\":\"Client 2\",\"amount\":\"120.00\",\"tax\":\"12.00\",\"total\":\"134.00\",\"note\":null},{\"id\":\"8\",\"invdate\":\"2007-10-06\",\"name\":\"Client 3\",\"amount\":\"200.00\",\"tax\":\"0.00\",\"total\":\"200.00\",\"note\":null},{\"id\":\"9\",\"invdate\":\"2007-10-06\",\"name\":\"Client 1\",\"amount\":\"200.00\",\"tax\":\"40.00\",\"total\":\"240.00\",\"note\":null},{\"id\":\"10\",\"invdate\":\"2007-10-06\",\"name\":\"Client 2\",\"amount\":\"100.00\",\"tax\":\"20.00\",\"total\":\"120.00\",\"note\":null}]}";
	    out = resp.getWriter();  
		out.write(json.toString()); // 将JSON数据返回页面
		System.out.println(json);
		out.flush();
		out.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		RssFeedUtil rssFeedUtil = new RssFeedUtil();
	//	mapper.
		FeedNewsService fns = rssFeedUtil.getFeedNewsService();
		int feedId = Integer.parseInt(req.getParameter("feedId"));
		int limit = Integer.parseInt(req.getParameter("rows"));
		int page = Integer.parseInt(req.getParameter("page"));
		int start = limit*page - limit;
		
		System.out.println(feedId);
		List<FeedNews> feedNews = fns.getFeedNewsByFeedId(feedId);
		List<FeedNews> paperFeedNews = fns.getByPager(feedId, start, limit);
		try {
			int records = feedNews.size();  //all records
			int total = 0;  //all pages
			if(limit != 0){
				total  = records / limit;  
			}
			if(page > total) page = total;
			
		    resp.setCharacterEncoding("UTF-8");
		    resp.setContentType("text/html");
		    PrintWriter out;  
		    
		    JSONArray json2 = JSONArray.fromObject(paperFeedNews);
		    JSONObject json1 = new JSONObject() ;
	        // 根据jqGrid对JSON的数据格式要求给jsonObj赋值  
		    json1.put("page", page);     // 当前页  
		    json1.put("total", total);    // 总页数  
		    json1.put("records", records);  // 总记录数  
		    json1.put("rows", json2);
			//String json = "{\"page\":\"1\",\"total\":2,\"records\":\"13\",\"rows\":[{\"id\":\"1\",\"invdate\":\"2007-10-01\",\"name\":\"Client 1\",\"amount\":\"100.00\",\"tax\":\"20.00\",\"total\":\"120.00\",\"note\":\"note 1\"},{\"id\":\"2\",\"invdate\":\"2007-10-03\",\"name\":\"Client 1\",\"amount\":\"200.00\",\"tax\":\"40.00\",\"total\":\"240.00\",\"note\":\"note 2\"},{\"id\":\"3\",\"invdate\":\"2007-10-02\",\"name\":\"Client 2\",\"amount\":\"300.00\",\"tax\":\"60.00\",\"total\":\"360.00\",\"note\":\"note invoice 3 & and amp test\"},{\"id\":\"4\",\"invdate\":\"2007-10-04\",\"name\":\"Client 3\",\"amount\":\"150.00\",\"tax\":\"0.00\",\"total\":\"150.00\",\"note\":\"no tax\"},{\"id\":\"5\",\"invdate\":\"2007-10-05\",\"name\":\"Client 3\",\"amount\":\"100.00\",\"tax\":\"0.00\",\"total\":\"100.00\",\"note\":\"no tax at all\"},{\"id\":\"6\",\"invdate\":\"2007-10-05\",\"name\":\"Client 1\",\"amount\":\"50.00\",\"tax\":\"10.00\",\"total\":\"60.00\",\"note\":\"\"},{\"id\":\"7\",\"invdate\":\"2007-10-05\",\"name\":\"Client 2\",\"amount\":\"120.00\",\"tax\":\"12.00\",\"total\":\"134.00\",\"note\":null},{\"id\":\"8\",\"invdate\":\"2007-10-06\",\"name\":\"Client 3\",\"amount\":\"200.00\",\"tax\":\"0.00\",\"total\":\"200.00\",\"note\":null},{\"id\":\"9\",\"invdate\":\"2007-10-06\",\"name\":\"Client 1\",\"amount\":\"200.00\",\"tax\":\"40.00\",\"total\":\"240.00\",\"note\":null},{\"id\":\"10\",\"invdate\":\"2007-10-06\",\"name\":\"Client 2\",\"amount\":\"100.00\",\"tax\":\"20.00\",\"total\":\"120.00\",\"note\":null}]}";
		    out = resp.getWriter();  
			out.write(json1.toString()); // 将JSON数据返回页面
			System.out.println(json1);
			out.flush();
			out.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	
}
