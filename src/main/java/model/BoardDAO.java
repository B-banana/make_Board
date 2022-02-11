package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public void getCon() {

		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/xe");

			con = ds.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ==============================================
	// #1 전체 게시글의 갯구를 리턴하는 메소드

	public int getAllCount() {
		getCon();

		int count = 0;

		try {
			// 쿼리
			String sql = "SELECT count(*) FROM board";
			pstmt = con.prepareStatement(sql);
			// 쿼리 결과 받기
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	// ================================================
	// #2 최신글 10개 기준으로 게시글을 리턴하는 메소드

	public Vector<BoardDTO> getAllBoard(int startRow, int endRow) {
		getCon();

		Vector<BoardDTO> v = new Vector<BoardDTO>();

		try {
			// Rownum : 오라클에만 존재하는 컬럼으로 30%이내의 값을 추출함
			String sql = "SELECT * FROM (SELECT A.* ,Rownum Rnum FROM (SELECT * FROM board ORDER BY ref desc, re_step asc) A) WHERE Rnum >= ? and Rnum <= ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO bean = new BoardDTO();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));

				// 저장된 객체를 벡터 배열에 담기
				v.add(bean);
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return v;
	}

	// ============================================================
	public void insertBoard(BoardDTO bean) {
		getCon();

		int ref = 0;

		int re_step = 1;
		int re_level = 1;

		try {
			String resql = "select max(ref) from board";
			pstmt = con.prepareStatement(resql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ref = rs.getInt(1) + 1;
			}

			String sql = "insert into board values(board_seq.nextval, ?, ?, ?, ?, sysdate, ?, ?, ?, 0, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());

			pstmt.executeUpdate();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// ---------------------------------------------------------------------

	public BoardDTO getOneBoard(int num) {

		getCon();

		BoardDTO bean = null;

		try {
			// 하나의 게시글을 읽었다는 조회수 증가
			String countsql = "update board set readcount=readcount+1 where num = ?";
			pstmt = con.prepareStatement(countsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			// 하나의 게시글 리턴(상세정보)
			String sql = "select * from board where num = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean = new BoardDTO();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;

	}

	// ---------------------------------------------------------------------

	public void reInsertBoard(BoardDTO bean) {
		getCon();

		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();

		try {
			String levelsql = "update board set re_level = re_level+1 where ref=? and re_level > ?";
			pstmt = con.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);

			pstmt.executeUpdate();

			String sql = "insert into board values(board_seq.nextval, ?, ?, ?, ?, sysdate, ?, ?, ?, 0, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step + 1);
			pstmt.setInt(7, re_level + 1);
			pstmt.setString(8, bean.getContent());

			pstmt.executeUpdate();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// ---------------------------------------------------------------------
	// 조회수를 증가하지 않는 업데이트
	public BoardDTO getOneUpdateBoard(int num) {

		getCon();

		BoardDTO bean = null;

		try {

			// 하나의 게시글 리턴(상세정보)
			String sql = "select * from board where num = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean = new BoardDTO();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return bean;

	}

	// ---------------------------------------------------------------------
	// 수정
	public void updateBoard(int num, String subject, String content) {
		getCon();// 커넥션 연결
		try {
			String sql = "update board set subject=? , content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			// 쿼리 실행
			pstmt.executeUpdate();

			con.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ---------------------------------------------------------------------
	// 삭제
	public void deleteBoard(int num) {
		getCon();// 커넥션 연결

		try {
			// 쿼리준비
			String sql = "delete from board where num=?";
			// 쿼리실행할객체 선언
			pstmt = con.prepareStatement(sql);
			// 쿼리 실행전 ? 값대입
			pstmt.setInt(1, num);
			// 쿼리실행
			pstmt.executeUpdate();
			// 자원반납
			con.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
