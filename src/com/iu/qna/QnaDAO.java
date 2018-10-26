package com.iu.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.iu.util.DBConnector;

public class QnaDAO {
	
//	public static void main(String[] args) {
//		QnaDAO qnaDAO = new QnaDAO();
//		for(int a=101;a<150;a++) {
//			QnaDTO qnaDTO = new QnaDTO();
//			qnaDTO.setTitle("Title"+a);
//			qnaDTO.setContents("Contents"+a+" ssadfsafsdafsadfsdfadfsdfsd");
//			qnaDTO.setWriter("writer"+a);
//			try {
//				qnaDAO.insert(qnaDTO);
//				Thread.sleep(200);
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
		
//		List<QnaDTO> qnaList=null;
//		try {
//			qnaList = qnaDAO.selectList();
//			for(int a=0;a<qnaList.size();a++) {
//				System.out.println(qnaList.get(a).getNum());
//			}
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	//selectList
	public List<QnaDTO> selectList(int startRow,int lastRow,String kind, String search) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql ="select * from "
				+ "(select rownum R, Q.* from "
				+ "(select * from qna where " +kind+ " like ? order by ref desc, step asc) Q) "
				+ "where R between ? and ?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, "%"+search+"%");
		st.setInt(2, startRow);
		st.setInt(3, lastRow);
		ResultSet rs = st.executeQuery();
		List<QnaDTO> qnaList = new ArrayList<>(); 
		while(rs.next()) {
			QnaDTO qnaDTO = new QnaDTO();
			qnaDTO.setNum(rs.getInt("num"));
			qnaDTO.setTitle(rs.getString("title"));
			qnaDTO.setWriter(rs.getString("writer"));
			qnaDTO.setReg_date(rs.getDate("reg_date"));
			qnaDTO.setHit(rs.getInt("hit"));
			qnaDTO.setDepth(rs.getInt("depth"));
			qnaList.add(qnaDTO);
		}
		
		DBConnector.disConnect(rs, st, con);
		return qnaList;
	}
	
	public QnaDTO selectOne(int num) throws Exception {
		QnaDTO qnaDTO = null;
		Connection con = DBConnector.getConnect();
		String sql = "select * from qna where num = ?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, num);
		ResultSet rs = st.executeQuery();
		if(rs.next()) {
			qnaDTO = new QnaDTO();
			qnaDTO.setNum(rs.getInt("num"));
			qnaDTO.setTitle(rs.getString("title"));
			qnaDTO.setContents(rs.getString("contents"));
			qnaDTO.setWriter(rs.getString("writer"));
			qnaDTO.setReg_date(rs.getDate("reg_date"));
			qnaDTO.setHit(rs.getInt("hit"));
			qnaDTO.setRef(rs.getInt("ref"));
			qnaDTO.setStep(rs.getInt("step"));
			qnaDTO.setDepth(rs.getInt("depth"));
		}
		
		DBConnector.disConnect(rs, st, con);
		return qnaDTO;
	}
	
	public int getCount(String kind, String search) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "select count(num) from qna";
		PreparedStatement st = con.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		rs.next();
		int result = rs.getInt(1);
		DBConnector.disConnect(rs, st, con);
		
		return result;
	}
	
	public int insert(QnaDTO qnaDTO) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "insert into qna values(qna_seq.nextval,?,?,?,sysdate,0,qna_seq.currval,0,0)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, qnaDTO.getTitle());
		st.setString(2, qnaDTO.getContents());
		st.setString(3, qnaDTO.getWriter());
		int result = st.executeUpdate();
		
		DBConnector.disConnect(st, con);
		return result;
	}
	
	//reply 전에 step 정리
	public int replyUpdate(int ref, int step) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql = "update qna set step=step+1 where ref= ? and step > ?";
		//부모 ref랑 같고 부모 step 보다 크면 step 1씩 증가
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, ref);
		st.setInt(2, step);
		int result = st.executeUpdate();
		
		DBConnector.disConnect(st, con);
		return result;
	}
	
	//reply insert
	public int reply(QnaDTO qnaDTO) throws Exception{
		Connection con = DBConnector.getConnect();
		String sql ="insert into qna values(qna_seq.nextval,?,?,?,sysdate,0,?,?,?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, qnaDTO.getTitle());
		st.setString(2, qnaDTO.getContents());
		st.setString(3, qnaDTO.getWriter());
		//부모글의 ref
		st.setInt(4, qnaDTO.getRef());
		//부모 step +1
		st.setInt(5, qnaDTO.getStep()+1);
		//부모 depth +1
		st.setInt(6, qnaDTO.getDepth()+1);
		
		int result = st.executeUpdate();
		DBConnector.disConnect(st, con);
		return result;
	}
	
}
