package com.iphone.rssfeed.util;

import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.sun.syndication.io.FeedException;

public class NFDFlightDataTaskListener implements ServletContextListener{
		@Override
		public void contextDestroyed(ServletContextEvent arg0) {
			//销毁时的代码
			TimerManager.cancel();
		}
		@Override
			//在服务启动时，执行此方法。
		public void contextInitialized(ServletContextEvent arg0) {
			new TimerManager();
		}
	}	
		//要执行的任务
	class NFDFlightDataTimerTask extends TimerTask{
		RssFeedNewsRefresh rfnrf=new RssFeedNewsRefresh();
		@Override
		//此方法为具体要定时操作的方法
		public void run() {
			System.out.println("定时器测试:"+ new Timestamp(new Date().getTime()));
			try {
				rfnrf.RssFeedNewsRefreshDo();
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (FeedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		@Override
		public boolean cancel() {
			// TODO Auto-generated method stub
			return super.cancel();
		}
	}
	
	class TimerManager{
		private static final long PERIOD_DAY=  6000 * 1000;  //每隔六十秒执行一次
		private static Timer timer = new Timer(); 
		public TimerManager() {                  
			
			Timer timer = new Timer();     //定时器实例化
			NFDFlightDataTimerTask task = new NFDFlightDataTimerTask();   //要执行的任务
			//安排指定的任务在指定的时间开始进行重复的固定延迟执行。  
            timer.schedule(task,PERIOD_DAY); 
       }  
		
		public static void cancel(){
			timer.cancel();
		}
		
}
