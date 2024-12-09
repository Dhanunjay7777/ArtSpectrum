<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>
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
<html>
<head>
    <meta charset="UTF-8">
    <title>Update My Art</title>
    <link rel="stylesheet" href="css/updatemyart.css"/>
</head>
<body>
    <h2>Update My Art</h2>

    <%
        String encodedArtId = request.getParameter("artId");
        String encodedArtTitle = request.getParameter("artTitle");
        String encodedArtPrice = request.getParameter("artPrice");
        String encodedArtDimensions = request.getParameter("artDimensions");
        String encodedArtMedium = request.getParameter("artMedium");
        String encodedArtDescription = request.getParameter("artDescription");
        String encodedArtStatus = request.getParameter("artStatus");

        String artId = new String(Base64.getDecoder().decode(encodedArtId));
        String artTitle = new String(Base64.getDecoder().decode(encodedArtTitle));
        String artPrice = new String(Base64.getDecoder().decode(encodedArtPrice));
        String artDimensions = new String(Base64.getDecoder().decode(encodedArtDimensions));
        String artMedium = new String(Base64.getDecoder().decode(encodedArtMedium));
        String artDescription = new String(Base64.getDecoder().decode(encodedArtDescription));
        String artStatus = new String(Base64.getDecoder().decode(encodedArtStatus));
    %>

    <form action="updatemyart" method="post">
        <div>
            <label for="artId">Art ID:</label>
            <input type="text" id="artId" name="artId" value="<%= artId %>" readonly>
        </div>
        <div>
            <label for="artTitle">Art Title:</label>
            <input type="text" id="artTitle" name="artTitle" value="<%= artTitle %>">
        </div>
        <div>
            <label for="artPrice">Art Price:</label>
            <input type="text" id="artPrice" name="artPrice" value="<%= artPrice %>">
        </div>
        <div>
            <label for="artDimensions">Art Dimensions:</label>
            <input type="text" id="artDimensions" name="artDimensions" value="<%= artDimensions %>">
        </div>
        <div>
            <label for="artMedium">Art Medium:</label>
            <input type="text" id="artMedium" name="artMedium" value="<%= artMedium %>">
        </div>
        <div>
            <label for="artDescription">Art Description:</label>
            <textarea id="artDescription" name="artDescription"><%= artDescription %></textarea>
        </div>
        <div>
            <label for="artStatus">Art Status:</label>
            <select id="artStatus" name="artStatus">
                <option value="InStock" <%= "InStock".equals(artStatus) ? "selected" : "" %>>In Stock</option>
                <option value="OutOfStock" <%= "OutOfStock".equals(artStatus) ? "selected" : "" %>>Out Of Stock</option>
            </select>
        </div>
 
        <button type="submit" class="button update-button">Update Art</button>
    </form>
</body>
</html>
