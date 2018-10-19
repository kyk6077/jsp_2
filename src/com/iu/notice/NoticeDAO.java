package com.iu.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.iu.util.DBConnector;

public class NoticeDAO {
	
//	public static void main(String[] args) {
//		
//		NoticeDTO nt = new NoticeDTO();
//		nt.setTitle("Title3");
//		nt.setContents("Contents3");
//		nt.setWriter("Writer3");
//		try {
//			new NoticeDAO().insert(nt);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//	}
	
	//selectOne
	public NoticeDTO selectOne(int num) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "select * from notice where num=? order by reg_date asc";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, num);
		
		ResultSet rs = st.executeQuery();
//		rs.get NoticeDTO 사용
		NoticeDTO nt = new NoticeDTO();
		if(rs.next()) {
			nt.setNum(rs.getInt(1));
			nt.setTitle(rs.getString(2));
			nt.setContents(rs.getString(3));
			nt.setWriter(rs.getString(4));
			nt.setReg_date(rs.getDate(5));
			nt.setHit(rs.getInt(6));
		}
		DBConnector.disConnect(rs, st, con);		
		return nt;
	}
	
	
	//selectList
	public ArrayList<NoticeDTO> selectList() throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "select * from notice";
		PreparedStatement st = con.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
//		rs.get NoticeDTO LIST 사용
		ArrayList<NoticeDTO> ntList = new ArrayList<>();
		while(rs.next()) {
			NoticeDTO nt = new NoticeDTO();
			nt.setNum(rs.getInt(1));
			nt.setTitle(rs.getString(2));
			nt.setContents(rs.getString(3));
			nt.setWriter(rs.getString(4));
			nt.setReg_date(rs.getDate(5));
			nt.setHit(rs.getInt(6));
			ntList.add(nt);
		}
		
		DBConnector.disConnect(rs, st, con);
		return ntList;
	}
	
	
	//insert
	public int insert(NoticeDTO nt) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "Insert into notice values(notice_seq.nextval,?,?,?,sysdate,0)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, nt.getTitle());
		st.setString(2, nt.getContents());
		st.setString(3, nt.getWriter());
		int result = st.executeUpdate();
		DBConnector.disConnect(st, con);
		return result;
	}
	
	
	//delete
	public int delete(int num) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "delete notice where num=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, num);
		
		int result = st.executeUpdate();
		DBConnector.disConnect(st, con);
		return result;
	}
	
	
	//update
	public int update(NoticeDTO ntDTO) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "update notice set title=?,contents=?,reg_date=sysdate where num=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1,ntDTO.getTitle());
		st.setString(2,ntDTO.getContents());
		st.setInt(3,ntDTO.getNum());
		
		int result = st.executeUpdate();
		DBConnector.disConnect(st, con);
		return result;
	}
	
}
