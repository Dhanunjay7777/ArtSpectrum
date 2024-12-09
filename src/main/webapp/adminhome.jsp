<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="klu.model.Consumer" %>
<%
    Consumer consumer = (Consumer) session.getAttribute("cms");
    if (consumer == null) {
        response.sendRedirect("sessionexpiry.html");
        return; 
    } 
    if (!"admin".equals(consumer.getUserRole())) {
        response.sendRedirect("forbidden.html"); // Redirect to forbidden page
        return;
    }
%>
<%@ include file="adminnav.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/adminhome.css"/>
    <!-- Add chart.js for pie and other charts -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- FontAwesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"/>
</head>
<body>

<section class="dashboard-preview">
    <div class="hero-section">
        <div class="hero-content">
            <h1>Welcome, <%= consumer.getName() %>!</h1>
            <p class="quote">"The best way to predict the future is to create it." – Abraham Lincoln</p>
        </div>
    </div>

    <!-- Stats container -->
    <div class="stats-container">
        <div class="stat-card">
            <i class="fas fa-users fa-3x"></i>
            <h3>Total Users</h3>
            <p>${userscount}</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-chart-line fa-3x"></i>
            <h3>Revenue</h3>
            <p>₹ ${revenueCount}</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-cogs fa-3x"></i>
            <h3>Artwork's Listed</h3>
            <p>${artscount}</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-boxes fa-3x"></i>
            <h3>Orders Processed</h3>
            <p>${orderCount}</p> 
        </div>
    </div>

    <!-- New section for log-style notifications, below the stats -->
    <div id="log-container">
        <h3 style="color: white;">Notifications Log</h3>
        <div id="log-messages" style="margin-top: 10px;">
            <!-- Logs will be displayed here -->
        </div>
    </div>
</section>
<script>
if (!window.socket) {
    window.socket = new WebSocket("ws://localhost:8080/notifications");

    window.socket.onopen = function () {
        console.log("WebSocket connection established.");
    };

    window.socket.onmessage = function (event) {
        console.log("Notification received: " + event.data);

        // Dynamically display the notification in the log container
        const notificationMessage = event.data;
        const notificationElement = document.createElement("div");
        notificationElement.classList.add("notification");
        notificationElement.innerText = notificationMessage;

        // Append the notification to the log container
        document.getElementById("log-messages").appendChild(notificationElement);

        // Optionally, you can scroll to the bottom of the log container
        const logContainer = document.getElementById("log-messages");
        logContainer.scrollTop = logContainer.scrollHeight;
    };

    window.socket.onclose = function () {
        console.log("WebSocket connection closed.");
    };
}
</script>

</body>
</html>
