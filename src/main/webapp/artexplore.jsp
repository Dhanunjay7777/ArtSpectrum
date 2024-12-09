<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="klu.model.Artreg" %>
<%@ page import="java.util.Base64" %>
<%@ include file="buyernav.jsp" %>
<%@ page import="klu.model.Consumer" %>
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Art Explore</title>
    <link rel="stylesheet" href="css/artexpo.css"/>
</head>
<body>
<%
    List<Artreg> artList = (List<Artreg>) request.getAttribute("artList");
int currentPage = (int) request.getAttribute("currentPage");
int totalPages = (int) request.getAttribute("totalPages");
%>
<% 
    if (artList != null && !artList.isEmpty()) {
        for (Artreg art : artList) {
%>
            <div class="card">
            <img src="<%= art.getImageurl() %>" alt="Art Image">
            
                <h2><%= art.getArttitle() %></h2>
                <p><strong>Description:</strong> <%= art.getArtdescription() %></p>
                <p class="cost">Cost: $<%= art.getArtcost() %></p>
                <p><strong>Medium:</strong> <%= art.getArtmedium() %></p>
                <p><strong>Dimensions:</strong> <%= art.getArtdimensions() %></p>
                <%
                    String stockStatus = art.getAvailstatus();
                    if ("OutOfStock".equalsIgnoreCase(stockStatus)) {
                %>
                    <div class="out-of-stock">Out of Stock</div>
                    <button class="buy-button disabled" disabled>Buy Now</button>
                <%
                    } else {
                        String encodedArtId = Base64.getEncoder().encodeToString(art.getArtid().getBytes("UTF-8"));
                        String encodedArtTitle = Base64.getEncoder().encodeToString(art.getArttitle().getBytes("UTF-8"));
                        String encodedArtCost = Base64.getEncoder().encodeToString(String.valueOf(art.getArtcost()).getBytes("UTF-8"));
                        String encodedArtDimensions = Base64.getEncoder().encodeToString(art.getArtdimensions().getBytes("UTF-8"));
                        String encodedArtMedium = Base64.getEncoder().encodeToString(art.getArtmedium().getBytes("UTF-8"));
                        String encodedSellerName = Base64.getEncoder().encodeToString(art.getSellername().getBytes("UTF-8"));
                        String encodedImageUrl = Base64.getEncoder().encodeToString(art.getImageurl().getBytes("UTF-8"));
                        String encodedSellerId = Base64.getEncoder().encodeToString(art.getSellerid().getBytes("UTF-8"));
                %>
                    <div class="in-stock">In Stock</div>
                    <a class="buy-button" href="<%= request.getContextPath() + "/shipping?artid=" + encodedArtId + 
                        "&arttitle=" + encodedArtTitle + 
                        "&artcost=" + encodedArtCost + 
                        "&artdimensions=" + encodedArtDimensions + 
                        "&artmedium=" + encodedArtMedium + 
                        "&sellername=" + encodedSellerName + 
                        "&sellerid="+encodedSellerId+
                        "&imageurl=" + encodedImageUrl %>">Buy Now</a>
                <%
                    }
                %>
            </div>
<%
        }
    } else {
%>
        <p>No art available.</p>
<%
    }
%>
<%-- <div class="pagination">
    <%
        String contextPath = request.getContextPath();
        if (currentPage > 1) { 
    %>
        <a class="pagination-link" href="<%= contextPath + "/artexplore?page=" + (currentPage - 1) %>">Previous</a>
    <% } %>
    <span>Page <%= currentPage %> of <%= totalPages %></span>
    <%
        if (currentPage < totalPages) {
    %>
        <a class="pagination-link" href="<%= contextPath + "/artexplore?page=" + (currentPage + 1) %>">Next</a>
    <% } %> --%>
    
   
    <!-- Dropdown for selecting a specific page -->
    <%-- <form action="<%= contextPath + "/artexplore" %>" method="get" style="display: inline-block;">
        <label for="page" style="margin-left: 10px;">Go to:</label>
        <select name="page" id="page" onchange="this.form.submit()">
            <%
                for (int i = 1; i <= totalPages; i++) {
            %>
                <option value="<%= i %>" <%= i == currentPage ? "selected" : "" %>>
                    <%= i %>
                </option>
            <%
                }
            %>
        </select>
    </form> --%>
</div>

<div class="pagination">
    <%
        String contextPath = request.getContextPath();
        int pagesPerBlock = 4; // Number of page numbers to show in a block
        int startPage = ((currentPage - 1) / pagesPerBlock) * pagesPerBlock + 1; // Starting page of the current block
        int endPage = Math.min(startPage + pagesPerBlock - 1, totalPages); // Ending page of the current block
    %>

    <!-- Previous Block Button -->
    <%
        if (startPage > 1) {
    %>
        <a class="pagination-link" href="<%= contextPath + "/artexplore?page=" + (startPage - 1) %>">Previous</a>
    <% } %>
    <span>Page <%= currentPage %> of <%= totalPages %></span>

    <!-- Page Number Links -->
    <%
        for (int i = startPage; i <= endPage; i++) {
    %>
        <a class="pagination-link" href="<%= contextPath + "/artexplore?page=" + i %>" <%= (i == currentPage) ? "style='background-color:#007BFF;color:#fff;'" : "" %>><%= i %></a>
    <% } %>

    <!-- Next Block Button -->
    <%
        if (endPage < totalPages) {
    %>
        <a class="pagination-link" href="<%= contextPath + "/artexplore?page=" + (endPage + 1) %>">Next</a>
    <% } %>

</div> 


</body>
</html>
