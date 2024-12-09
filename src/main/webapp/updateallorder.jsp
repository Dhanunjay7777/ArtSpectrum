<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Base64" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Orders</title>
    <link rel="stylesheet" href="css/updateallorder.css"> <!-- Link to your CSS file -->
</head>
<body>

    <%
        String encodedOrderId = request.getParameter("orderId");
        String encodedArtCost = request.getParameter("artCost");
        String encodedArtDimensions = request.getParameter("artDimensions");
        String encodedArtId = request.getParameter("artId");
        String artMedium = request.getParameter("artMedium");
        String artSeller = request.getParameter("artSeller");
        String artTitle = request.getParameter("artTitle");
        String encodedBuyerId = request.getParameter("buyerId");
        String encodedBuyerName = request.getParameter("buyerName");
        String orderStatus = request.getParameter("orderStatus");
        String shippingAddress = request.getParameter("shippingAddress");

        String orderId = new String(Base64.getDecoder().decode(encodedOrderId), "UTF-8");
        String artCost = new String(Base64.getDecoder().decode(encodedArtCost), "UTF-8");
        String artDimensions = new String(Base64.getDecoder().decode(encodedArtDimensions), "UTF-8");
        String artId = new String(Base64.getDecoder().decode(encodedArtId), "UTF-8");
        String buyerId = new String(Base64.getDecoder().decode(encodedBuyerId), "UTF-8");
        String buyerName = new String(Base64.getDecoder().decode(encodedBuyerName), "UTF-8");
        
        
    %>

    <form action="updateallorder" method="POST">
<h2 style="text-align: center; margin: 20px 0;">Update Order</h2>
    
        <label for="orderId">Order Id:</label>
        <input type="text" name="orderId" value="<%= orderId %>" readonly><br>

        <label for="artCost">Art Cost:</label>
        <input type="text" id="artCost" name="artCost" value="<%= artCost %>" required readonly><br>

        <label for="artDimensions">Art Dimensions:</label>
        <input type="text" id="artDimensions" name="artDimensions" value="<%= artDimensions %>" required readonly><br>

        <label for="artId">Art ID:</label>
        <input type="text" id="artId" name="artId" value="<%= artId %>" required readonly><br>

        <label for="artMedium">Art Medium:</label>
        <input type="text" id="artMedium" name="artMedium" value="<%= artMedium %>" required readonly><br>

        <label for="artSeller">Art Seller:</label>
        <input type="text" id="artSeller" name="artSeller" value="<%= artSeller %>" required readonly><br>

        <label for="artTitle">Art Title:</label>
        <input type="text" id="artTitle" name="artTitle" value="<%= artTitle %>" required readonly><br>

        <label for="buyerId">Buyer ID:</label>
        <input type="text" id="buyerId" name="buyerId" value="<%= buyerId %>" required readonly><br>

        <label for="buyerName">Buyer Name:</label>
        <input type="text" id="buyerName" name="buyerName" value="<%= buyerName %>" required readonly><br>

<label for="orderStatus">Order Status:</label>
<select id="orderStatus" name="orderStatus" required>
    <option value="Ordered" <%= "Ordered".equals(orderStatus) ? "selected" : "" %>>Ordered</option>
    <option value="Dispatched" <%= "Dispatched".equals(orderStatus) ? "selected" : "" %>>Dispatched</option> 
    <option value="Shipped" <%= "Shipped".equals(orderStatus) ? "selected" : "" %>>Shipped</option>
    <option value="Delivered" <%= "Delivered".equals(orderStatus) ? "selected" : "" %>>Delivered</option>
</select><br>


        <label for="shippingAddress">Shipping Address:</label>
        <input type="text" id="shippingAddress" name="shippingAddress" value="<%= shippingAddress %>" required><br>

        <button type="submit">Update Order</button>
    </form>
</body>
</html>
