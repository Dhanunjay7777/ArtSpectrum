<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>
<%@ page import="klu.model.Consumer" %>
<%@ include file="buyernav.jsp" %>

<%
    // Check if the user is logged in and is a buyer
    Consumer consumer = (Consumer) session.getAttribute("cms");
    if (consumer == null) {
        response.sendRedirect("sessionexpiry.html");
        return; 
    }
    if (!"buyer".equals(consumer.getUserRole())) {
        response.sendRedirect("forbidden.html"); // Redirect to forbidden page
        return;
    }

    // Retrieve the parameters from the URL
    String artseller = new String(Base64.getDecoder().decode(request.getParameter("artseller")), StandardCharsets.UTF_8);
    String artid = new String(Base64.getDecoder().decode(request.getParameter("artid")), StandardCharsets.UTF_8);
    String orderid = new String(Base64.getDecoder().decode(request.getParameter("orderid")), StandardCharsets.UTF_8);
    String shippingaddress = new String(Base64.getDecoder().decode(request.getParameter("shippingaddress")), StandardCharsets.UTF_8);
    String artcost = new String(Base64.getDecoder().decode(request.getParameter("artcost")), StandardCharsets.UTF_8);
    String orderstatus = new String(Base64.getDecoder().decode(request.getParameter("orderstatus")), StandardCharsets.UTF_8);
    String arttitle = new String(Base64.getDecoder().decode(request.getParameter("arttitle")), StandardCharsets.UTF_8);
    String artdimensions = new String(Base64.getDecoder().decode(request.getParameter("artdimensions")), StandardCharsets.UTF_8);
    String artimage = new String(Base64.getDecoder().decode(request.getParameter("artimage")), StandardCharsets.UTF_8);

    // UPI payment details
    String payeeVPA = "dhanunjayp4@oksbi"; // Replace with seller's actual UPI ID
    String payeeName = artseller; // Seller's name
    String amount = artcost; // Payment amount
    String currency = "INR"; // Currency
    String transactionNote = "Payment for " + arttitle; // Transaction note

    // UPI payment URL
    String upiString = String.format(
        "upi://pay?pa=%s&pn=%s&am=%s&cu=%s&tn=%s", 
        payeeVPA, payeeName, amount, currency, transactionNote
    );

    // Generate the QR Code for the UPI link
    QRCodeWriter qrCodeWriter = new QRCodeWriter();
    ByteArrayOutputStream qrStream = new ByteArrayOutputStream();
    try {
        var qrMatrix = qrCodeWriter.encode(upiString, BarcodeFormat.QR_CODE, 200, 200);
        MatrixToImageWriter.writeToStream(qrMatrix, "PNG", qrStream);
    } catch (Exception e) {
        e.printStackTrace();
    }
    String qrBase64 = Base64.getEncoder().encodeToString(qrStream.toByteArray());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment</title>
    <link rel="stylesheet" href="css/qrpage.css">
    
</head>
<body>

<div class="container">
<div class="qr-container">

<h2>Payment Page</h2>
<h3>Scan the QR Code to pay:</h3>
<img src="data:image/png;base64,<%= qrBase64 %>" alt="QR Code">
</div>
    
   <div class="payment-details">

<h3>Payment Details:</h3>
<ul>
    <li><b>Art Seller:</b> <%= artseller %></li>
    <li><b>Art ID:</b> <%= artid %></li>
    <li><b>Order ID:</b> <%= orderid.replaceFirst("%23", "#") %></li>
    <li><b>Shipping Address:</b> <%= shippingaddress %></li>
    <li><b>Art Cost:</b> ₹<%= artcost %></li>
    <li><b>Order Status:</b> <%= orderstatus %></li>
    <li><b>Art Title:</b> <%= arttitle %></li>
    <li><b>Art Dimensions:</b> <%= artdimensions %></li>
    <li><b>Art Image:</b></li>
    <img src="<%= artimage %>" alt="Art Image" style="width:200px;height:auto;">
</ul>


<!-- Hidden form to send details to paysuccess.jsp -->
<form action="paysuccess" method="post">
    <input type="hidden" name="artseller" value="<%= artseller %>">
    <input type="hidden" name="artid" value="<%= artid %>">
    <input type="hidden" name="orderid" value="<%= orderid %>">
    <input type="hidden" name="shippingaddress" value="<%= shippingaddress %>">
    <input type="hidden" name="artcost" value="<%= artcost %>">
    <input type="hidden" name="orderstatus" value="<%= orderstatus %>">
    <input type="hidden" name="arttitle" value="<%= arttitle %>">
    <input type="hidden" name="artdimensions" value="<%= artdimensions %>">
    <input type="hidden" name="artimage" value="<%= artimage %>">
    <input type="hidden" name="paystatus" value="paid">
    
    <button type="submit">Pay</button>
</form>
</div>
</div>
</body>
</html>
