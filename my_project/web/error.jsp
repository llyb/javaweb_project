<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Error</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      color: #333;
    }

    .container {
      max-width: 400px;
      margin: 50px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      color: #e44d26;
    }

    p {
      color: #333;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Error</h2>
  <p><strong>Oops! Something went wrong.</strong></p>

  <%
    String errorMessage = (String) request.getAttribute("errorMessage");
    System.out.println(errorMessage);
    if (errorMessage != null) {
  %>
  <p><%= errorMessage %></p>
  <%
  } else {
  %>
  <p>Sorry, an unexpected error occurred during your request.</p>
  <%
    }
  %>
  <p><a href="login.jsp">go back to login page</a></p>
</div>
</body>
</html>
