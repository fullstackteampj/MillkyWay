package beans;

public class CancelBean {
	private int cancelid;
	private int userid;
	private int bookid;
	private String status;
	private String cancellation_date ;
	private String cancellation_reason;
	private int totalCount;
	private int price;
	private int quantity;
	
    
	public int getCancelid() {
		return cancelid;
	}
	public void setCancelid(int cancelid) {
		this.cancelid = cancelid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getBookid() {
		return bookid;
	}
	public void setBookid(int bookid) {
		this.bookid = bookid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCancellation_date() {
		return cancellation_date;
	}
	public void setCancellation_date(String cancellation_date) {
		this.cancellation_date = cancellation_date;
	}
	public String getCancellation_reason() {
		return cancellation_reason;
	}
	public void setCancellation_reason(String cancellation_reason) {
		this.cancellation_reason = cancellation_reason;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
    
}//class CancelBean
