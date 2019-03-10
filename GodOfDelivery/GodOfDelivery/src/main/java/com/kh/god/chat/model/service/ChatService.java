package com.kh.god.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.god.chat.model.vo.Chat;
import com.kh.god.chat.model.vo.ChatRoom;
import com.kh.god.seller.model.vo.Seller;

public interface ChatService {
	List<Map<String,String>> selectChatRoomList(String sellerId);

	List<Map<String,String>> selectChattingLogs(Map<String, String> map);

	int insertChatLog(Chat chat, int currentFocusChatRoomNo);

	List<Seller> searchPerson(String searchId);

	List<Map<String,String>> addPerson(ChatRoom roomId) ;
	Map<String,Integer> notReadMessage(String sellerId);

	List<Map<String, String>> getAlertList(String userId);
}
