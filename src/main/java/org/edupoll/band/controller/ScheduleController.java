package org.edupoll.band.controller;

import java.sql.Date;
import java.text.ParseException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.edupoll.band.dao.BandMemberDao;
import org.edupoll.band.dao.BandRoomDao;
import org.edupoll.band.dao.ProfileDao;
import org.edupoll.band.dao.ScheduleDao;
import org.edupoll.band.dao.UserDao;
import org.edupoll.band.model.BandMember;
import org.edupoll.band.model.BandRoom;
import org.edupoll.band.model.Profile;
import org.edupoll.band.model.Schedule;
import org.edupoll.band.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/band")
@RequiredArgsConstructor
public class ScheduleController {

	private final BandRoomDao bandRoomDao;
	private final BandMemberDao bandMemberDao;
	private final ScheduleDao scheduleDao;
	private final ProfileDao profileDao;
	private final UserDao userDao;

	@ModelAttribute("profileImageUrl")
	public String findProfileImageUrl(@SessionAttribute User logonUser) {
		User user = userDao.findUserById(logonUser.getUserId());
		List<Profile> profiles = profileDao.findProfileById(user.getUserId());
		return profiles.get(0).getProfileImageUrl();
	}

	// 일정 페이지
	@GetMapping("/{bandRoomId}/calendar")
	public String showCalender(@RequestParam(required = false) String currentDate, @PathVariable String bandRoomId,
			@SessionAttribute User logonUser, Model model) throws ParseException {

		if (currentDate == null) {
			Date today = new Date(System.currentTimeMillis());
			LocalDate todayLocalDate = today.toLocalDate();
			currentDate = todayLocalDate.toString().substring(0, 7);
		}
		
		Schedule nextSchedule = scheduleDao.findNextSchedule(bandRoomId);
		model.addAttribute("nextSchedule", nextSchedule);

		Date parsedMonth = Date.valueOf(currentDate + "-01");
		LocalDate currentMonth = parsedMonth.toLocalDate();
		model.addAttribute("currentDate", currentDate);

		LocalDate nextMonth = currentMonth.plusMonths(1);
		model.addAttribute("nextDate", nextMonth.toString().substring(0, 7));

		LocalDate prevMonth = currentMonth.minusMonths(1);
		model.addAttribute("prevDate", prevMonth.toString().substring(0, 7));

		Map<String, Object> criteria = new HashMap<>();
		criteria.put("scheduleBandRoomId", bandRoomId);
		criteria.put("currentDate", currentDate);
		List<Schedule> schedules = scheduleDao.findCurrentMonthSchedule(criteria);
		model.addAttribute("schedules", schedules);

		criteria.clear();
		criteria.put("memberBandRoomId", bandRoomId);
		criteria.put("memberUserId", logonUser.getUserId());
		BandMember member = bandMemberDao.findByRoomIdAndUserId(criteria);
		model.addAttribute("member", member);

		int memberCnt = bandMemberDao.countMembers(bandRoomId);
		model.addAttribute("memberCnt", memberCnt);

		BandRoom bandRoom = bandRoomDao.findByBandRoomId(bandRoomId);
		model.addAttribute("bandRoom", bandRoom);

		return "band/calendar";
	}

	// 일정 추가
	@PostMapping("/schedule/add")
	public String proceedScheduleAdd(@ModelAttribute Schedule schedule) {
		scheduleDao.saveSchedule(schedule);
		String currentDate = Date.valueOf(schedule.getScheduleDate().toLocalDate()).toString().substring(0, 7);
		return "redirect:/band/" + schedule.getScheduleBandRoomId() + "/calendar?currentDate=" + currentDate;
	}
}
