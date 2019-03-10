package com.kh.god.chat.model.vo;

import java.io.Serializable;

public class ChatRoom implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int chatRoomNo;
	private String sellerId;
	private String sellerId2;
	public ChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ChatRoom(int chatRoomNo, String sellerId, String sellerId2) {
		super();
		this.chatRoomNo = chatRoomNo;
		this.sellerId = sellerId;
		this.sellerId2 = sellerId2;
	}
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getSellerId2() {
		return sellerId2;
	}
	public void setSellerId2(String sellerId2) {
		this.sellerId2 = sellerId2;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "ChatRoom [chatRoomNo=" + chatRoomNo + ", sellerId=" + sellerId + ", sellerId2=" + sellerId2 + "]";
	}
	

}
