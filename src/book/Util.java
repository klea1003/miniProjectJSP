package book;

import java.util.ArrayList;

public class Util {
	ArrayList<String> CategoryNames = new ArrayList<>();
	
	public Util() {
		CategoryNames.add("시");
		CategoryNames.add("에세이");
		CategoryNames.add("소설");
		CategoryNames.add("사회,과학");
		CategoryNames.add("예술");
		CategoryNames.add("매거진");
	}
	
	
	public String getCategoryName(int num) {
		return CategoryNames.get(num);		
	}
	
	public int getCategoryLength() {
		return CategoryNames.size();
	}
}
