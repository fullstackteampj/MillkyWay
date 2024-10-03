package beans;

public class BoardFilterBean {
	private String keyWord;
	private String keyField;
	private String category;
	private String tab;
	
	public BoardFilterBean(String KeyWord, String keyField, String category, String tab) {
		this.keyWord = KeyWord;
		this.keyField = keyField;
		this.category = category;
		this.tab = tab;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public String getKeyField() {
		return keyField;
	}

	public String getCategory() {
		return category;
	}

	public String getTab() {
		return tab;
	}
}
