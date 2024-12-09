<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ART FAILURE</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .card {
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        text-align: center;
        max-width: 400px;
        margin: 20px;
    }

    h2 {
        color: #d9534f;
    }

    p {
        color: #555;
    }

    .retry-button {
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #d9534f;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
    }

    .retry-button:hover {
        background-color: #c9302c;
    }
</style>
</head>
<body>

<div class="card"> // here in this file keep session check code
    <h2>Art Failure</h2>
    <p>Adding the Art failed due to a technical issue. Please try again after some time.</p>
    <a href="sellartreg" class="retry-button">Try Again</a>
</div>

</body>
</html>
