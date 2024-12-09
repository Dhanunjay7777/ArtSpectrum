<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Base64" %>
<%@ include file="sellernav.jsp" %>
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
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Order</title>
    <link rel="stylesheet" href="css/updateorder.css"/> 
</head>
<body>

<%
    String encodedOrderId = request.getParameter("orderid");
    String encodedOrderStatus = request.getParameter("orderstatus");

    String orderId = "";
    String orderStatus = "";

    if (encodedOrderId != null) {
        byte[] decodedOrderIdBytes = Base64.getDecoder().decode(encodedOrderId);
        orderId = new String(decodedOrderIdBytes, "UTF-8");
    }

    if (encodedOrderStatus != null) {
        byte[] decodedOrderStatusBytes = Base64.getDecoder().decode(encodedOrderStatus);
        orderStatus = new String(decodedOrderStatusBytes, "UTF-8");
    }
%>


<div class="updateform-container">
<h1 style=" text-align:center;">Update Order</h1>

    <form action="updateorder" method="post">
        <label for="orderid">Order ID:</label>
        <input type="text" id="orderid" name="orderid" value="<%= orderId.replaceFirst("%23", "#") %>" readonly><br><br>

        <label for="orderstatus">Order Status:</label>
        <select id="orderstatus" name="orderstatus">
            <option value="Dispatched" <%= "Ordered".equals(orderStatus) ? "selected" : "" %>>Dispatched</option> 
            <option value="Shipped" <%= "Shipped".equals(orderStatus) ? "selected" : "" %>>Shipped</option>
            <option value="Delivered" <%= "Delivered".equals(orderStatus) ? "selected" : "" %>>Delivered</option>
        </select><br><br>
        <button type="submit">Update Order</button>
    </form>
</div>

</body>
</html>
