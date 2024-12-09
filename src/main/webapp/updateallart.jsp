<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>
<%@ page import="klu.model.Consumer" %>
<%@ include file="adminnav.jsp" %>

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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Arts</title>
    <link rel="stylesheet" type="text/css" href="css/updateallart.css">
</head>
<body>

<%
    String encodedArtId = request.getParameter("artId");
    String encodedTitle = request.getParameter("title");
    String encodedDescription = request.getParameter("description");
    String encodedCost = request.getParameter("cost");
    String encodedDimensions = request.getParameter("dimensions");
    String encodedMedium = request.getParameter("medium");
    String encodedAvailStatus = request.getParameter("availStatus");
    String encodedSellerId = request.getParameter("sellerId");
    String encodedSellerName = request.getParameter("sellerName");

    // Decode the Base64-encoded parameters
    String artId = new String(Base64.getDecoder().decode(encodedArtId), "UTF-8");
    String artTitle = new String(Base64.getDecoder().decode(encodedTitle), "UTF-8");
    String artDescription = new String(Base64.getDecoder().decode(encodedDescription), "UTF-8");
    String artCost = new String(Base64.getDecoder().decode(encodedCost), "UTF-8");
    String artDimensions = new String(Base64.getDecoder().decode(encodedDimensions), "UTF-8");
    String artMedium = new String(Base64.getDecoder().decode(encodedMedium), "UTF-8");
    String availStatus = new String(Base64.getDecoder().decode(encodedAvailStatus), "UTF-8");
    String sellerId = new String(Base64.getDecoder().decode(encodedSellerId), "UTF-8");
    String sellerName = new String(Base64.getDecoder().decode(encodedSellerName), "UTF-8");
%>

<div class="container">
    <h2>Update Artwork Details</h2>
    <form action="updateallart" method="POST">
        <div class="form-group">
            <label for="artId">Art ID:</label>
            <input type="text" id="artId" name="artId" value="<%= artId %>" readonly>
        </div>

        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%= artTitle %>">
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="<%= artDescription %>">
        </div>

        <div class="form-group">
            <label for="cost">Cost:</label>
            <input type="text" id="cost" name="cost" value="<%= artCost %>">
        </div>

        <div class="form-group">
            <label for="dimensions">Dimensions:</label>
            <input type="text" id="dimensions" name="dimensions" value="<%= artDimensions %>">
        </div>

        <div class="form-group">
            <label for="medium">Medium:</label>
            <input type="text" id="medium" name="medium" value="<%= artMedium %>">
        </div>

        <div class="form-group">
            <label for="availStatus">Availability Status:</label>
            <select id="availStatus" name="availStatus">
                <option value="InStock" <%= "InStock".equals(availStatus) ? "selected" : "" %>>In Stock</option>
                <option value="OutOfStock" <%= "OutOfStock".equals(availStatus) ? "selected" : "" %>>Out of Stock</option>
            </select>
        </div>

        <div class="form-group">
            <label for="sellerId">Seller ID:</label>
            <input type="text" id="sellerId" name="sellerId" value="<%= sellerId %>" readonly>
        </div>

        <div class="form-group">
            <label for="sellerName">Seller Name:</label>
            <input type="text" id="sellerName" name="sellerName" value="<%= sellerName %>" readonly>
        </div>

        <button type="submit">Save Changes</button>
    </form>
</div>

</body>
</html>
