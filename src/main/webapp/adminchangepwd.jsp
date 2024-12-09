<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="adminnav.jsp" %>
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
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <link rel="stylesheet" href="css/changepwd.css"/>
</head>
<body>

<div class="change-password-form">
    <h2>Change Password</h2>
    <form action="changeapwd" method="post">
            <label for="currentPassword">Current Password</label>
            <input type="password" id="currentPassword" name="currentpwd" required>
            <label for="newPassword">New Password</label>
            <input type="password" id="newPassword" name="newpwd" required>
            <button type="submit">Submit</button>
    </form>
</div>
<div id="alertBox">
    <div id="alertMessage"></div>
    <div class="progress"></div>
</div>
</body>
<script>
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    document.addEventListener("DOMContentLoaded", function() {
        var errorMessage = getUrlParameter('message');
        const alertBox = document.getElementById('alertBox');
        const alertMessage = document.getElementById('alertMessage');
        const progressBar = alertBox.querySelector('.progress');

        if (errorMessage === 'w3dhsur34s') {
            alertMessage.textContent = 'Password changed successfully!';
            alertBox.classList.add('show');
            progressBar.style.transform = 'scaleX(1)';
        } else if (errorMessage === 'failure') {
            alertMessage.textContent = 'Invalid current password';
            alertBox.classList.add('show');
            progressBar.style.transform = 'scaleX(1)';
        } else if (errorMessage === 'sa456464') {
            alertMessage.textContent = 'Old and New Password Cannot be Same';
            alertBox.classList.add('show');
            progressBar.style.transform = 'scaleX(1)';
        }
        setTimeout(() => {
            alertBox.classList.remove('show');
            progressBar.style.transform = 'scaleX(0)';
        }, 3000);
    });
</script>


</html>
