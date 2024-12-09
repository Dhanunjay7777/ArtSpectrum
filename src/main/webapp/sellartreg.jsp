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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Art Registration Form</title>
    <link rel="stylesheet" href="css/sellart.css"> <!-- Link to your external CSS file -->
</head>
<body>

<div class="form-container">
<h2 style="text-align: center;">Art Registration</h2>
<form action="/sellartreg" method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label for="arttitle">Art Title:</label>
            <input type="text" id="arttitle" name="arttitle" required>
        </div>
        <div class="form-group">
            <label for="artdescription">Art Description:</label>
            <textarea id="artdescription" name="artdescription" required></textarea>
        </div>
        <div class="form-group">
            <label for="artmedium">Art Medium:</label>
            <input type="text" id="artmedium" name="artmedium" required>
        </div>
        <div class="form-group">
            <label for="artdimensions">Art Dimensions:</label>
            <input type="text" id="artdimensions" name="artdimensions" required>
        </div>
        <div class="form-group">
            <label for="artcost">Art Cost:</label>
            <input type="number" id="artcost" name="artcost" required>
        </div>
        <div class="form-group">
            <label for="imageUrl">Image Upload:</label>
            <input type="file" id="imageurl" name="imageurl" accept=".jpg, .jpeg, .png" required> <!-- Accepts only image formats -->
        </div>
        <div class="form-group">
            <label for="dateListed">Date Listed:</label>
            <input type="date" id="datelisted" name="datelisted" required>
        </div>
        <div class="form-group">
            <label for="availstatus">Availability Status:</label>
             <select id="availstatus" name="availstatus" required>
                <option value="">Select Availability</option>
                <option value="InStock">In Stock</option>
                <option value="OutOfStock">Out of Stock</option>
            </select>        
            </div>
        <div class="artbutton-group">
            <button type="submit">Register Art</button>
        </div>
    </form>
</div>

</body>
</html>
