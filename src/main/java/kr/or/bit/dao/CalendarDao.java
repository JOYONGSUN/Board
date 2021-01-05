package kr.or.bit.dao;

import java.util.List;

import kr.or.bit.dto.calendar;
import kr.or.bit.dto.user;

public interface CalendarDao {

	
	public void insertCalendar(String start, String end, String title, String content, Boolean allDay, String color);
	 

	public List<calendar> getCalendarList();
	
	public void editCalendar(String start, String end, String id);
	
	public void deleteCalendar(String id);
	
	public void updateCalendar(String start, String end, String title, String content, boolean allDay, String color,String id);
}
