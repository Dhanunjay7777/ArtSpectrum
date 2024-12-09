<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="klu.model.Consumer" %>
<%
    Consumer consumer = (Consumer) session.getAttribute("cms");
    if (consumer == null) {
        response.sendRedirect("sessionexpiry.html");
        return;
    }
    if (!"buyer".equals(consumer.getUserRole())) {
        response.sendRedirect("forbidden.html"); // Redirect to forbidden page
        return;
    }
%>
<%@ include file="buyernav.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buyer Home</title>
    <link rel="stylesheet" href="css/buyerhome.css"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
    <div class="main-content">
        <div class="hero-section">
            <div class="hero-content">
                <h1>Welcome, <%= consumer.getName() %>!</h1>
                <p>Your journey to discover exquisite art begins here. Explore, buy, and connect with artists from around the world. We are here to help you find art that speaks to your soul.</p>
            </div>
        </div>

        <div class="quote-section">
            <blockquote>
                "Every artist was first an amateur." – Ralph Waldo Emerson
            </blockquote>
        </div>

        <div class="features-section">
            <h2>Why You'll Love Our Platform</h2>
            <ul class="features-list">
                <li><i class="material-icons">search</i> Discover unique art pieces curated just for you</li>
                <li><i class="material-icons">shopping_cart</i> Secure and easy-to-use purchasing options</li>
                <li><i class="material-icons">favorite</i> Connect with your favorite artists and stay updated</li>
            </ul>
        </div>

        <div class="testimonials">
            <h2>What Our Buyers Say</h2>
            <blockquote>
                "This platform changed the way I purchase art. It’s seamless and fun!" – Emily R.
            </blockquote>
            <blockquote>
                "I found the perfect piece for my home, and the process was so easy." – John D.
            </blockquote>
        </div>

       <!--  <footer>
            <p>&copy; 2024 ArtWorld. All rights reserved. | <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a></p>
        </footer> -->
    </div>
</body>
</html>
