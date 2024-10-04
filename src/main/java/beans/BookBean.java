package beans;

public class BookBean {
	
	private int bookid;
	private String author;
	private String category;
	private String genre;
	private String title;
	private String review;
	private int score;
	private String contents;
	private String authorIntro;
	private String contentsTables;
	private String miniIntro;
	private byte[] photo;
	private String encodedPhoto; // Base64로 인코딩된 이미지
	private String publish_date;
	private String isbn;
	private int stock_Quantity;
	private int price;
	private int pages;
	
	
	public int getPages() {
		return pages;
	}
	public void setPages(int pages) {
		this.pages = pages;
	}
	public int getBookid() {
		return bookid;
	}
	public void setBookid(int bookid) {
		this.bookid = bookid;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getAuthorIntro() {
		return authorIntro;
	}
	public void setAuthorIntro(String authorIntro) {
		this.authorIntro = authorIntro;
	}
	public String getContentsTables() {
		return contentsTables;
	}
	public void setContentsTables(String contentsTables) {
		this.contentsTables = contentsTables;
	}
	public String getMiniIntro() {
		return miniIntro;
	}
	public void setMiniIntro(String miniIntro) {
		this.miniIntro = miniIntro;
	}
	public byte[] getPhoto() {
		return photo;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	public String getPublish_date() {
		return publish_date;
	}
	public void setPublish_date(String publish_date) {
		this.publish_date = publish_date;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public int getStock_Quantity() {
		return stock_Quantity;
	}
	public void setStock_Quantity(int stock_Quantity) {
		this.stock_Quantity = stock_Quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getEncodedPhoto() {
		return encodedPhoto;
	}
	public void setEncodedPhoto(String encodedPhoto) {
		this.encodedPhoto = encodedPhoto;
	}

}
