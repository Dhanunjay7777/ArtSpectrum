<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Art Gallery</title>
    <link rel="stylesheet" href="css/register.css"/>
    
    <style>
        .error { color: red; margin-top: 5px; }
        .error-card {
            border: 1px solid red;
            background-color: #f8d7da;
            padding: 10px;
            margin-top: 5px;
        }
    </style>
      <script src="js/reg.js"></script>
</head>
<body>
<header class="main-header">
    <div class="logo">
        <h1>The Art Spectrum</h1>
    </div>
    <nav class="nav-links">
        <a href="login">Login</a>
        <a href="contactus">Contact</a>
    </nav>
</header>

<div class="registerWindow">
    <div class="registerHeader">Art Gallery Registration</div>
    <div class="registerContent">
        <form name="registrationForm" action="register" method="post" onsubmit="return validateForm();">
            <label for="name">Full Name:</label><br>
            <input type="text" id="name" name="name" required><br><br>
            
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required>
            <div id="emailError" class="error"></div>
            <br>

            <label for="password">Password:</label><br>
            <input type="password" id="password" name="password" pattern=".{8,}" required>
            <div id="passwordError" class="error"></div>
            <br>
            
            <label for="confirmPassword">Confirm Password:</label><br>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <div id="confirmPasswordError" class="error"></div>
            <br>
            
            <label for="gender">Gender:</label><br>
            <select id="gender" name="gender" required>
                <option value="" disabled selected>---Select---</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="prefernot_tosay">Prefer not to say</option>
            </select><br><br>

            <label for="contactno">Contact Number:</label><br>
            <input type="tel" id="contactno" name="contactno" required>
            <div id="contactnoError" class="error"></div>
            <br>
            
             <label for="userrole">Select role:</label><br>
            <select id="urole" name="urole" required>
                <option value="" disabled selected>---Select---</option>
                <option value="buyer">Buyer</option>
                <option value="seller">Seller</option>
            </select><br><br>
            
            <label for="address">Address:</label><br>
            <input type="text" id="address" name="address" required><br><br>

            <label for="dob">Date of Birth:</label><br>
            <input type="date" id="dob" name="dob" required><br><br>

            <label for="artPreference">Art Style Preference:</label><br>
            <select id="artPreference" name="artPreference" required>
                <option value="" disabled selected>---Select---</option>
                <option value="abstract">Abstract</option>
                <option value="realism">Realism</option>
                <option value="impressionism">Impressionism</option>
                <option value="modern">Modern</option>
                <option value="contemporary">Contemporary</option>
            </select><br><br>

            <label for="newsletter">Newsletter Subscription:</label><br>
            <select id="newsletter" name="newsletter" required>
                <option value="" disabled selected>---Select---</option>
                <option value="yes">Yes</option>
                <option value="no">No</option>
            </select><br><br>

            <input type="submit" value="Register"><br><br>

            <div style="text-align: center;">
                <span class="loginPrompt" style="font-size: 16px; color: #333;">Already have an account? </span>
                <a href="login" style="text-decoration: none; color: blue; font-size: 16px;">
                    <label style="cursor: pointer;">Login</label>
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
