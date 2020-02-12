package com.icook.webScoket.controller;


import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class SocketController {
//	@Autowired
//	sendmailService service;
//
//	@Autowired
//	public void setService(sendmailService service) {
//		this.service = service;
//	}

	
	@RequestMapping(value = "/WebSocket", method = RequestMethod.GET)
	public String WebSocket(@RequestParam(value = "page", required = false) String page, HttpServletRequest request,
			HttpServletResponse response, Model model) throws IOException {
		return "webSocket/webSocket";
	}
}
