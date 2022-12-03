package action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BoardListService;
import vo.ActionForward;
import vo.BoardBean;
import vo.PageInfo;

public class BoardListAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("BoardListAction");
		
		ActionForward forward = null;
		
		
		//----------------페이징 처리--------------------
		//한 페이지당 개수 10개로 제한
		int listLimit = 10;
		//기본 페이지 번호 1
		int pageNum = 1;
		//pageNum이 널이 아니라면 파라미터 값을 정수형으로 변환(getparameter을 하면 String으로 넘어오기 때문이다.)
		if(request.getParameter("pageNum") != null){
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}


		int startRow = (pageNum-1) * listLimit; // 조회 시작 행 번호 계산


		String keyword = request.getParameter("keyword");

		if(keyword == null){
			keyword = "";
		}
		
		//------------ BoardListService 클래스 인스턴스 생성 ------------------
		BoardListService service = new BoardListService();
		
		//getBoardList 메서드 호출하여 목록 조회
		// 파라미터 : 검색어, 시작행번호, 목록갯수
		// 리턴타입 : List<BoardBean>
		
		List<BoardBean> boardList = service.getBoardList(keyword, startRow, listLimit);
		
		System.out.println(boardList);
		
		//페이징 처리에 사용될 게시물 목록 개수 조회
		 
		int listCount = service.getBoardListCount(keyword);
		System.out.println(listCount);
		
		//페이지 목록 개수 계산
		int pageListLimit = 10;
		

		int maxPage = listCount / listLimit + (listCount % listLimit ==0 ? 0 : 1);
		
		System.out.println("전체 페이지 수 : " + maxPage);
		//4. 시작 페이지 번호 계산
		int startPage = (pageNum-1) / pageListLimit * pageListLimit + 1;
		//5. 끝 페이지
		int endPage = startPage + pageListLimit-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		//request 객체에 boardList, pageInfo에 대한 정보를 저장
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageInfo", pageInfo);
		
		
		if(boardList == null) { 
			
		} else { 
			forward = new ActionForward();
			forward.setPath("board/qna_board_list.jsp");
			forward.setRedirect(false);
		}
		
		
		
		
		return forward;
	}
		
	
}
