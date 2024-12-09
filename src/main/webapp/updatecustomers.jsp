<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
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
<%@ include file="adminnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Customers</title>
    <link rel="stylesheet" href="css/updatecustomer.css"/>
</head>
<body>
    <%
        String encodedUserId = request.getParameter("userid");
        String encodedEmail = request.getParameter("email");
        String encodedName = request.getParameter("name");
        String encodedGender = request.getParameter("gender");
        String encodedContactNo = request.getParameter("contactNo");
        String encodedAddress = request.getParameter("address");
        String encodedDob = request.getParameter("dob");
        String encodedUserRole = request.getParameter("userRole");
        String encodedArtPreference = request.getParameter("artPreference");
        String encodedNewsletter = request.getParameter("newsletter");

        String userId = new String(Base64.getDecoder().decode(encodedUserId), StandardCharsets.UTF_8);
        String email = new String(Base64.getDecoder().decode(encodedEmail), StandardCharsets.UTF_8);
        String name = new String(Base64.getDecoder().decode(encodedName), StandardCharsets.UTF_8);
        String gender = new String(Base64.getDecoder().decode(encodedGender), StandardCharsets.UTF_8);
        String contactNo = new String(Base64.getDecoder().decode(encodedContactNo), StandardCharsets.UTF_8);
        String address = new String(Base64.getDecoder().decode(encodedAddress), StandardCharsets.UTF_8);
        String dob = new String(Base64.getDecoder().decode(encodedDob), StandardCharsets.UTF_8);
        String userRole = new String(Base64.getDecoder().decode(encodedUserRole), StandardCharsets.UTF_8);
        String artPreference = new String(Base64.getDecoder().decode(encodedArtPreference), StandardCharsets.UTF_8);
        String newsletter = new String(Base64.getDecoder().decode(encodedNewsletter), StandardCharsets.UTF_8);
    %>

    <div class="form-container">
        <h2>Update Customer</h2>
        <form action="updatecustomers" method="POST">
            <label for="userId">User ID:</label>
            <input type="text" id="userId" name="userId" value="<%= userId %>" readonly>

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= name %>" required>

            <label for="email">Email:</label>
            <input type="text" id="email" name="email" value="<%= email %>" readonly>

            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="" disabled>Select Gender</option>
                <option value="male" <%= gender.equals("male") ? "selected" : "" %>>Male</option>
                <option value="female" <%= gender.equals("female") ? "selected" : "" %>>Female</option>
                <option value="prefernot_tosay" <%= gender.equals("prefernot_tosay") ? "selected" : "" %>>Prefer not to say</option>
            </select>

            <label for="contactNo">Contact No:</label>
            <input type="tel" id="contactno" name="contactno" value="<%= contactNo %>" required>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= address %>" required>

            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" value="<%= dob %>" required>

            <label for="userRole">User Role:</label>
            <select id="userRole" name="userRole" required>
                <option value="" disabled>Select User Role</option>
                <option value="admin" <%= userRole.equals("admin") ? "selected" : "" %>>Admin</option>
                <option value="buyer" <%= userRole.equals("buyer") ? "selected" : "" %>>Buyer</option>
                <option value="seller" <%= userRole.equals("seller") ? "selected" : "" %>>Seller</option>
            </select>

            <label for="artPreference">Art Style Preference:</label>
            <select id="artPreference" name="artPreference" required>
                <option value="" disabled>Select Art Style</option>
                <option value="abstract" <%= artPreference.equals("abstract") ? "selected" : "" %>>Abstract</option>
                <option value="realism" <%= artPreference.equals("realism") ? "selected" : "" %>>Realism</option>
                <option value="impressionism" <%= artPreference.equals("impressionism") ? "selected" : "" %>>Impressionism</option>
                <option value="modern" <%= artPreference.equals("modern") ? "selected" : "" %>>Modern</option>
                <option value="contemporary" <%= artPreference.equals("contemporary") ? "selected" : "" %>>Contemporary</option>
            </select>

            <label for="newsletter">Newsletter Subscription:</label>
            <select id="newsletter" name="newsletter" required>
                <option value="" disabled>Select Subscription</option>
                <option value="yes" <%= newsletter.equals("yes") ? "selected" : "" %>>Yes</option>
                <option value="no" <%= newsletter.equals("no") ? "selected" : "" %>>No</option>
            </select>

            <button type="submit">Update Customer</button>
        </form>
    </div>

</body>
</html>
