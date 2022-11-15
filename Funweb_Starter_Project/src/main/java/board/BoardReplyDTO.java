package board;

import java.sql.Date;
import java.sql.Timestamp;

public class BoardReplyDTO {
//	CREATE TABLE board_reply (
//			idx INT primary key AUTO_INCREMENT,
//			id VARCHAR(16) NOT NULL,
//			content VARCHAR(100) NOT NULL,
//			date DATETIME NOT NULL,
//			ref_idx INT NOT NULL,
//			board_type VARCHAR(30) NOT NULL); => 여러 개의 게시판의 댓글들을 구분하는 데 사용 (notice, file)
	
	private int idx;
	private String id;
	private String content;
	private Timestamp date;
	private int ref_idx;
	private String board_type;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getRef_idx() {
		return ref_idx;
	}
	public void setRef_idx(int ref_idx) {
		this.ref_idx = ref_idx;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	@Override
	public String toString() {
		return "BoardReplyDTO [idx=" + idx + ", id=" + id + ", content=" + content + ", date=" + date + ", ref_idx="
				+ ref_idx + ", board_type=" + board_type + "]";
	}
	
	
	
	
	
}
