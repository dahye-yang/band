package org.edupoll.band.dao;

import java.util.List;
import java.util.Map;

import org.edupoll.band.model.Schedule;

public interface ScheduleDao {
	public int saveSchedule(Schedule schedule);

	public List<Schedule> findCurrentMonthSchedule(Map<String, Object> criteria);

	public Schedule findNextSchedule(String scheduleBandRoomId);
}
