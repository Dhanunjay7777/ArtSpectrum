<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="klu.model.Consumer" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
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

    // Decoding Base64 encoded parameters
    String artId = new String(Base64.getDecoder().decode(request.getParameter("artid")), StandardCharsets.UTF_8);
    String artTitle = new String(Base64.getDecoder().decode(request.getParameter("arttitle")), StandardCharsets.UTF_8);
    String artCost = new String(Base64.getDecoder().decode(request.getParameter("artcost")), StandardCharsets.UTF_8);
    String artDimensions = new String(Base64.getDecoder().decode(request.getParameter("artdimensions")), StandardCharsets.UTF_8);
    String artMedium = new String(Base64.getDecoder().decode(request.getParameter("artmedium")), StandardCharsets.UTF_8);
    String sellerName = new String(Base64.getDecoder().decode(request.getParameter("sellername")), StandardCharsets.UTF_8);
    String sellerId = new String(Base64.getDecoder().decode(request.getParameter("sellerid")), StandardCharsets.UTF_8);
    String imageUrl = new String(Base64.getDecoder().decode(request.getParameter("imageurl")), StandardCharsets.UTF_8);
%>
<%@ include file="buyernav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="css/shipping.css"/> 
</head>
<body>
    <h2>This is the shipping page</h2>

    <form action="shipping" method="post">
        <div>
            <label for="artid">Art ID:</label>
            <input type="text" id="artid" name="artid" value="<%= artId %>" readonly>
        </div>

        <div>
            <label for="arttitle">Art Title:</label>
            <input type="text" id="arttitle" name="arttitle" value="<%= artTitle %>" readonly>
        </div>

        <div>
            <label for="artmedium">Art Medium:</label>
            <input type="text" id="artmedium" name="artmedium" value="<%= artMedium %>" readonly>
        </div>

        <div>
            <label for="artdimensions">Art Dimensions:</label>
            <input type="text" id="artdimensions" name="artdimensions" value="<%= artDimensions %>" readonly>
        </div>

        <div>
            <label for="artcost">Art Cost:</label>
            <input type="text" id="artcost" name="artcost" value="<%= artCost %>" readonly>
        </div>
        
        <div>
            <input type="hidden" id="artimage" name="artimage" value="<%= imageUrl %>" readonly>
        </div>
        
        <div>
            <label for="artseller">Seller Name:</label>
            <input type="text" id="artseller" name="artseller" value="<%= sellerName %>" readonly>
        </div>
        
         <div>
            <input type="hidden" id="sellerid" name="sellerid" value="<%= sellerId %>" readonly>
        </div>

        <div>
            <label for="shippingaddress">Shipping Address:</label>
            <textarea id="shippingaddress" name="shippingaddress" required></textarea>
        </div>

        <div>
            <button type="submit">Confirm</button>
        </div>
    </form>
</body>
</html>
