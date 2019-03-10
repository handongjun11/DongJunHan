package com.kh.god.chat.model.vo;

import java.io.Serializable;
import java.sql.Date;


import com.fasterxml.jackson.annotation.JsonFormat;

public class Chat implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int chatNo;
	private int chatRoomNo;
	private String chatContent;
	@JsonFormat(shape=JsonFormat.Shape.STRING,pattern = "yyyy-MM-dd HH:mm:ss")
	private Date sendTime;
	private String sendMember;
	private String readFlag;
	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Chat(int chatNo, int chatRoomNo, String chatContent, Date sendTime, String sendMember, String readFlag) {
		super();
		this.chatNo = chatNo;
		this.chatRoomNo = chatRoomNo;
		this.chatContent = chatContent;
		this.sendTime = sendTime;
		this.sendMember = sendMember;
		this.readFlag = readFlag;
	}
	public int getChatNo() {
		return chatNo;
	}
	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	public String getSendMember() {
		return sendMember;
	}
	public void setSendMember(String sendMember) {
		this.sendMember = sendMember;
	}
	public String getReadFlag() {
		return readFlag;
	}
	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Chat [chatNo=" + chatNo + ", chatRoomNo=" + chatRoomNo + ", chatContent=" + chatContent + ", sendTime="
				+ sendTime + ", sendMember=" + sendMember + ", readFlag=" + readFlag + "]";
	}
	

}
