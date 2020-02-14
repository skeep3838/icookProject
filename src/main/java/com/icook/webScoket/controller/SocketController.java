package com.icook.webScoket.controller;


import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icook.model.socketBean;
import com.icook.webScoket.service.socketServiceDao;



@Controller
public class SocketController {
	@Autowired
	socketServiceDao service;

	@Autowired
	public void setService(socketServiceDao service) {
		this.service = service;
	}

	
	@RequestMapping(value = "/WebSocket")
	@ResponseBody
	public boolean WebSocket(@RequestParam("Message") String message,@RequestParam("Id") int userId,HttpServletRequest request,HttpServletResponse response, Model model) throws IOException {
//		boolean result = service.checkMessageExist(userId);
		socketBean temp = new socketBean(null, 1, userId, message, "2020-02-19 00:00:00");
		boolean result = service.saveMessage(temp);
		System.out.println(result);
//		if(result == true) {
//			
//		}
//		else {
//			
//		}
		return true;
	}
}
