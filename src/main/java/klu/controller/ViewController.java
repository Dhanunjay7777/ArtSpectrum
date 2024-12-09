package klu.controller;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import klu.model.Artreg;
import klu.model.Consumer;
import klu.model.ConsumerManager;
import klu.model.Shipping;

@Controller
@RequestMapping("/")
public class ViewController 
{
    @Autowired
    ConsumerManager CM;
	
	@GetMapping("register")
	public ModelAndView register()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("Register");
		return MV;
	}
	@GetMapping("login")
	public ModelAndView login()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("login");
		return MV;
	}
	@GetMapping("buyerhome")
	public ModelAndView buyerhome()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("buyerhome");
		return MV;
	}
	@GetMapping("sellerhome")
	public ModelAndView sellerhome()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("sellerhome");
		return MV;
	}

	@GetMapping("adminhome")
	public ModelAndView adminhome() {
	    long orderCount = CM.getOrderCount(); 
	    long revenueCount = CM.getRevenueCount(); 
	    long userscount = CM.getUsersCount();
	    long artscount = CM.getArtsCount();

	    ModelAndView MV = new ModelAndView();
	    MV.setViewName("adminhome"); // This corresponds to your adminhome.jsp
	    MV.addObject("orderCount", orderCount); // Add the order count to the model
	    MV.addObject("revenueCount", revenueCount);  // Add revenue count to the model
	    MV.addObject("userscount", userscount);  // Add revenue count to the model
	    MV.addObject("artscount", artscount);  // Add revenue count to the model

	    return MV;
	}

	
	@GetMapping("sellartreg")
	public ModelAndView sellartreg()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("sellartreg");
		return MV;
	}
	@GetMapping("viewqr")
	public ModelAndView viewqr()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("viewqr");
		return MV;
	}
	@GetMapping("forgot-password")
	public ModelAndView forgotpassword()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("forgot-password");
		return MV;
	}
	@GetMapping("artfailure")
	public ModelAndView artfailure()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("artfailure");
		return MV;
	}
	@GetMapping("artsuccess")
	public ModelAndView artsuccess()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("artsuccess");
		return MV;
	}
	@GetMapping("Logout")
	public ModelAndView Logout()
	{
		ModelAndView MV = new ModelAndView();
		MV.setViewName("Logout");
		return MV;
	}
//	@GetMapping("artexplore")
//	public ModelAndView artexplore()
//	{
//		ModelAndView MV = new ModelAndView();
//		MV.setViewName("artexplore");
//		return MV;
//	}
	
