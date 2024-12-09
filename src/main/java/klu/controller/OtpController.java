package klu.controller;

import java.security.SecureRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

import jakarta.servlet.http.HttpSession;
import klu.model.ConsumerManager;

@RestController
public class OtpController {
    @Autowired
    ConsumerManager CM;

    // Twilio Account SID and Auth Token
    private static final String ACCOUNT_SID = "ACcc695121ec0dddd8f719a053aafba270";
    private static final String AUTH_TOKEN = "8e295e94d3ace0121182dd5ce50c639d";
    private static final String TWILIO_PHONE_NUMBER = "+19787783466";

    static {
        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
    }

    @PostMapping("/sendotp")
    public ModelAndView sendOtp(@RequestParam("email") String email, HttpSession session) {
        ModelAndView mv = new ModelAndView();

        String contactNumber = CM.findmobile(email);

        if (contactNumber == null || contactNumber.isEmpty()) {
            mv.addObject("error", "No contact number associated with this email.");
            mv.setViewName("forgot-password");
            return mv;
        }

        // Validate and format the phone number
        if (!contactNumber.startsWith("+")) {
            contactNumber = "+91" + contactNumber; // Add default country code
        }

        String otp = generateOtp();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        try {
            sendSms(contactNumber, otp);
            mv.setViewName("forgot-password");
        } catch (Exception e) {
            mv.addObject("error", "Failed to send OTP. Please try again.");
            mv.setViewName("forgot-password");
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

    // OTP generation logic
    private String generateOtp() {
        return String.valueOf(10000 + new SecureRandom().nextInt(90000));
    }

    // Send SMS using Twilio
    private void sendSms(String to, String otp) {
        Message message = Message.creator(
                new PhoneNumber(to),
                new PhoneNumber(TWILIO_PHONE_NUMBER),
                "Your OTP For Forgot Password is: " + otp
        ).create();

        System.out.println("Message sent: " + message.getSid());
    }
}
