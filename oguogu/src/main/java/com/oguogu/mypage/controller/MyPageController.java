package com.oguogu.mypage.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.oguogu.mypage.model.service.MyPageService;

@Controller
public class MyPageController {
	
	@Autowired
	MyPageService myPageService;
	
	@RequestMapping("/mypagePetProfile.do")
	public ModelAndView getPetProfile() {
		ModelAndView mv = new ModelAndView("mypage/mypage_petprofile_list_none");
		return mv;
	}
	
	@RequestMapping("/userInfoUpdateForm.do")
	public ModelAndView getUserInfoUpdateForm() {
		return new ModelAndView("mypage/mypage_myprofile_update");
	}
	
}
