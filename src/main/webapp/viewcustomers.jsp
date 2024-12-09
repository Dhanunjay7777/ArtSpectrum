<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="klu.model.Consumer" %>
<%@ page import="java.util.Base64" %>
<%@ include file="adminnav.jsp" %>
<%@ page import="klu.model.Consumer" %>
<%
    Consumer cons = (Consumer) session.getAttribute("cms");
    if (cons == null) {
        response.sendRedirect("sessionexpiry.html");
        return; 
    }
    if (!"admin".equals(cons.getUserRole())) {
        response.sendRedirect("forbidden.html"); // Redirect to forbidden page
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Consumers</title>
    <link rel="stylesheet" href="css/viewcustomer.css">
</head>
<body>
    
    <c:if test="${not empty param.message}">
        <div style="color: #990000; font-weight: bold; text-align: center; margin-top: 20px;">
            ${param.message}
        </div>
    </c:if>
<h2 style="text-align:center">My Consumers</h2>
    <%
        List<Consumer> customerList = (List<Consumer>) request.getAttribute("customerList");

        if (customerList != null && !customerList.isEmpty()) {
    %>
            <table class="details-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Gender</th>
                        <th>Contact No</th>
                        <th>Address</th>
                        <th>Date of Birth</th>
                        <th>User Role</th>
                        <th>Art Preference</th>
                        <th>Newsletter</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
    <%
            for (Consumer consumer : customerList) {
                String userId = String.valueOf(consumer.getUserid());
                String email = consumer.getEmail();
                String name = consumer.getName();
                String gender = consumer.getGender();
                String contactNo = consumer.getContactno();
                String address = consumer.getAddress();
                String dob = consumer.getDateOfBirth();
                String userRole = consumer.getUserRole();
                String artPreference = consumer.getArtPreference();
                String newsletter = consumer.getNewsletter();

                String encodedUserId = Base64.getEncoder().encodeToString(userId.getBytes());
                String encodedEmail = Base64.getEncoder().encodeToString(email.getBytes());
                String encodedName = Base64.getEncoder().encodeToString(name.getBytes());
                String encodedGender = Base64.getEncoder().encodeToString(gender.getBytes());
                String encodedContactNo = Base64.getEncoder().encodeToString(contactNo.getBytes());
                String encodedAddress = Base64.getEncoder().encodeToString(address.getBytes());
                String encodedDob = Base64.getEncoder().encodeToString(dob.getBytes());
                String encodedUserRole = Base64.getEncoder().encodeToString(userRole.getBytes());
                String encodedArtPreference = Base64.getEncoder().encodeToString(artPreference.getBytes());
                String encodedNewsletter = Base64.getEncoder().encodeToString(newsletter.getBytes());
    %>
                    <tr>
                        <td><%= name %></td>
                        <td><%= email %></td>
                        <td><%= gender %></td>
                        <td><%= contactNo %></td>
                        <td><%= address %></td>
                        <td><%= dob %></td>
                        <td><%= userRole %></td>
                        <td><%= artPreference %></td>
                        <td><%= newsletter %></td>
                        <td>
                            <a href="updatecustomers?userid=<%= encodedUserId %>&email=<%= encodedEmail %>&name=<%= encodedName %>&gender=<%= encodedGender %>&contactNo=<%= encodedContactNo %>&address=<%= encodedAddress %>&dob=<%= encodedDob %>&userRole=<%= encodedUserRole %>&artPreference=<%= encodedArtPreference %>&newsletter=<%= encodedNewsletter %>" class="button update-button">Update</a>
                            <a href="" class="button delete-button" onclick="openDeleteModal('<%= userId %>'); return false;">Delete</a>
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
            <div class="consumer-details">
                <p>No consumers found.</p>
            </div>
    <%
        }
    %>

    <script>
        function openDeleteModal(encodedUserId) {
            document.getElementById('userIdInput').value = encodedUserId;
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
        
    </script>

    <div id="deleteModal" class="modal" style="display:none;">
        <div class="modal-content">
            <h2>Confirm Deletion</h2>
            <p>Are you sure you want to delete this consumer?</p>
            <form id="deleteForm" action="deletecustomer" method="POST">
                <input type="hidden" name="userId" id="userIdInput" value="">
                <button type="button" onclick="closeDeleteModal()">Cancel</button>
                <button type="submit">Confirm Delete</button>
            </form>
        </div>
    </div>

</body>
</html>
