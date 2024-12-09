<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="klu.model.Consumer" %>
<%
Consumer consumer = (Consumer) session.getAttribute("cms");
if (consumer == null) {
    response.sendRedirect("sessionexpiry.html");
    return;
}
if (!"seller".equals(consumer.getUserRole())) {
    response.sendRedirect("forbidden.html"); // Redirect to forbidden page
    return;
}
    
  
%>
<%@ include file="sellernav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seller Home</title>
    <link rel="stylesheet" href="css/sellerhome.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
</head>
<body>
   
    <section class="dashboard-preview">
        <div class="hero-section">
            <div class="hero-content">
                <h1>Welcome, <%= consumer.getName() %>!</h1>
                <p>Your journey to success starts here. Explore endless opportunities to showcase your creativity and connect with buyers from around the world. Manage your art with ease, track sales, and watch your business grow. We provide all the tools you need to thrive in the art marketplace, so you can focus on what truly matters—creating stunning works of art.</p>
            </div>
        </div>

        <div class="quote-section">
            <blockquote>
                "Art is not freedom from discipline, but disciplined freedom." – John F. Kennedy
            </blockquote>
        </div>

        <div class="stats-summary">
            <h2>Quick Stats</h2>
            <div class="stats">
                <div class="stat-item">
                    <h3>Artworks Listed</h3>
                    <p>120</p>
                </div>
                <div class="stat-item">
                    <h3>Orders Received</h3>
                    <p>45</p>
                </div>
                <div class="stat-item">
                    <h3>Total Sales</h3>
                    <p>$3,200</p>
                </div>
            </div>
        </div>
    </section>

  

</body>
</html>
