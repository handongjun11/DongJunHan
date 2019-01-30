package com.kh.member.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;

import com.kh.member.model.dao.MemberDao;
import com.kh.member.model.vo.Member;

public class MemberService {
	//로그인 관련 상수
	public static final int LOGIN_OK = 1;
	public static final int WRONG_PASSWORD = 0;
	public static final int ID_NOT_EXIST = -1;
	
	public static final String LOGIN = "1";
	public static final String LOGOUT = "0";
	
	public int loginCheck(Member m) {
		int result = -1;
		Connection conn = getConnection();
		
		result = new MemberDao().loginCheck(conn, m);
		
		close(conn);
		
		return result;
	}

	public Member selectOne(String memberId) {
		Connection conn = getConnection();
		Member m = new MemberDao().selectOne(conn, memberId);
		close(conn);
		return m;
	}

	public int insertMemberLog(Member member, String ip, String status) {
		Connection conn = getConnection();
		int result = new MemberDao().insertMemberLog(conn, member, ip, status);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}
}
