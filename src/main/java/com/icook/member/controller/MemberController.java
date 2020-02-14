package com.icook.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.icook.member.server.MemberService;
import com.icook.member.validator.MemberValidator;
import com.icook.model.CustomerInfo;
import com.icook.model.MemberBean;
import com.icook.model.ProductOrder;
import com.icook.register.service.RegisterService;

@Controller
public class MemberController {
	String noImage = "/images/NoImage.png";
	@Autowired
	MemberService service;

	@Autowired
	RegisterService service2;// 呼叫RegisterService

	@Autowired
	public void setService(MemberService service) {
		this.service = service;
	}

	@Autowired
	public void setService2(RegisterService service) {
		this.service2 = service;
	}

	ServletContext context;

	@Autowired
	public void setContext(ServletContext context) {
		this.context = context;
	}

	@RequestMapping("/signUp/memRegistrationSuccess2")
	public String RegistrationPage(Model model) {
		return "signUp/memRegistrationSuccess2";
	}

	@RequestMapping("/SignUp/memUpdate")
	public String memUpdatePage(Model model) {
		return "redirect:/signUp/memUpdate";
	}
//	@RequestMapping("redirect:/signUp/memRegistrationSuccess2")
//	public String bacHRegistrationPage(Model model) {
//		return "redirect:/signUp/memRegistrationSuccess2";
//	}

	// 丟空白表單
	// 請求映射 ( 值 = "連結名稱(首頁超連結)", 方法 = 請求方法 . GET )
	@RequestMapping(value = "/SignUp/memberSignUp", method = RequestMethod.GET)
	public String getAddNewMemberForm(Model model) {
		MemberBean mb = new MemberBean();
		// model.添加屬性("MemberBean", mb)
		model.addAttribute("MemberBean", mb);
		// 回傳 "增加產品表單"
		return "signUp/memberSignUp2";
	}

