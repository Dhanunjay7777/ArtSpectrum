<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="buyernav.jsp" %>
<%@ page import="klu.model.Consumer" %>
<%@ page import="java.util.Base64" %>
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

    String decodedSeller = new String(Base64.getDecoder().decode(request.getParameter("artseller")), "UTF-8");
    String decodedArtId = new String(Base64.getDecoder().decode(request.getParameter("artid")), "UTF-8");
    String decodedOrderId = new String(Base64.getDecoder().decode(request.getParameter("orderid")), "UTF-8");
    String decodedShippingAddress = new String(Base64.getDecoder().decode(request.getParameter("shippingaddress")), "UTF-8");
    String decodedArtCost = new String(Base64.getDecoder().decode(request.getParameter("artcost")), "UTF-8");
    String decodedOrderStatus = new String(Base64.getDecoder().decode(request.getParameter("orderstatus")), "UTF-8");
    String decodedArtTitle = new String(Base64.getDecoder().decode(request.getParameter("arttitle")), "UTF-8");
    String decodedArtDimensions = new String(Base64.getDecoder().decode(request.getParameter("artdimensions")), "UTF-8");
    String decodedArtImage = new String(Base64.getDecoder().decode(request.getParameter("artimage")), "UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="css/ordersuccess.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>
<body>
<div class="invoice">
    <div class="invoice-header">
        <h1>Order Invoice</h1>
        <p>Thank you for your purchase!</p>
    </div>

    <div class="invoice-details">
        <div class="details-left">
            <div>Seller Name: <%= decodedSeller %></div>
            <div>Art ID: <%= decodedArtId %></div>
            <div>Order ID: <%= decodedOrderId.replaceFirst("%23", "#") %></div>
            <div>Shipping Address: <%= decodedShippingAddress %></div>
            <div>Art Cost: <span class="total">$<%= decodedArtCost %></span></div>
            <div class="order-status">Order Status: <%= decodedOrderStatus %></div>
            <div>Art Title: <%= decodedArtTitle %></div>
            <div>Art Dimensions: <%= decodedArtDimensions %></div>
        </div>
        <div>
            <img src="<%= decodedArtImage %>" alt="Art Image" class="art-image">
        </div>
    </div>

    <div class="footer">
        <p>This invoice was generated automatically. Please retain it for your records.</p>
    </div>

    <div class="download-button">
        <button onclick="downloadReceipt()">Download Receipt</button>
    </div>
</div>

<script>
    function downloadReceipt() {
        const { jsPDF } = window.jspdf;

        const doc = new jsPDF();

        const margin = 10;
        const imageWidth = 50;
        const imageHeight = 50;
        const textStartY = 30;

        const artImage = "<%= decodedArtImage %>"; // The URL of the art image

        // Fetch the image as base64 using fetch API
        fetch(artImage)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to load image');
                }
                return response.blob();
            })
            .then(blob => {
                const reader = new FileReader();
                reader.onloadend = function () {
                    const base64Image = reader.result.split(',')[1]; // Extract base64 part from URL

                    doc.setLineWidth(0.5);
                    doc.setDrawColor(0, 0, 0); 
                    doc.rect(margin, margin, 190, 270); 

                    doc.setFillColor(230, 230, 250); 
                    doc.rect(margin, margin, 190, 20, 'F'); 
                    doc.setFontSize(18);
                    doc.setTextColor(70, 130, 180); 
                    doc.text("Order Receipt", margin + 70, margin + 15);

                    doc.addImage(base64Image, 'JPEG', margin + 70, margin + 30, imageWidth, imageHeight); // Centered image

                    doc.setFontSize(12);
                    doc.setTextColor(0, 0, 0); 

                    doc.setFontSize(14);
                    doc.text("Order Details", margin + 10, textStartY + 60);
                    doc.setFontSize(12);
                    doc.text(`Order ID: <%= decodedOrderId.replaceFirst("%23", "#") %>`, margin + 10, textStartY + 70);
                    doc.text(`Seller Name: <%= decodedSeller %>`, margin + 10, textStartY + 80);
                    doc.text(`Art ID: <%= decodedArtId %>`, margin + 10, textStartY + 90);
                    doc.text(`Art Title: <%= decodedArtTitle %>`, margin + 10, textStartY + 100);
                    doc.text(`Art Dimensions: <%= decodedArtDimensions %>`, margin + 10, textStartY + 110);
                    doc.text(`Art Cost: $<%= decodedArtCost %>`, margin + 10, textStartY + 120);
                    doc.text(`Order Status: <%= decodedOrderStatus %>`, margin + 10, textStartY + 130);

                    doc.setFontSize(14);
                    doc.text("Shipping Information", margin + 10, textStartY + 150);
                    doc.setFontSize(12);
                    doc.text(`Shipping Address: <%= decodedShippingAddress %>`, margin + 10, textStartY + 160);

                    doc.setFillColor(230, 230, 250); 
                    doc.rect(margin, 270, 190, 10, 'F'); 
                    doc.setTextColor(70, 130, 180); 
                    doc.setFontSize(10);
                    doc.text("Thank you for your purchase!", margin + 70, 275);

                    doc.save('receipt.pdf');
                };
                reader.readAsDataURL(blob); // Convert image to base64
            })
            .catch(error => {
                console.error('Error fetching the image:', error);
                alert("Error downloading the image. Please try again.");
            });
    }
</script>

</body>
</html>
