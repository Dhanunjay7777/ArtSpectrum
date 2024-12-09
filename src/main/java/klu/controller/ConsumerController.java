package klu.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.twilio.rest.api.v2010.account.call.PaymentCreator;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import klu.model.Artreg;
import klu.model.Consumer;
import klu.model.ConsumerManager;
import klu.model.Shipping;
import klu.websocket.NotificationWebSocketHandler;

import org.springframework.web.bind.annotation.PostMapping;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;
import software.amazon.awssdk.services.s3.model.PutObjectResponse;

import java.nio.file.Paths;


@RestController
@RequestMapping("/")//consumer
public class ConsumerController 
{
	@Autowired
	ConsumerManager CM;
	
@Autowired
  private JavaMailSender mailSender;
	
	@PostMapping("/register")
    public String register(HttpServletRequest request,HttpServletResponse response)throws IOException {


        Consumer C = new Consumer(); // Create a new Consumer object

        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String contactno = request.getParameter("contactno");
        String userrole = request.getParameter("urole");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String artPreference = request.getParameter("artPreference");
        String newsletter = request.getParameter("newsletter");

        Random random = new Random();
        Long userid = (long) (random.nextInt(9000) + 1000);
        C.setUserid(userid);
        C.setEmail(email);
        C.setName(name);
        C.setPassword(password);
        C.setGender(gender);
        C.setContactno(contactno);
        C.setAddress(address);
        C.setDateOfBirth(dob);
        C.setArtPreference(artPreference);
        C.setNewsletter(newsletter);
        C.setUserRole(userrole);

        String result =  CM.insertUser(C); 
        if ("redirectLogin".equals(result)) {
            response.sendRedirect("login?msg=success");  //here instead of this keep another file and then in that login link
            return null; 
        }
        else if ("alredyexist".equals(result)) 
        {
            response.sendRedirect("login?error=exist");  
            return null;
        }
        else {
            return result;
        }    }
	

	@PostMapping("/sendotp")
	public ModelAndView sendOtp(@RequestParam("email") String email, HttpSession session) {
	    ModelAndView mv = new ModelAndView();
	    String mobile = CM.findmobile(email);
	    String otp = generateOtp();
	    session.setAttribute("otp", otp);
	    session.setAttribute("email", email);  // Store email in session
	    
	    try {
	        sendEmail(email, otp);  // Send OTP email
	        mv.setViewName("forgot-password");  // Stay on the OTP verification page
	    } catch (MessagingException e) {
	        mv.addObject("error", "Failed to send OTP, please try again.");
	        mv.setViewName("forgot-password");  // Stay on the OTP page if email fails
	    }
	    
	    return mv;
	}

	@PostMapping("/verifyotp")
	public ModelAndView verifyOtp(@RequestParam("otp") String otp, 
	                              @RequestParam("newPassword") String newPassword, 
	                              HttpSession session) {
	    ModelAndView mv = new ModelAndView();
	    
	    String sessionOtp = (String) session.getAttribute("otp");
	    String email = (String) session.getAttribute("email");
	    
	    if (sessionOtp != null && sessionOtp.equals(otp)) {
	        String result = CM.resetPass(email, newPassword);
	        
	        if ("success".equals(result)) {
	            session.removeAttribute("otp");
	            session.removeAttribute("email");
	            
	            mv.setViewName("login");
	        } else {
	            mv.addObject("error", "Failed to reset password. Please try again.");
	            mv.setViewName("forgot-password");
	        }
	    } else {
	        mv.addObject("error", "Invalid OTP. Please try again.");
	        mv.setViewName("forgot-password");
	    }
	    
	    return mv;
	}

//For OTP generation
	
    private String generateOtp() {
        return String.valueOf(10000 + new SecureRandom().nextInt(90000)); 
    }

