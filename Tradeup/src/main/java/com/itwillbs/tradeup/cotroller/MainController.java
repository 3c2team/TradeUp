package com.itwillbs.tradeup.cotroller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.tradeup.service.MainService;
import com.mysql.cj.Session;

@Controller
public class MainController {
	
	@Autowired
	MainService service;
	
	@GetMapping("About")
	public String about() {
		
		return "about";
	}
	@GetMapping("Blog")
	public String blog() {
		
		return "blog";
	}
	@GetMapping("BlogDetails")
	public String blogDetails() {
		
		return "blog_details";
	}
	
	@GetMapping("Contact")
	public String contact() {
		
		
		return "contact";
	}
	
	// 안써도 될거같음
	@GetMapping("Main")
	public String main(HttpSession session) {
		
//		session.setAttribute("sId", "hyeri123");
		
		return "main";
	}
	@GetMapping("Shop")
	public String shop(Model model,@RequestParam(required = false) Map<String,String> map) {
		
		List<Map<String, String>> selectCategory = service.selectCategory();
		
//		System.out.println(selectCategory);
		System.out.println(map);
		if(map.get("price") != null) {
			System.out.println("일단 이건 성공");
			String[] price = map.get("price")
							.replace("만원", "0000")
							.replace("이상", "")
							.replace("이하", "")
							.trim()
							.split("-");
			for(int i = 0; i < price.length; i++) {
				if(i == 1) {
					map.put("minPrice", price[i]);
				}
				map.put("maxPrice", price[i]);
			}
		}
		List<Map<String, Object>> selectProduct = service.selectProduct(map);
		System.out.println("상품 목록" + selectProduct);
		model.addAttribute("selectProduct",selectProduct);
		model.addAttribute("selectCategory",selectCategory);
		return "shop/shop";
	}
	
	@GetMapping("ShopForm")
	public String shopForm(@RequestParam(required = false) Map<String,String> map, HttpSession session, Model model) {
		// 로그인X 처리
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인 후 이용부탁드립니다.");
			model.addAttribute("target", "redirect:/Main");
			return "fail_back";
		}
		
		List<Map<String, String>> selectCategory = service.selectCategory();
//		System.out.println(selectCategory);
		model.addAttribute("selectCategory",selectCategory);
		return "shop/shop_form";
	}
	
	@GetMapping("ShoppingCart")
	public String shoppingCart() {
		
		return "shopping_cart";
	}
	//사기조회 페이지 이동
	@GetMapping("FraudInquiry")
	public String fraudInquiry() {
		
		return "fraud_inquiry";
	}
	//사기조회 결과 처리
	@PostMapping("FraudInquiryPro")
	public String fraudInquiryPro() {
		
		return "redirect:/FraudInquiryDetail";
	}
	//사기조회 결과 페이지 이동
	@GetMapping("FraudInquiryDetail")
	public String fraudInquiryDtail() {
		
		return "fraud_inquiry_detail";
	}
	
	//시세조회 페이지 이동
	@GetMapping("MarketPriceInquiry")
	public String marketPriceInquiry() {
		
		return "market_price_inquiry";
	}
	//고객센터 페이지 이동
	@GetMapping("Customer")
	public String customer() {
		
		return "customer";
	}
	@GetMapping("UserCustomer")
	public String userCustomer(HttpSession session,Model model) {
		String sId = (String)session.getAttribute("sId");
		List<Map<String, String>> selectUserQna = service.selectUserQna(sId);
		model.addAttribute("selectUserQna",selectUserQna);
		return "user_customer";
	}
	//1대1 문의 페이지 이동
	@GetMapping("RegistQuewstion")
	public String registQuewstion(Model model) {
		
		List<Map<String, String>> selectQnaCategory = service.selectQnaCategory();
		System.out.println(selectQnaCategory.size());
		System.out.println(selectQnaCategory);
		model.addAttribute("selectQnaCategory", selectQnaCategory);
		return "regist_question";
	}
	@GetMapping("UserCustomerDetail")
	public String userCustomerDetail(Model model,int qna_num) {
		
		Map<String,String> QnaDetail = service.selectQnaDetail(qna_num);
		model.addAttribute("QnaDetail",QnaDetail);
		return "user_customer_detail";
	}
	@PostMapping("QuestionRegistPro")
	public String quewstionRegistPro(HttpSession session,@RequestParam(value =  "file" , required = false) MultipartFile[] imageList
			,@RequestParam Map<String, String> map) {
			String uploadDir = "/qna_img/";//가상 업로드 경로
			String saveDir = session.getServletContext().getRealPath(uploadDir);//실제 업로드 경로
			// 맵에 이름과 경로 전달
			//실제 파일 이름과 uuid랜덤합쳐서 겹치는걸 방지
			System.out.println(map);
			String sId = (String)session.getAttribute("sId");
			map.put("sId", sId);
			int insertQuestionCount = service.insertQuestion(map);
			
			if(insertQuestionCount == 0) return "fail_back";
			for(MultipartFile file : imageList) {
			String fileName = uuid(file.getOriginalFilename());
			map.put("real_file", uploadDir + fileName);
			map.put("file_name", fileName);
			int insertQuestionImgCount = service.insertQuestionImg(map);
			
			if(insertQuestionImgCount == 0) return "fail_back";
			newFile(saveDir,fileName,file);
			}

	return "redirect:/UserCustomer";
	}
	
//	@PostMapping("MarketPriceInquiryPro")
//	public String marketPriceInquiryPro(@RequestParam Map<String, String> map,Model model) {
//		String product_name = (String)map.get("product_name").replaceAll(" ", "");
//		
//		if(product_name.equals(""))return "redirect:/MarketPriceInquiry";
//		Map<String, String> selectPrice = service.selectProductPrice(product_name);
//		System.out.println("검색값 : " + product_name);
//		System.out.println("불러올값 : " + selectPrice);
//		selectPrice.put("product_name",product_name );
//		model.addAttribute("selectPrice",selectPrice);
//		return "market_price_inquiry_success";
//	}
//	
	@ResponseBody
	@PostMapping("SelectQnaCategorys")
	public List<Map<String, String>> selectQnaCategorys(@RequestParam(required = false) int qnaCategoryName) {
//		System.out.println(service.selectCategoryDetail("왜 갑자기 안돼! : " + qnaCategoryName));
		return service.selectCategoryDetail(qnaCategoryName);
	}	
	
	@ResponseBody
	@PostMapping("SelectOftenQna")
	public List<Map<String, String>> selectOftenQna(@RequestParam(required = false) Map<String, String> map) {
		System.out.println("카테고리 : " + map);
//		System.out.println(service.selectOftenQna(map));
	return service.selectOftenQna(map);

	}	
//	@PostMapping("selectProductPriceAVG")
//	public List<Map<String, String>> selectProductPriceAVG(@RequestParam(required = false) Map<String, String> map) {
//		System.out.println("응애 : " + map);
////		System.out.println(service.selectOftenQna(map));
//		return service.selectOftenQna(map);
//		
//	}	
//	
	

	public String uuid(String name) {
		String uuid = UUID.randomUUID().toString();
		
		return uuid.substring(0, 3) + "_" + name;
	}

	public void newFile(String saveDir, String fileName,MultipartFile file) {
		
		try {
			Path path = Paths.get(saveDir);//경로 저장
			Files.createDirectories(path);//중간 경로 생성
			file.transferTo(new File(saveDir, fileName));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