	// 註冊成功頁面
	// 請求映射 ( 值 = "連結名稱" , 方法 = 請求方法 .POST )
	@RequestMapping(value = "/SignUp/memberSignUp", method = RequestMethod.POST) //
	public String RegistrationSuccess(@ModelAttribute("MemberBean") MemberBean mb, BindingResult result,
			HttpServletRequest request, @RequestParam("userimage") MultipartFile userimage) {

		HttpSession session = request.getSession();
		MemberValidator validator = new MemberValidator();
		validator.validate(mb, result);
		if (result.hasErrors()) {
//          下列敘述可以理解Spring MVC如何處理錯誤			
//			List<ObjectError> list = result.getAllErrors();
//			for (ObjectError error : list) {
//				System.out.println("有錯誤：" + error);
//			}
			return "signUp/memberSignUp2";
		}

		Blob imageBlob = null;

		if (userimage != null) {
			byte[] buf;

			try {
				buf = userimage.getBytes();
				Blob blob = new SerialBlob(buf);
				imageBlob = blob;
//				courseImage =  blob;
////				for (MultipartFile image : courseImage) {
////					System.out.println("Part name=" + image.getName());
////					++count;
//				inStream = courseImage.getInputStream();
//				fileName = courseName + ".jpg";
//				outStream = new FileOutputStream(imgAddress + fileName);
//
//				while ((data = inStream.read(buf)) != -1) {
//					outStream.write(buf, 0, data);
//				}
//				inStream.close();
//				outStream.close();
//				allImg += imgAddress + fileName;
//
////				}
			} catch (IOException | SQLException e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常:" + e.getMessage());
			}
		}
		mb.setUserimg(imageBlob);

		try {
			// 未驗證的狀態
			mb.setCheckstatus("N");
			session.setAttribute("verificationLetter_" + mb.getUserId(), mb.getUserId());

			service.save(mb);
			MemberBean temp = service.searchMemberBean(mb.getAccount());
			service.sendOrderConfirmation(getDummyOrder(temp, "registered"));

		} catch (org.hibernate.exception.ConstraintViolationException e) {
			result.rejectValue("account", "", "帳號已存在，請重新輸入");
			return "signUp/memberSignUp2";
		}

		return "signUp/memRegistrationSuccess2";

	}

//	取得照片
	@GetMapping(value = "/getPicMem/{userId}")
	public ResponseEntity<byte[]> getPicture(HttpServletResponse response, @PathVariable Integer userId) {
		String filePath = "/WEB-INF/views/images/NoImage.png";
		byte[] media = null;
		HttpHeaders headers = new HttpHeaders();
//		String filename = "";
		int len = 0;
		MemberBean bean = service.getuserById(userId);
		if (bean != null) {
			Blob blob = bean.getUserimg();
//			filename = bean.getFileName();
			if (blob != null) {
				try {
					len = (int) blob.length();
					media = blob.getBytes(1, len);
				} catch (SQLException e) {
					throw new RuntimeException("Controller的getPicture()發生SQLException:" + e.getMessage());
				}
			} else {
				media = toByteArray(filePath);
//				filename = filePath;
			}
		}
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());
//		String mimeType = context.getMimeType(filePath);
		MediaType mediaType = MediaType.IMAGE_JPEG;
//		System.out.println("mediaType= " + mediaType);
		headers.setContentType(mediaType);
		ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(media, headers, HttpStatus.OK);
		return responseEntity;
	}

	// 取得很多張照片
	private byte[] toByteArray(String filePath) {
		byte[] b = null;
		String realPath = context.getRealPath(filePath);
		File file = new File(realPath);
		long size = file.length();
		b = new byte[(int) size];
		InputStream fis = context.getResourceAsStream(filePath);
		try {
			fis.read(b);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return b;
	}

//		@GetMapping("/SignUp/memUpdate")
//		public String updatememForm(Model model, @RequestParam("id") Integer id) {
//			MemberBean memberBean = service.getuserById(id);
//			model.addAttribute("memberBean", memberBean);
//			return "signUp/memUpdate";
//		}

	// 會員資料頁面
	// 請求映射 ( 值 = "連結名稱(首頁超連結)", 方法 = 請求方法 . GET )
	@RequestMapping(value = "/SignUp/memUpdate", method = RequestMethod.GET)
	public String getMember(Model model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberBean mb = new MemberBean();
		MemberBean mem = (MemberBean) session.getAttribute("LoginOK");
		mb = service2.checkPassword(mem.getAccount(), mem.getPassword());
		// model.添加屬性("MemberBean", mb)
		model.addAttribute("MemberBean", mb);
		session.setAttribute("LoginOK", mb);
		// 回傳 "會員資料頁面"
		return "signUp/memUpdate";
	}

	// 會員資料修改頁面
	// 請求映射 ( 值 = "連結名稱(首頁超連結)", 方法 = 請求方法 . GET )
	@RequestMapping(value = "/SignUp/memUpdate2", method = RequestMethod.GET)
	public String getMemberUpdate(Model model) {
		MemberBean mb = new MemberBean();
		// model.添加屬性("MemberBean", mb)
		model.addAttribute("MemberBean", mb);

		// 回傳 "回傳會員資料修改表單"
		return "signUp/memUpdate2";
	}

	// 請求映射 ( 值 = "連結名稱" , 方法 = 請求方法 .POST )
	@RequestMapping(value = "/SignUp/memUpdate2", method = RequestMethod.POST) //
	public String UpdateSuccess(@ModelAttribute("MemberBean") MemberBean mb,BindingResult result,
			HttpServletRequest request, @RequestParam("userimage") MultipartFile userimage) {
		// 呼叫service.updateMem(mb)
		
		Blob imageBlob = null;
		
//		MultipartFile userimage = mb.getUserimage();

		if (userimage != null) {
			byte[] buf;

			try {
				buf = userimage.getBytes();
				Blob blob = new SerialBlob(buf);
				imageBlob = blob;
//				courseImage =  blob;
////				for (MultipartFile image : courseImage) {
////					System.out.println("Part name=" + image.getName());
////					++count;
//				inStream = courseImage.getInputStream();
//				fileName = courseName + ".jpg";
//				outStream = new FileOutputStream(imgAddress + fileName);
//
//				while ((data = inStream.read(buf)) != -1) {
//					outStream.write(buf, 0, data);
//				}
//				inStream.close();
//				outStream.close();
//				allImg += imgAddress + fileName;
//
////				}
			} catch (IOException | SQLException e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常:" + e.getMessage());
			}
		}
		mb.setUserimg(imageBlob);

		service.updateMem(mb);
		// 回傳 重新整理後 轉跳到回"會員資料頁面"
		return "redirect:/SignUp/memUpdate";
	}

	@ModelAttribute // Map${路徑寫在這裡}
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("男生", "男生");
		genderMap.put("女生", "女生");
		genderMap.put("其他", "其他");
		model.addAttribute("genderMap", genderMap);// 性別

	}

	// 丟空白表單
	@RequestMapping(value = "/signUp/forgetPassword", method = RequestMethod.GET)
	public String getforgetPassword() {
		return "signUp/forgetPassword";
	}

	@RequestMapping(value = "/signUp/forgetPassword", method = RequestMethod.POST)
	public String getaccAccount(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String account = request.getParameter("account");
		session.setAttribute("account", account);
		Boolean aaa = service.searchAccount(account);
		if (aaa == true) {
			return "redirect:/sendmail";
		} else {
			return null;
		}
	}

	// 導向驗證已過的頁面
	@RequestMapping(value = "/memberCheck")
	public String checkSuccess(@RequestParam(value = "userId", required = false) String userId) {
		service.modifyVerificationStatus(userId);
		return "redirect:/login/loginView";
	}

	@RequestMapping(value = "/sendmail", method = RequestMethod.GET)
	public String sendEmail(Model model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String account = (String) session.getAttribute("account");
		MemberBean temp = service.searchMemberBean(account);
		service.sendOrderConfirmation(getDummyOrder(temp, "forgetPassword"));
		return "index";
	}

	public static ProductOrder getDummyOrder(MemberBean memberBean, String purpose) {
		ProductOrder order = new ProductOrder();
		order.setOrderId(memberBean.getPassword());
		order.setProductName(purpose);
		System.out.println(String.valueOf(memberBean.getUserId()));
		order.setStatus(String.valueOf(memberBean.getUserId()));
		CustomerInfo customerInfo = new CustomerInfo();
		customerInfo.setName(memberBean.getNickname());
		customerInfo.setAddress("WallStreet");
		customerInfo.setEmail(memberBean.getAccount());
		order.setCustomerInfo(customerInfo);
		return order;
	}
}
