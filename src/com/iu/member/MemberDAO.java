package com.iu.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.iu.util.DBConnector;

public class MemberDAO {

//	public static void main(String[] args) {
//		MemberDAO mDAO = new MemberDAO();
//		Random r = new Random();
//		for(int i=1;i<40;i++){
//			MemberDTO mDTO = new MemberDTO();
//			mDTO.setId("tid"+i);
//			mDTO.setPw("tpw"+i);
//			mDTO.setName("tname"+i);
//			mDTO.setEmail(i+"s"+i+"g"+i+"@"+"naver.com");
//			mDTO.setKind("T");
//			mDTO.setClassmate("cm"+(r.nextInt(3)+1)+(r.nextInt(5)+1));
//			try {
//				System.out.println(mDTO.getClassmate());
//				mDAO.insert(mDTO);
//				Thread.sleep(100);
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		try {
//			List<MemberDTO> mList = mDAO.memberList(1, 10);
//			for(int i=0;i<mList.size();i++) {
//				System.out.println(mList.get(i).getName());
//				System.out.println(mList.get(i).getId());
//				System.out.println(mList.get(i).getKind());
//			}
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	
	
	public int getCount(String kind, String search) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "select count(id) from member "
				+ "where "+kind+" like ?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, "%"+search+"%");
		ResultSet rs = st.executeQuery();
		rs.next();
		int result = rs.getInt(1);
		DBConnector.disConnect(rs, st, con);
		return result;
	}
	
	public int insert(MemberDTO mDTO) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql="insert into member values(?,?,?,?,?,?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, mDTO.getId());
		st.setString(2, mDTO.getPw());
		st.setString(3, mDTO.getName());
		st.setString(4, mDTO.getEmail());
		st.setString(5, mDTO.getKind());
		st.setString(6, mDTO.getClassmate());
		int result = st.executeUpdate();
		
		DBConnector.disConnect(st, con);
		return result;
	}
	
	public MemberDTO selectOne(MemberDTO memberDTO) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "SELECT * FROM member where id=? and pw=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, memberDTO.getId());
		st.setString(2, memberDTO.getPw());
		ResultSet rs = st.executeQuery();
		MemberDTO mDto = null;
		if(rs.next()) {
			mDto = new MemberDTO();
			mDto.setId(rs.getString("id"));
			mDto.setName(rs.getString("name"));
			mDto.setEmail(rs.getString("email"));
			mDto.setKind(rs.getString("kind"));
			mDto.setClassmate(rs.getString("classmate"));
		}
		
		return mDto;
	}
	
	public List<MemberDTO> memberList(int startRow, int lastRow, String kind, String search) throws Exception{
		Connection con = DBConnector.getConnect();
		List<MemberDTO> mList = new ArrayList<>();
		String sql ="select * from "
				+ "(select rownum R, M.* from "
				+ "(select * from member " 
				+ "WHERE "+kind+" like ? "
				+ "order by classmate asc) M) "
				+ "where R between ? and ?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, "%"+search+"%");
		st.setInt(2, startRow);
		st.setInt(3, lastRow);
		ResultSet rs = st.executeQuery();
		MemberDTO mDTO = null;
		while(rs.next()) {
			mDTO = new MemberDTO();
			mDTO.setId(rs.getString("id"));
			mDTO.setName(rs.getString("name"));
			mDTO.setKind(rs.getString("kind"));
			mList.add(mDTO);
		}
		DBConnector.disConnect(rs, st, con);
		return mList;
	}
	
	
	public int update(MemberDTO mDTO) throws Exception {
		Connection con = DBConnector.getConnect();
		String sql = "update member set pw=?,name=?,email=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		System.out.println(mDTO.getPw());
		System.out.println(mDTO.getName());
		System.out.println(mDTO.getEmail());
		System.out.println(mDTO.getId());
		st.setString(1, mDTO.getPw());
		st.setString(2, mDTO.getName());
		st.setString(3, mDTO.getEmail());
		st.setString(4, mDTO.getId());
		int result = st.executeUpdate();
		
		DBConnector.disConnect(st, con);
		return result;
	}
	public int delete(String id) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "delete member where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, id);
		int result = st.executeUpdate();
		
		DBConnector.disConnect(st, con);
		return result;
	}
}
