<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LoginPage</title> 
    <link rel="stylesheet" href="css/login.css"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
    <header class="main-header">
        <div class="logo">
            <h1>The Art Spectrum</h1>
        </div>
        <nav class="nav-links">
            <a href="/">Home</a>
            <a href="contactus">Contact</a>
            <a href="#" id="aboutBtn">About</a> <!-- About Link -->
            
        </nav>
    </header>

    <div class="background-image"></div> <!-- Background Image Section -->

    <div class="illustration-left">
        <img src="https://cdn-icons-png.flaticon.com/512/8761/8761422.png" alt="Cartoon illustration left">
    </div>

    <div class="illustration-right">
        <img src="https://cdn-icons-png.flaticon.com/512/8761/8761414.png" alt="Cartoon illustration right">
    </div>

    <div class="container">
        <h2>Login</h2>
        <form action="login" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit">Login</button>
            
            <div class="signup-link">
                <p>Don't have an account? <a href="register">Create an account</a></p>
                <p>Forgot Password? <a href="forgot-password">Need Help</a></p>
            </div>
        </form>
    </div>
    
    <div id="aboutModal" class="modal">
        <div class="modal-content">
            <span class="close" id="closeModal">&times;</span>
            <div id="aboutContent">
                <!-- Content from about.jsp will be loaded here -->
            </div>
        </div>
    </div>
    
    
    <div id="alertBox" class="alert error" style="display:none;">
        <span id="alertMessage"></span>
        <div class="progress"></div> <!-- Progress Bar -->
    </div>
     <script src="js/main.js"></script>
    
</body>
</html>
    <script type="text/javascript">
    (function(d, m){
        var kommunicateSettings = 
            {"appId":"2d1d0d08894a7d07bca7f706aebfaea25","popupWidget":true,"automaticChatOpenOnNavigation":true};
        var s = document.createElement("script"); s.type = "text/javascript"; s.async = true;
        s.src = "https://widget.kommunicate.io/v2/kommunicate.app";
        var h = document.getElementsByTagName("head")[0]; h.appendChild(s);
        window.kommunicate = m; m._globals = kommunicateSettings;
    })(document, window.kommunicate || {});
/* NOTE : Use web server to view HTML files as real-time update will not work if you directly open the HTML file in the browser. */
</script>