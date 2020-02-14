package com.icook.webScoket.service;

import com.icook.model.socketBean;

public interface socketServiceDao {
	public boolean saveMessage(socketBean temp);
	public boolean checkMessageExist(int userId);
}
