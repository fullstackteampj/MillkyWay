package beans;

public class boardPagingBean {

	private int totalRecord;
	private int numPerPage;
	private int pagePerBlock;
	private int totalPage;
	private int totalBlock;
	private int nowPage;
	private int nowBlock;
	private int start;
	private int end;
	private int listSize;
	private int pageStart;
	private int pageEnd;
	
	public boardPagingBean(int totalRecord, int numPerPage, int pagePerBlock,
			int totalPage, int totalBlock, int nowPage, int nowBlock,
			int start, int end, int listSize, int pageStart, int pageEnd) {
		
		this.totalRecord = totalRecord;
		this.numPerPage = numPerPage;
		this.pagePerBlock = pagePerBlock;
		this.totalPage = totalPage;
		this.totalBlock = totalBlock;
		this.nowPage = nowPage;
		this.nowBlock = nowBlock;
		this.start = start;
		this.end = end;
		this.listSize = listSize;
		this.pageStart = pageStart;
		this.pageEnd = pageEnd;
	}

	public int getPageStart() {
		return pageStart;
	}

	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public int getPagePerBlock() {
		return pagePerBlock;
	}

	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getNowBlock() {
		return nowBlock;
	}

	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getListSize() {
		return listSize;
	}

	public void setListSize(int listSize) {
		this.listSize = listSize;
	}
}
