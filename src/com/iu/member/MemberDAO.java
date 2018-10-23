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
//		for(int i=150;i<250;i++){
//			MemberDTO mDTO = new MemberDTO();
//			mDTO.setId("id"+i);
//			mDTO.setPw("pw"+i);
//			mDTO.setName("name"+i);
//			mDTO.setEmail(i+"s"+i+"g"+i+"@"+"naver.com");
//			mDTO.setKind("S");
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
}
