<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="klu.model.Artreg" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Responsive meta tag -->
    <title>My Arts</title>
    <link rel="stylesheet" href="css/myarts.css">
</head>
<body>
            <%
                List<Artreg> artsList = (List<Artreg>) request.getAttribute("artsList");

                if (artsList != null && !artsList.isEmpty()) {
                    for (Artreg art : artsList) {
                        String artId = art.getArtid();
                        String artTitle = art.getArttitle();
                        String artPrice = art.getArtcost();
                        String artDimensions = art.getArtdimensions();
                        String artMedium = art.getArtmedium();
                        String artDescription = art.getArtdescription();
                        String artStatus = art.getAvailstatus();
                        String dateListed = art.getDatelisted();
                        String artImage = art.getImageurl();

                        // Encode the parameters using Base64
                        String encodedArtId = Base64.getEncoder().encodeToString(artId.getBytes());
                        String encodedArtTitle = Base64.getEncoder().encodeToString(artTitle.getBytes());
                        String encodedArtPrice = Base64.getEncoder().encodeToString(artPrice.getBytes());
                        String encodedArtDimensions = Base64.getEncoder().encodeToString(artDimensions.getBytes());
                        String encodedArtMedium = Base64.getEncoder().encodeToString(artMedium.getBytes());
                        String encodedArtDescription = Base64.getEncoder().encodeToString(artDescription.getBytes());
                        String encodedArtStatus = Base64.getEncoder().encodeToString(artStatus.getBytes());
            %>
                <div class="card">
                    <div class="card-image">
                        <img src="<%= artImage %>" alt="<%= artTitle %>"/>
                    </div>
                    <div class="card-details">
                        <h3><%= artTitle %></h3>
                        <p><strong>Price:</strong> <%= artPrice %></p>
                        <p><strong>Dimensions:</strong> <%= artDimensions %></p>
                        <p><strong>Medium:</strong> <%= artMedium %></p>
                        <p><strong>Description:</strong> <%= artDescription %></p>
                        <p><strong>Status:</strong> <%= artStatus %></p>
                        <p><strong>Date Listed:</strong> <%= dateListed %></p>
                        <div class="card-actions">
                            <a href="updatemyart?artId=<%= encodedArtId %>&artTitle=<%= encodedArtTitle %>&artPrice=<%= encodedArtPrice %>&artDimensions=<%= encodedArtDimensions %>&artMedium=<%= encodedArtMedium %>&artDescription=<%= encodedArtDescription %>&artStatus=<%= encodedArtStatus %>" class="button update-button">Update</a>
<a href="#" class="button delete-button" onclick="openDeleteModal('<%= artId %>'); return false;">Delete</a>

<div id="deleteModal" class="modal" style="display:none;">
    <div class="modal-content">
        <h2>Confirm Deletion</h2>
        <p>Are you sure you want to delete this art?</p>
        <form id="deleteForm" action="deletemyart" method="POST">
            <input type="hidden" name="artId" id="artIdInput" value="">
            <button type="button" onclick="closeDeleteModal()">Cancel</button>
            <button type="submit">Confirm Delete</button>
        </form>
    </div>
</div>

                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="no-arts">
                    <p>No arts found.</p>
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
</body>
</html>