//	 @GetMapping("/artexplore")
//	  public ModelAndView artexplore(HttpSession session) {
//		 Consumer buyer = (Consumer) session.getAttribute("cms");
//		    if(buyer==null)
//		    {
//		    	return new ModelAndView("redirect:/sessionexpiry.html");
//		    }
//	      List<Artreg> artList = CM.getAllArts(); 
//	      ModelAndView mv = new ModelAndView("artexplore");
//	      mv.addObject("artList", artList); 
//	      return mv;
//	  }
	@GetMapping("/artexplore")
	public ModelAndView artexplore(
	        @RequestParam(defaultValue = "1") int page, 
	        HttpSession session) {

	    Consumer buyer = (Consumer) session.getAttribute("cms");
	    if (buyer == null) {
	        return new ModelAndView("redirect:/sessionexpiry.html");
	    }

	    int pageSize = 8; // Number of records per page
	    Page<Artreg> artPage = CM.getPagedArts(page - 1, pageSize); // 0-indexed page

	    ModelAndView mv = new ModelAndView("artexplore");
	    mv.addObject("artList", artPage.getContent());
	    mv.addObject("currentPage", page);
	    mv.addObject("totalPages", artPage.getTotalPages());
	    return mv;
	}



		@GetMapping("shipping")
		public ModelAndView shipping()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("shipping");
			return MV;
		}
		
		@GetMapping("ordersuccess")
		public ModelAndView ordersuccess()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("ordersuccess");
			return MV;
		}
		
		@GetMapping("/myorders")
		public ModelAndView myorders(HttpSession session) {
		    Consumer buyer = (Consumer) session.getAttribute("cms");
		    if(buyer==null)
		    {
		    	return new ModelAndView("redirect:/sessionexpiry.html");
		    }
		    String buyerid =  buyer.userid.toString();
		    List<Shipping> shipList = CM.getmyorders(buyerid); 
		    ModelAndView mv = new ModelAndView("myorders");
		    mv.addObject("shipList", shipList); 
		    return mv;
		}
		
		
		@GetMapping("/")
		public ModelAndView mainhome()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("mainhome");
			return MV;
		}
		@GetMapping("/myarts")
		public ModelAndView myarts(HttpSession session) {
		    Consumer seller = (Consumer) session.getAttribute("cms");
		    if(seller==null)
		    {
		    	return new ModelAndView("redirect:/sessionexpiry.html");
		    }
		    String sellerid =  seller.userid.toString();
		    List<Artreg> artsList = CM.getMyArts(sellerid);
		    ModelAndView mv = new ModelAndView("myarts");
		    mv.addObject("artsList", artsList); 
		    return mv;
		}
		
		
		@GetMapping("/vieworders")
		public ModelAndView vieworders(HttpSession session) {
		    Consumer seller = (Consumer) session.getAttribute("cms");
		    if(seller==null)
		    {
		    	return new ModelAndView("redirect:/sessionexpiry.html");
		    }
		    String artsellerid =  seller.userid.toString();
		    List<Shipping> shipviewList = CM.getvieworders(artsellerid); 
		    ModelAndView mv = new ModelAndView("vieworders");
		    mv.addObject("shipviewList", shipviewList); 
		    return mv;
		}
		
		
		@GetMapping("updatemyart")
		public ModelAndView updatemyart()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("updatemyart");
			return MV;
		}
		
		@GetMapping("updateallart")
		public ModelAndView updateallart()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("updateallart");
			return MV;
		}
		@GetMapping("updateallorder")
		public ModelAndView updateallorder()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("updateallorder");
			return MV;
		}
		@GetMapping("aboutus")
		public ModelAndView aboutus()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("aboutus");
			return MV;
		}
		
		@GetMapping("contactus")
		public ModelAndView contactus()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("contactus");
			return MV;
		}
		
		
		@GetMapping("updatecustomers")
		public ModelAndView updatecustomers()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("updatecustomers");
			return MV;
		}
		
		
		
		@GetMapping("updateorder")
		public ModelAndView updateorder()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("updateorder");
			return MV;
		}
		
		@GetMapping("changepwd")
		public ModelAndView changepwd()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("buyerchangepwd");
			return MV;
		}
		
		@GetMapping("changespwd")
		public ModelAndView changespwd()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("sellerchangepwd");
			return MV;
		}
		@GetMapping("changeapwd")
		public ModelAndView changeapwd()
		{
			ModelAndView MV = new ModelAndView();
			MV.setViewName("adminchangepwd");
			return MV;
		}
		
		
		@GetMapping("/error")
		public String handleError()
		{
			return "error";
		}
		
		@GetMapping("/viewcustomers")
		public ModelAndView viewcustomers(HttpSession session) {
		    Consumer admin = (Consumer) session.getAttribute("cms");
		    if(admin==null)
		    {
		    	return new ModelAndView("redirect:/sessionexpiry.html");
		    }
		    List<Consumer> customerList = CM.getviewcustomers(); 
		    ModelAndView mv = new ModelAndView("viewcustomers");
		    mv.addObject("customerList", customerList); 
		    return mv;
		}
		
		@GetMapping("/viewarts")
		public ModelAndView viewarts(HttpSession session) {
		    Consumer admin = (Consumer) session.getAttribute("cms");
		    if(admin==null)
		    {
		    	return new ModelAndView("redirect:/sessionexpiry.html");
		    }
		    List<Artreg> artsList = CM.getAllArts(); 
		    ModelAndView mv = new ModelAndView("viewarts");
		    mv.addObject("artsList", artsList); 
		    return mv;
		}
		
		
		@GetMapping("/viewallorders")
		public ModelAndView viewallorders(HttpSession session) {
		    Consumer admin = (Consumer) session.getAttribute("cms");
		    if(admin==null)
		    {
		    	return new ModelAndView("redirect:/sessionexpiry.html");
		    }
		    List<Shipping> shipList = CM.getallorders(); 
		    ModelAndView mv = new ModelAndView("viewallorders");
		    mv.addObject("shipList", shipList); 
		    return mv;
		}
}
