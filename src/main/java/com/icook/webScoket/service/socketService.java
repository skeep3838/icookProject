package com.icook.webScoket.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icook.helpQuestion.dao.helpDao;
import com.icook.model.socketBean;

@Transactional
@Service
public class socketService implements socketServiceDao {
	socketServiceDao dao;
	@Autowired
	public void setDao(socketServiceDao dao) {
		this.dao = dao;
	}
	@Override
	public boolean saveMessage(socketBean temp) {
		boolean result = dao.saveMessage(temp);
		if(result == true) return true;
		else return false;
	}
	@Override
	public boolean checkMessageExist(int userId) {
		boolean result = dao.checkMessageExist(userId);
		if(result == true) return true;
		else return false;
	}
	
 }
