<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="klu.model.Shipping" %>
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
    <title>View Orders</title>
    <link rel="stylesheet" href="css/vieworders.css"/> 
</head>
<body>

 
<div class="container">
    <c:if test="${not empty param.error}">
        <div style="color: #990000; font-weight: bold; text-align: center; margin-top: 20px;">
            ${param.error}
        </div>
    </c:if>
    <div class="order-table">
        <%
            List<Shipping> shipviewList = (List<Shipping>) request.getAttribute("shipviewList");
            if (shipviewList != null && !shipviewList.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Art Cost</th>
                        <th>Art Dimensions</th>
                        <th>Art ID</th>
                        <th>Art Image</th>
                        <th>Art Medium</th>
                        <th>Art Seller</th>
                        <th>Art Title</th>
                        <th>Buyer ID</th>
                        <th>Buyer Name</th>
                        <th>Order Status</th>
                        <th>Shipping Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Shipping shipping : shipviewList) {
                            String statusColor = "";
                            if ("Canceled".equals(shipping.getOrderstatus())) {
                                statusColor = "red";
                            } else if ("Ordered".equals(shipping.getOrderstatus())) {
                                statusColor = "green";
                             
                            }else if ("Shipped".equals(shipping.getOrderstatus())) {
                                statusColor = "darkblue";
                            }else if ("Delivered".equals(shipping.getOrderstatus())) {
                                statusColor = "blue";
                            }

                            // Encode orderid and orderstatus in Base64
                            String encodedOrderId = Base64.getEncoder().encodeToString(shipping.getOrderid().getBytes("UTF-8"));
                            String encodedOrderStatus = Base64.getEncoder().encodeToString(shipping.getOrderstatus().getBytes("UTF-8"));
                    %>
                        <tr>
                            <td><%= shipping.getOrderid().replaceFirst("%23", "#") %></td>
                            <td><%= shipping.getArtcost() %></td>
                            <td><%= shipping.getArtdimensions() %></td>
                            <td><%= shipping.getArtid() %></td>
                            <td><img src="<%= shipping.getArtimage() %>" alt="<%= shipping.getArttitle() %>" style="width:100px;height:auto;"/></td>
                            <td><%= shipping.getArtmedium() %></td>
                            <td><%= shipping.getArtseller() %></td>
                            <td><%= shipping.getArttitle() %></td>
                            <td><%= shipping.getBuyerid() %></td>
                            <td><%= shipping.getBuyername() %></td>
                            <td style="color: <%= statusColor %>;"><%= shipping.getOrderstatus() %></td>
                            <td><%= shipping.getShippingaddress() %></td>
                            <td>
                                <a href="updateorder?orderid=<%= encodedOrderId %>&orderstatus=<%= encodedOrderStatus %>" 
                                   class="btn-update" 
                               <%= ("Canceled".equals(shipping.getOrderstatus()) || "Delivered".equals(shipping.getOrderstatus())) ? "style='pointer-events: none; opacity: 0.5;'" : "" %>>
                                   Update
                                </a>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <p>No orders found.</p>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