    private void sendEmail(String to, String otp) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setTo(to);
        helper.setSubject("Your OTP for Forgot Password");
        helper.setText("Your OTP is: " + otp);
        mailSender.send(message);
    }

	
	@PostMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");

	    Consumer C = CM.loginUser(email, password);
	    if (C != null) {
	        HttpSession session = request.getSession();
	        session.setAttribute("cms", C);
	        session.setMaxInactiveInterval(86400);

	        sendLoginSuccessEmail(C.getEmail(),C.getName());
	        String notificationMessage = C.getName() + " (" + C.getEmail() + ") has logged in.";
	        NotificationWebSocketHandler.sendNotification(notificationMessage);
	        if ("buyer".equalsIgnoreCase(C.getUserRole())) {
	            response.sendRedirect("buyerhome");
	        } else if ("seller".equalsIgnoreCase(C.getUserRole())) {
	            response.sendRedirect("sellerhome");
	        } else if ("admin".equalsIgnoreCase(C.getUserRole())) {
	            response.sendRedirect("adminhome");
	        }
	        return null; 
	    } else {
	    	
	    	 response.sendRedirect("login?error=invalid");
	    	 return null;
	    	 
	    }
	}
	

	private void sendLoginSuccessEmail(String userEmail,String userName) {
	    SimpleMailMessage message = new SimpleMailMessage();
	    message.setTo(userEmail);
	    message.setSubject("Login Successful");
	    String messageBody = String.format(
	            "Dear %s,\n\n" +
	            "You have successfully logged in to your account. If this was not you, please contact our support team immediately.\n\n" +
	            "If you have any questions or need assistance, feel free to reach out to us at:\n" +
	            "Email: support@artspectrum.com\n" +
	            "Phone: (123) 456-7890\n\n" +
	            "Warm regards,\n" +
	            "The Art Spectrum Team",
	            userName
	            
	        );
	    message.setText(messageBody);

	    try {
	        mailSender.send(message);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


	
	 @PostMapping("/paysuccess")
	    public void handlePaymentSuccess(HttpServletRequest request, HttpServletResponse response) throws IOException {

	        // Retrieving parameters from the request
	        String artseller = request.getParameter("artseller");
	        String artid = request.getParameter("artid");
	        String orderid = request.getParameter("orderid").replaceFirst("#", "%23");
	        String shippingaddress = request.getParameter("shippingaddress");
	        String artcost = request.getParameter("artcost");
	        String arttitle = request.getParameter("arttitle");
	        String artdimensions = request.getParameter("artdimensions");
	        String artimage = request.getParameter("artimage");
	        String paystatus = request.getParameter("paystatus");

	        // Calling the service or business logic to handle the payment status
	        String result = CM.paysuccess(orderid, paystatus);
	        
	        if ("success".equals(result)) {
	            String encodedArtseller = Base64.getEncoder().encodeToString(artseller.getBytes("UTF-8"));
	            String encodedArtid = Base64.getEncoder().encodeToString(artid.getBytes("UTF-8"));
	            String encodedOrderid = Base64.getEncoder().encodeToString(orderid.getBytes("UTF-8"));
	            String encodedShippingAddress = Base64.getEncoder().encodeToString(shippingaddress.getBytes("UTF-8"));
	            String encodedArtCost = Base64.getEncoder().encodeToString(artcost.getBytes("UTF-8"));
	            String encodedOrderStatus = Base64.getEncoder().encodeToString("Ordered".getBytes("UTF-8"));
	            String encodedArtTitle = Base64.getEncoder().encodeToString(arttitle.getBytes("UTF-8"));
	            String encodedArtDimensions = Base64.getEncoder().encodeToString(artdimensions.getBytes("UTF-8"));
	            String encodedArtImage = Base64.getEncoder().encodeToString(artimage.getBytes("UTF-8"));
	            
	            String redirectUrl = "ordersuccess?artseller=" + encodedArtseller +
	                                 "&artid=" + encodedArtid +
	                                 "&orderid=" + encodedOrderid +
	                                 "&shippingaddress=" + encodedShippingAddress +
	                                 "&artcost=" + encodedArtCost +
	                                 "&orderstatus=" + encodedOrderStatus +
	                                 "&arttitle=" + encodedArtTitle +
	                                 "&artdimensions=" + encodedArtDimensions +
	                                 "&artimage=" + encodedArtImage;
	            
	            response.sendRedirect(redirectUrl);
	        } else {
	            response.sendRedirect("paymentFailed.jsp");
	        }
	    }

	
	
  @PostMapping("/sellartreg")
  public String sellartreg(HttpServletRequest request,HttpServletResponse response,@RequestParam("imageurl") MultipartFile imageFile)throws IOException 
  {
      Artreg A = new Artreg();
      HttpSession session = request.getSession();
      
      Consumer seller = (Consumer) session.getAttribute("cms");
      
	  Random random = new Random();
	  int randomDigits = 100000 + random.nextInt(900000);
	  String artid = "ART" + randomDigits;
	 
	  String sellername = seller.getName();
	  String sellerid = seller.getUserid().toString();

      String arttitle = request.getParameter("arttitle");
      String artdescription = request.getParameter("artdescription");
      String artmedium = request.getParameter("artmedium");
      String artdimensions = request.getParameter("artdimensions");
      String artcost = request.getParameter("artcost");
      String datelisted = request.getParameter("datelisted");
      String availstatus = request.getParameter("availstatus");
      String appPath = request.getServletContext().getRealPath(""); // Get the real path of the web application
      String folder = appPath + "arts/";
      String imageFileName = sellerid + "_image" + randomDigits + ".jpg";
      String filePath = folder + imageFileName;
      File file = new File(filePath);
      imageFile.transferTo(file);
      String imageUrl = "arts/" + imageFileName;
      A.setImageurl(imageUrl);
      
      A.setArtid(artid);
      A.setSellername(sellername);
      A.setSellerid(sellerid);
      A.setArttitle(arttitle);
      A.setArtdescription(artdescription);
      A.setArtmedium(artmedium);
      A.setArtdimensions(artdimensions);
      A.setArtcost(artcost);
      A.setDatelisted(datelisted);
      A.setAvailstatus(availstatus);
      
    
      
     String result = CM.insertArt(A);
     if("artsuccess".equals(result)) 
     {
    	 response.sendRedirect("myarts");
    	 return null;
     }
     else
     {
    	 //response.sendRedirect("artfailure");
    	 return result;
     }
  
  }
	 
	 
	 
	

  @PostMapping("/shipping")
  public String shipping(HttpServletRequest request,HttpServletResponse response)throws IOException {
      Shipping S = new Shipping(); // Create a new Consumer object
      HttpSession session = request.getSession();
      
      Consumer buyer = (Consumer) session.getAttribute("cms");

      String orderid = URLEncoder.encode("#order-" + (100000 + new Random().nextInt(900000)) + "-" + (100000 + new Random().nextInt(900000)));
      String artid = request.getParameter("artid");
      String arttitle = request.getParameter("arttitle");
      String artmedium = request.getParameter("artmedium");
      String artdimensions = request.getParameter("artdimensions");
      String artcost =  request.getParameter("artcost");
      String shippingaddress = request.getParameter("shippingaddress");
      String buyerid =  buyer.getUserid().toString();
      String buyername = buyer.getName();
      String artseller = request.getParameter("artseller");
      String artsellerid = request.getParameter("sellerid");
      String orderstatus = "Ordered";
      String artimage = request.getParameter("artimage");
      String paystatus ="NotPaid";
      String buyerEmail = buyer.getEmail();
      
      
      S.setOrderid(orderid);
      S.setArtid(artid);
      S.setArttitle(arttitle);
      S.setArtmedium(artmedium);
      S.setArtdimensions(artdimensions);
      S.setArtcost(artcost);
      S.setShippingaddress(shippingaddress);
      S.setBuyerid(buyerid);
      S.setBuyername(buyername);
      S.setArtseller(artseller);
      S.setArtsellerid(artsellerid);
      S.setOrderstatus(orderstatus);
      S.setArtimage(artimage);
      S.setPaystatus(paystatus);
      
      String result = CM.insertship(S);
      String notificationMessage = "Order " + S.getOrderid().replaceFirst("%23","#") + S.getBuyername()+ " has been placed by "  + ".";    
      NotificationWebSocketHandler.sendNotification(notificationMessage);
      if("ordersuccess".equals(result))
      {
        sendOrderConfirmationEmail(buyerEmail,buyername, orderid.replaceFirst("%23", "#"), arttitle, artcost, shippingaddress, orderstatus,artimage);

//    	  response.sendRedirect("ordersuccess?artseller=" + Base64.getEncoder().encodeToString(artseller.getBytes("UTF-8")) +
//                  "&artid=" + Base64.getEncoder().encodeToString(artid.getBytes("UTF-8")) +
//                  "&orderid=" + Base64.getEncoder().encodeToString(orderid.getBytes("UTF-8")) +
//                  "&shippingaddress=" + Base64.getEncoder().encodeToString(shippingaddress.getBytes("UTF-8")) +
//                  "&artcost=" + Base64.getEncoder().encodeToString(artcost.getBytes("UTF-8")) +
//                  "&orderstatus=" + Base64.getEncoder().encodeToString("Ordered".getBytes("UTF-8")) +
//                  "&arttitle=" + Base64.getEncoder().encodeToString(arttitle.getBytes("UTF-8")) +
//                  "&artdimensions=" + Base64.getEncoder().encodeToString(artdimensions.getBytes("UTF-8")) +
//                  "&artimage=" + Base64.getEncoder().encodeToString(artimage.getBytes("UTF-8")));
    	  
    	  response.sendRedirect("viewqr.jsp?artseller=" + Base64.getEncoder().encodeToString(artseller.getBytes("UTF-8")) +
                  "&artid=" + Base64.getEncoder().encodeToString(artid.getBytes("UTF-8")) +
                  "&orderid=" + Base64.getEncoder().encodeToString(orderid.getBytes("UTF-8")) +
                  "&shippingaddress=" + Base64.getEncoder().encodeToString(shippingaddress.getBytes("UTF-8")) +
                  "&artcost=" + Base64.getEncoder().encodeToString(artcost.getBytes("UTF-8")) +
                  "&orderstatus=" + Base64.getEncoder().encodeToString("Ordered".getBytes("UTF-8")) +
                  "&arttitle=" + Base64.getEncoder().encodeToString(arttitle.getBytes("UTF-8")) +
                  "&artdimensions=" + Base64.getEncoder().encodeToString(artdimensions.getBytes("UTF-8")) +
                  "&artimage=" + Base64.getEncoder().encodeToString(artimage.getBytes("UTF-8")));

return null;

      }
      else
      {
    	  return result;
      }
      
  }
   
  private void sendOrderConfirmationEmail(String buyerEmail, String buyername, String orderid, String arttitle, String artcost, String shippingaddress, String orderstatus, String artimage) {
	    try {
	        MimeMessage mimeMessage = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
	        helper.setTo(buyerEmail);
	        helper.setSubject("Order Confirmation: " + orderid);

	        String messageBody = String.format(
	            "<html>" +
	                "<body>" +
	                    "<p>Dear %s,</p>" +
	                    "<p>Thank you for your purchase! Below are the details of your order:</p>" +
	                    "<p>Order ID: %s<br>" +
	                    "Art Title: %s<br>" +
	                    "Art Cost: %s<br>" +
	                    "Shipping Address: %s<br>" +
	                    "Order Status: %s</p>" +
	                    "<p>Here is the image of the artwork:</p>" +
	                    "<img src='%s' alt='Art Image' style='width:300px; height:200px;' />" +
	                    "<p>We will notify you once your order is shipped.</p>" +
	                    "<p>Best regards,<br>Art Gallery Team</p>" +
	                "</body>" +
	            "</html>",
	            buyername, orderid, arttitle, artcost, shippingaddress, orderstatus, artimage
	        );

	        helper.setText(messageBody, true);
	        mailSender.send(mimeMessage);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


  
  
  
  
  
  @PostMapping("cancelorder")
  public String cancelorder(HttpServletRequest request,HttpServletResponse response)throws IOException
  {
    String orderid = request.getParameter("orderid").replace("#", "%23");
    String userid = request.getParameter("userid");
    String orderstatus = "Canceled";

   
    
    String result = CM.cancelOrder(orderid,orderstatus,userid);
    if("cancelorder".equals(result)) 
    {
   	 response.sendRedirect("myorders");
   	 return null;
    }
    else
    {
   	 return result;
    }
     
  }
  
  @PostMapping("updatemyart")
  public String updatemyart(HttpServletRequest request,HttpServletResponse response)throws IOException 
  {
   HttpSession session = request.getSession();
   Consumer seller = (Consumer) session.getAttribute("cms");
   
   Artreg A = new Artreg();
   String artId = request.getParameter("artId");
   String artTitle = request.getParameter("artTitle");
   String artPrice = request.getParameter("artPrice");
   String artDimensions = request.getParameter("artDimensions");
   String artMedium = request.getParameter("artMedium");
   String artDescription = request.getParameter("artDescription");
   String artStatus = request.getParameter("artStatus");
   String sellerid = seller.getUserid().toString();

   
   
   A.setArtid(artId);
   A.setArttitle(artTitle);
   A.setArtcost(artPrice);
   A.setArtdimensions(artDimensions);
   A.setArtmedium(artMedium);
   A.setArtdescription(artDescription);
   A.setAvailstatus(artStatus);
   A.setSellerid(sellerid);
   
   String result = CM.updateMyArt(A);
   if("updateartsuccess".equals(result))
   {
	   response.sendRedirect("myarts");
	   return null;
   }
   else
   {
	   return result;
   }
  }
  
  
  
  @PostMapping("updateallart")
  public String updateallart(HttpServletRequest request,HttpServletResponse response)throws IOException 
  {
   Artreg A = new Artreg();
   String artId = request.getParameter("artId");
   String artTitle = request.getParameter("title");
   String artPrice = request.getParameter("cost");
   String artDimensions = request.getParameter("dimensions");
   String artMedium = request.getParameter("medium");
   String artDescription = request.getParameter("description");
   String artStatus = request.getParameter("availStatus");
   String sellerid = request.getParameter("sellerId");
   String sellername = request.getParameter("sellerName");

   A.setArtid(artId);
   A.setArttitle(artTitle);
   A.setArtcost(artPrice);
   A.setArtdimensions(artDimensions);
   A.setArtmedium(artMedium);
   A.setArtdescription(artDescription);
   A.setAvailstatus(artStatus);
   A.setSellerid(sellerid);
   A.setSellername(sellername);
   
 
   
   String result = CM.updateAllArt(A);
   if("updateallart".equals(result))
   {
	   response.sendRedirect("viewarts");
	   return null;
   }
   else
   {
	   return result;
   }
  }
  
  
  
//  
//  @PostMapping("updateorder")
//  public String updateorder(HttpServletRequest request,HttpServletResponse response)throws IOException
//  {
//    HttpSession session = request.getSession();
//
//	Consumer seller = (Consumer) session.getAttribute("cms");
//    String orderid = request.getParameter("orderid").replace("#", "%23");
//    String newstatus = request.getParameter("orderstatus");
//
//    String sellerid = seller.getUserid().toString();
//   
//    
//    String result = CM.updateOrder(orderid,newstatus,sellerid);
//    if("updatedorder".equals(result)) 
//    {
//   	 response.sendRedirect("vieworders");
//   	 return null;
//    }
//    else
//    {
//   	 return result;
//    }
//     
//  }
  @PostMapping("updateorder")
  public String updateorder(HttpServletRequest request, HttpServletResponse response) throws IOException {
      HttpSession session = request.getSession();

      Consumer seller = (Consumer) session.getAttribute("cms");
      if (seller == null) {
          response.sendRedirect("vieworders?error=You%20must%20be%20logged%20in%20to%20update%20the%20order.");
          return null;
      }

      String orderid = request.getParameter("orderid").replace("#", "%23");
      String newstatus = request.getParameter("orderstatus");

      String sellerid = seller.getUserid().toString();

      String result = CM.updateOrder(orderid, newstatus, sellerid);

      if ("updatedorder".equals(result)) {
          response.sendRedirect("vieworders");  
          return null;
      } else {
          response.sendRedirect("vieworders?error=" + URLEncoder.encode(result, "UTF-8"));
          return null;
      }
  }

  
  @PostMapping("updateallorder")
  public String updateallorder(HttpServletRequest request,HttpServletResponse response)throws IOException 
  {
   Shipping S = new Shipping();
   
   String orderId = request.getParameter("orderId").replaceFirst("#", "%23");
   String artCost = request.getParameter("artCost");
   String artDimensions=request.getParameter("artDimensions");
   String artId = request.getParameter("artId");
   String artMedium = request.getParameter("artMedium");
   String artSeller=request.getParameter("artSeller");
   String artTitle = request.getParameter("artTitle");
   String buyerId = request.getParameter("buyerId");
   String buyerName = request.getParameter("buyerName");
   String orderStatus = request.getParameter("orderStatus");
   String shippingAddress = request.getParameter("shippingAddress");
   
   S.setOrderid(orderId);
   S.setArtcost(artCost);
   S.setArtdimensions(artDimensions);
   S.setArtid(artId);
   S.setArtmedium(artMedium);
   S.setArtseller(artSeller);
   S.setArttitle(artTitle);
   S.setBuyerid(buyerId);
   S.setBuyername(buyerName);
   S.setOrderstatus(orderStatus);
   S.setShippingaddress(shippingAddress);
   
   String result = CM.updateAllOrder(S);
   if("updateallorder".equals(result))
   {
	   response.sendRedirect("viewallorders");
	   return null;
   }
   else
   {
	   return result;
   }
  }
  
  
  @PostMapping("deletemyart")
  public String deletemyart(HttpServletRequest request,HttpServletResponse response)throws IOException
  {    HttpSession session = request.getSession();
       Consumer seller = (Consumer) session.getAttribute("cms");
       
	    String artId = request.getParameter("artId");
	    String sellerid = seller.getUserid().toString();


	    String result = CM.deleteArtById(artId,sellerid);
	    
	    if("deletedart".equals(result))
	    {
	    	response.sendRedirect("myarts");
	    	return null;
	    }
	    else
	    {
	    	return result;
	    }

  }
  
  
  
  @PostMapping("/updatecustomers")
  public String updatecustomers(HttpServletRequest request,HttpServletResponse response)throws IOException {
	    
	  String useridParam = request.getParameter("userId");  
	  Long userid = Long.valueOf(useridParam);
	  String name = request.getParameter("name");
      String gender = request.getParameter("gender");
      String contactno = request.getParameter("contactno");
      String address = request.getParameter("address");
      String dob = request.getParameter("dob");
      String artPreference = request.getParameter("artPreference");
      String newsletter = request.getParameter("newsletter");



      String result =  CM.updateUser(userid,name,gender,contactno,address,dob,artPreference,newsletter); 
      if ("updateduser".equals(result)) {
          response.sendRedirect("viewcustomers?message=User updated successfully");
          return null; 
      } else {
          return result;
      }    }
  
  
  
  
  @PostMapping("deletecustomer")
  public String deletecustomer(HttpServletRequest request,HttpServletResponse response)throws IOException
  {
	    String userId = request.getParameter("userId");

	    String result = CM.deleteCustomerById(userId);
	    
	    if("deletedconsumer".equals(result))
	    {
	    	response.sendRedirect("viewcustomers");
	    	return null;
	    }
	    else
	    {
	    	return result;
	    }

  }
  
  
  @PostMapping("deleteallart")
  public String deleteallart(HttpServletRequest request,HttpServletResponse response)throws IOException
  {
	    String artId = request.getParameter("artId");
	    

	    String result = CM.deleteallArtById(artId);
	    
	    if("deletedallart".equals(result))
	    {
	    	response.sendRedirect("viewarts");
	    	return null;
	    }
	    else
	    {
	    	return result;
	    }

  }
  
  
  @PostMapping("deleteallorder")
  public String deleteallorder(HttpServletRequest request,HttpServletResponse response)throws IOException
  {
	    String orderId = request.getParameter("orderId").replace("#", "%23");

	    String result = CM.deleteallOrderById(orderId);
	    
	    if("deletedallorder".equals(result))
	    {
	    	response.sendRedirect("viewallorders");
	    	return null;
	    }
	    else
	    {
	    	return result;
	    }

  }
  
 
  @PostMapping("changepwd")
  public String changepwd(HttpServletRequest request, HttpServletResponse response) throws IOException {
      HttpSession session = request.getSession();
      Consumer buyer = (Consumer) session.getAttribute("cms");
      
      String currentpwd = request.getParameter("currentpwd");
      String newpwd = request.getParameter("newpwd");
      
      if (buyer.getPassword().equals(currentpwd)) {
    	    if (currentpwd.equals(newpwd)) {
    	        response.sendRedirect("changepwd?message=sa456464"); 
    	        return null;
    	    } else {
    	        String result = CM.changePassword(buyer.getUserid(), newpwd);

    	        if ("changed".equals(result)) {
    	        	buyer.setPassword(newpwd);
    	        	session.setAttribute("cms", buyer);
    	            response.sendRedirect("changepwd?message=w3dhsur34s");
    	            return null;
    	        } else {
    	            return result;
    	        }
    	    }
    	} else {
    	    response.sendRedirect("changepwd?message=failure");
    	    return null;
    	}
  }

  @PostMapping("changespwd")
  public String changespwd(HttpServletRequest request, HttpServletResponse response) throws IOException {
      HttpSession session = request.getSession();
      Consumer seller = (Consumer) session.getAttribute("cms");
      
      String currentpwd = request.getParameter("currentpwd");
      String newpwd = request.getParameter("newpwd");
      
      if (seller.getPassword().equals(currentpwd)) {
    	    if (currentpwd.equals(newpwd)) {
    	        response.sendRedirect("changespwd?message=sa456464"); 
    	        return null;
    	    } else {
    	        String result = CM.changePassword(seller.getUserid(), newpwd);

    	        if ("changed".equals(result)) {
    	             seller.setPassword(newpwd);
    	        	session.setAttribute("cms", seller);
    	            response.sendRedirect("changespwd?message=w3dhsur34s");
    	            return null;
    	        } else {
    	            return result;
    	        }
    	    }
    	} else {
    	    response.sendRedirect("changespwd?message=failure");
    	    return null;
    	}
  }
  
  @PostMapping("changeapwd")
  public String changeapwd(HttpServletRequest request, HttpServletResponse response) throws IOException {
      HttpSession session = request.getSession();
      Consumer admin = (Consumer) session.getAttribute("cms");
      
      String currentpwd = request.getParameter("currentpwd");
      String newpwd = request.getParameter("newpwd");
      
      if (admin.getPassword().equals(currentpwd)) {
    	    if (currentpwd.equals(newpwd)) {
    	        response.sendRedirect("changeapwd?message=sa456464"); 
    	        return null;
    	    } else {
    	        String result = CM.changePassword(admin.getUserid(), newpwd);

    	        if ("changed".equals(result)) {
    	             admin.setPassword(newpwd);
    	        	session.setAttribute("cms", admin);
    	            response.sendRedirect("changeapwd?message=w3dhsur34s");
    	            return null;
    	        } else {
    	            return result;
    	        }
    	    }
    	} else {
    	    response.sendRedirect("changeapwd?message=failure");
    	    return null;
    	}
  }
  
}
	
	
	


