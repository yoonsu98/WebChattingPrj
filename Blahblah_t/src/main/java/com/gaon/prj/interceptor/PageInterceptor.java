package com.gaon.prj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class PageInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String path 		= request.getServletPath();
		String query 		= request.getQueryString();
		HttpSession httpSession = request.getSession();
		if(query != null){ 
            httpSession.setAttribute("prev_url", path+"?"+query);
        }else{
            httpSession.setAttribute("prev_url", path);
        }
		return true;
	}
}
