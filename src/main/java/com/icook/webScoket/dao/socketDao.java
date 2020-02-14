package com.icook.webScoket.dao;

import com.icook.model.socketBean;

public interface socketDao {
	public boolean saveWebSocketMessage(socketBean temp);
	public boolean checkWebSocketMessage(int userId);
	
}
