package com.icook.helpQuestion.controller;

import java.io.IOException;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.icook.model.MemberBean;
import com.icook.model.orderBean;
import com.icook.model.orderDetail;
import com.icook.order.service.SearchOrdersServiceDao;

@Controller
public class helpQAController {

	@Autowired
	SearchOrdersServiceDao service;

	@Autowired
	public void setService(SearchOrdersServiceDao service) {
		this.service = service;
	}

	@RequestMapping(value = "/helpQuestion", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String helpQuestion(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "helpQuestion/mail";
	}
	
	@RequestMapping(value = "/sendQuestion", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String sendQuestion(@RequestParam("Email")String Email,@RequestParam("Title")String Title,@RequestParam("Message")String Message,HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		MemberBean member = (MemberBean)session.getAttribute("LoginOK");
		System.out.println(Email);
		return "index";
	}
}
