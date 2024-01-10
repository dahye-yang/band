package org.edupoll.band.controller;

import java.util.HashMap;
import java.util.Map;

import org.edupoll.band.dao.BandMemberDao;
import org.edupoll.band.dao.BandRoomDao;
import org.edupoll.band.model.BandMember;
import org.edupoll.band.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping
@RequiredArgsConstructor
public class BandSignController {

	private final BandRoomDao bandRoomDao;
	private final BandMemberDao bandMemberDao;

	@PostMapping("/band/{bandRoomId}/request")
	public String proceedBandSign(@SessionAttribute User logonUser, @PathVariable String bandRoomId,
			@RequestParam int profileId, Model model) {
		
		Map<String, Object> criteria = new HashMap<>();
		criteria.put("memberBandRoomId", bandRoomId);
		criteria.put("memberUserId", logonUser.getUserId());
		BandMember found = bandMemberDao.findByRoomIdAndUserId(criteria);

		if (found == null) {
			BandMember member = BandMember.builder() //
					.memberBandRoomId(bandRoomId) //
					.memberUserId(logonUser.getUserId()) //
					.memberProfileId(profileId) //
					.memberStatus("request") //
					.build();
			bandMemberDao.saveMember(member);
			model.addAttribute(member);
		} else if (found.getMemberStatus().equals("reject") || found.getMemberStatus().equals("leave")) {
			criteria.clear();
			criteria.put("memberStatus", "request");
			criteria.put("memberId", found.getMemberId());
			bandMemberDao.updateStatus(criteria);
			
			int memberId = found.getMemberId();
			BandMember member = bandMemberDao.findByMemberId(memberId);
			model.addAttribute(member);
		} else {
			int memberId = found.getMemberId();
			BandMember member = bandMemberDao.findByMemberId(memberId);
			model.addAttribute(member);
		}
		
		return "redirect:/band/" + bandRoomId; // 가입신청한 밴드룸으로
	}
}
