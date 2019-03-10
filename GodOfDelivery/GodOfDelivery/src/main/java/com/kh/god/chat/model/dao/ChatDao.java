package com.kh.god.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.god.chat.model.vo.Chat;
import com.kh.god.chat.model.vo.ChatRoom;
import com.kh.god.seller.model.vo.Seller;

public interface ChatDao {

	List<ChatRoom> selectChatRoomList(String sellerId);

	List<Map<String,String>> selectChatLog(Map<Integer, Integer> roomMap);

	List<Map<String,String>> selectChattingLogs(Map<String, String> map);

	int insertChatLogRead(Chat chat);
	
	int insertChatLogNotRead(Chat chat);

	List<Seller> searchPerson(String searchId);

	ChatRoom searchChatRoom(ChatRoom roomId) ;

	int creatChatRoom(ChatRoom roomId);
	List<Integer> notReadMessageToAdmin(String memberId);
	List<Integer> notReadMessageToSeller(String memberId);

	Seller selectSeller(String addId);

	List<Map<String, String>> getAlertListToAdmin();

	List<Map<String, String>> getAlertListToSeller(String userId);
}
