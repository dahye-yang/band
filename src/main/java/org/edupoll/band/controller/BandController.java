package org.edupoll.band.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.edupoll.band.dao.BandMemberDao;
import org.edupoll.band.dao.BandRoomDao;
import org.edupoll.band.dao.ProfileDao;
import org.edupoll.band.model.BandMember;
import org.edupoll.band.model.BandRoom;
import org.edupoll.band.model.Profile;
import org.edupoll.band.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping
@RequiredArgsConstructor
public class BandController {

	private final BandRoomDao bandRoomDao;
	private final BandMemberDao bandMemberDao;
	private final ProfileDao profileDao;

	@GetMapping("/band/{bandRoomId}")
	public String showBandRoom(@SessionAttribute(required = false) User logonUser, @PathVariable String bandRoomId,
			Model model) {

		if (logonUser != null) {
			Map<String, Object> criteria = new HashMap<>();
			criteria.put("memberBandRoomId", bandRoomId);
			criteria.put("memberUserId", logonUser.getUserId());
			BandMember member = bandMemberDao.findByRoomIdAndUserId(criteria);
			model.addAttribute("member", member);

			// 여기서 logonUser의 모든 프로필 정보를 담은 List<Profile> profiles 보내주기
			List<Profile> profiles = profileDao.findProfileById(logonUser.getUserId());
			model.addAttribute("profiles", profiles);

			int memberCnt = bandMemberDao.countMembers(bandRoomId);
			model.addAttribute("memberCnt", memberCnt);

			BandRoom bandRoom = bandRoomDao.findByBandRoomId(bandRoomId);
			model.addAttribute("bandRoom", bandRoom);
		}

		return "band/home";
	}
}
