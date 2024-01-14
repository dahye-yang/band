package org.edupoll.band.controller;

import org.edupoll.band.model.UpdateUserInfo;
import org.edupoll.band.model.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
public class UserInfoController {

	@Value("${upload.profileImage.dir}")
	String uploadProfileImageDir;
	
	@PostMapping("/my/profile")
	public String updateImgFile(@ModelAttribute UpdateUserInfo updateUserInfo, @SessionAttribute User logonUser, Model model) {
		
	//User user = User.builder().userId(logonUser.getUserId()).
		
		return null;
	}
	
}
