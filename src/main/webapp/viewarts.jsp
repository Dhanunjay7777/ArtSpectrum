<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="klu.model.Artreg" %>
<%@ include file="adminnav.jsp" %>
<%@ page import="klu.model.Consumer" %>
<%@ page import="java.util.Base64" %>

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Arts</title>
    <link rel="stylesheet" href="css/viewallarts.css">
</head>
<body>
        <%
            List<Artreg> artsList = (List<Artreg>) request.getAttribute("artsList");

            if (artsList != null && !artsList.isEmpty()) {
        %>
                <h1>All Artworks</h1>
                <div class="table-responsive">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Art ID</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Cost</th>
                                <th>Dimensions</th>
                                <th>Medium</th>
                                <th>Availability Status</th>
                                <th>Date Listed</th>
                                <th>Image</th>
                                <th>Seller ID</th>
                                <th>Seller Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                for (Artreg art : artsList) {
                    String artId = art.getArtid();
                    String title = art.getArttitle();
                    String description = art.getArtdescription();
                    String cost = art.getArtcost();
                    String dimensions = art.getArtdimensions();
                    String medium = art.getArtmedium();
                    String availStatus = art.getAvailstatus();
                    String dateListed = art.getDatelisted();
                    String imageUrl = art.getImageurl();
                    String sellerId = art.getSellerid();
                    String sellerName = art.getSellername();
                    
                    
                    String encodedArtId = Base64.getEncoder().encodeToString(artId.getBytes());
                    String encodedTitle = Base64.getEncoder().encodeToString(title.getBytes());
                    String encodedDescription = Base64.getEncoder().encodeToString(description.getBytes());
                    String encodedCost = Base64.getEncoder().encodeToString(cost.getBytes());
                    String encodedDimensions = Base64.getEncoder().encodeToString(dimensions.getBytes());
                    String encodedMedium = Base64.getEncoder().encodeToString(medium.getBytes());
                    String encodedAvailStatus = Base64.getEncoder().encodeToString(availStatus.getBytes());
                    String encodedSellerId = Base64.getEncoder().encodeToString(sellerId.getBytes());
                    String encodedSellerName = Base64.getEncoder().encodeToString(sellerName.getBytes());
        %>
        
        

                            <tr>
                                <td><%= artId %></td>
                                <td><%= title %></td>
                                <td><%= description %></td>
                                <td><%= cost %></td>
                                <td><%= dimensions %></td>
                                <td><%= medium %></td>
                                <td><%= availStatus %></td>
                                <td><%= dateListed %></td>
                                <td><img src="<%= imageUrl %>" alt="Artwork Image"></td>
                                <td><%= sellerId %></td>
                                <td><%= sellerName %></td>
                                <td>
<a href="updateallart?artId=<%= encodedArtId %>&title=<%= encodedTitle %>&description=<%= encodedDescription %>&cost=<%= encodedCost %>&dimensions=<%= encodedDimensions %>&medium=<%= encodedMedium %>&availStatus=<%= encodedAvailStatus %>&sellerId=<%= encodedSellerId %>&sellerName=<%= encodedSellerName %>" 
                                       class="button update-button">Update</a>                                    
                               <a href="#" class="button delete-button" onclick="openDeleteModal('<%= artId %>'); return false;">Delete</a>
                                </td>
                            </tr>
                            
                            
        <%
                }
        %>
                        </tbody>
                    </table>
                </div>
        <%
            } else {
        %>
                <div>
                    <p>No artworks found.</p>
                </div>
        <%
            }
        %>
    

    <script>
        function openDeleteModal(artId) {
            document.getElementById('artIdInput').value = artId;
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
    </script>

    <div id="deleteModal" class="modal" style="display:none;">
        <div class="modal-content">
            <h2>Confirm Deletion</h2>
            <p>Are you sure you want to delete this artwork?</p>
            <form id="deleteForm" action="deleteallart" method="POST">
                <input type="hidden" name="artId" id="artIdInput" value="">
                <button type="button" onclick="closeDeleteModal()">Cancel</button>
                <button type="submit">Confirm Delete</button>
            </form>
        </div>
    </div>
</body>
</html>
