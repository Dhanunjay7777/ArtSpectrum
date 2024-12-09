<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <script>
        // Function to check if new password and confirm password match
        function validatePasswords() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var submitButton = document.getElementById("submitBtn");

            // Enable submit button only if passwords match
            if (newPassword === confirmPassword && newPassword !== "") {
                submitButton.disabled = false;
            } else {
                submitButton.disabled = true;
            }
        }
    </script>
 
</head>
    <link rel="stylesheet" href="css/forgotpass.css">

<body>
 <header class="main-header">
        <div class="logo">
            <h1>The Art Spectrum</h1>
        </div>
        <nav class="nav-links">
            <a href="/login">Login</a>
            <a href="contactus">Contact</a>
        </nav>
    </header>
    <div class="background-image"></div> 
<div class="container">
    <h2>Forgot Password</h2>
    
    <!-- Form to send OTP -->
    <form action="sendotp" method="post">
        <div id="emailSection">
            <label for="email">Enter your email:</label>
            <input type="email" id="email" name="email" required>
            <button type="submit">Send OTP</button>
        </div>
    </form>
    
    <!-- Form to enter OTP and new password -->
    <form action="verifyotp" method="post">
        <label for="otp">Enter OTP:</label>
        <input type="text" id="otp" name="otp" required>
        <br><br>
        <label for="newPassword">Enter New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required oninput="validatePasswords()">
        <br><br>
        <label for="confirmPassword">Confirm New Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required oninput="validatePasswords()">
        <br><br>
        <button type="submit" id="submitBtn" disabled>Reset Password</button>
    </form>
     <c:if test="${not empty error}">
        <div style="color: red;">
            ${error}
        </div>
    </c:if>
</div>
    <!-- Error message display -->
   

</body>
</html>
