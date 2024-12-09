<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <link rel="stylesheet" href="css/contactus.css"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>

<header class="main-header">
    <h1 style="color: white;">The Art Spectrum</h1>
    <nav class="nav-links">
        <a href="/">Home</a>
        <a href="login">Login</a>
    </nav>
</header>
<body>
    <div class="container">
        <div class="form-container">
            <div class="left-container">
                <div class="left-inner-container">
                    <h2>Let's Chat</h2>
                    <p>Whether you have a question, want to start a project, or simply want to connect.</p>
                    <br>
                    <p>Feel free to send me a message in the contact form.</p>
                </div>
            </div>

            <div class="right-container">
                <div class="right-inner-container">
                    <form action="#">
                        <h2 class="lg-view">Contact</h2>
                        <h2 class="sm-view">Let's Chat</h2>
                        <p>* Required</p>
                        <input type="text" placeholder="Name *" />
                        <input type="email" placeholder="Email *" />
                        <input type="text" placeholder="Company" />
                        <input type="tel" placeholder="Phone" />
                        <textarea rows="4" placeholder="Message"></textarea>
                        <button>Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2024 The Art Spectrum. All rights reserved.</p>
    </footer>
</body>
</html>
