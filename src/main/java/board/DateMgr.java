package board;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateMgr {
	
	// 현재날짜 반환
	public String getToday() {
		Date now = new Date();
		SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String outputDate = output.format(now);
		
		return outputDate;
	}

	// 날짜데이터 가공
	public String getFormatDate(String inputDate, String form) {
		SimpleDateFormat output = null;
		String outputDate = null;
		
		// 받은 날짜데이터를 Date 객체로 변환
		SimpleDateFormat input = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			date = input.parse(inputDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		// 오늘이면
		if(form.equals("today")) {
			// 시:분 출력
			output = new SimpleDateFormat("HH:mm");
			outputDate = output.format(date);
		}
		
		// 올해이면서 오늘이전이면
		if(form.equals("yesterday")) {
			// 월.일 출력
			output = new SimpleDateFormat("MM.dd");
			outputDate = output.format(date);
		}

		// 올해이전이면
		if(form.equals("lastYear")) {
			// 년.월.일 출력
			output = new SimpleDateFormat("yyyy.MM.dd");
			outputDate = output.format(date);
		}

		return outputDate;
	}
	
	// 날짜데이터를 추출해 숫자로 변환
	public int getIntDate(String inputDate, String want) {
		SimpleDateFormat output = null;
		int outputDate = 0;
		
		// 받은 날짜데이터를 Date 객체로 변환
		SimpleDateFormat input = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			date = input.parse(inputDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		// 년도 추출
		if(want.equals("year")) {
			output = new SimpleDateFormat("yyyy");
		}
		
		// 월일 추출
		if(want.equals("date")) {
			output = new SimpleDateFormat("MMdd");
		}
		
		outputDate = Integer.parseInt(output.format(date));
		
		return outputDate;
	}
}
