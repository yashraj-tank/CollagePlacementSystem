<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('images1/deim.jpeg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-form {
            background-color: #3498db;
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 400px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .login-form h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .login-form label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #f0f0f0;
        }

        .login-form input[type="email"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .login-form button {
            background-color: #2980b9;
            color: white;
            border: none;
            padding: 15px 20px;
            margin-top: 25px;
            width: 100%;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-form button:hover {
            background-color: #1f618d;
        }

        .signup-link {
            text-align: center;
            margin-top: 20px;
            font-size: 15px;
        }

        .signup-link a {
            color: #fff;
            text-decoration: underline;
            font-weight: bold;
        }

        .signup-link a:hover {
            color: #f0f0f0;
        }

        .error-message {
            background-color: rgba(231, 76, 60, 0.2);
            border: 1px solid #e74c3c;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        @media (max-width: 480px) {
            .login-form {
                padding: 20px;
            }
			.success-message {
			    background-color: #27ae60;
			    color: white;
			    padding: 10px;
			    border-radius: 5px;
			    margin-bottom: 20px;
			    text-align: center;
			}
        }
    </style>
</head>
<body>
    <div class="login-form">
        <h2>Student Login</h2>
        
        <c:if test="${not empty success}">
    		<div class="success-message">${success}</div>
		</c:if>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <!-- Login form -->
        <form action="${pageContext.request.contextPath}/studentlogin" method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <button type="submit">Log In</button>
        </form>

        <!-- Link to Sign Up page -->
        <div class="signup-link">
            Don't have an account? <a href="${pageContext.request.contextPath}/studentsingup">Sign up here</a>
        </div>
        <div class="signup-link">
            For Get PassWord? <a href="${pageContext.request.contextPath}/studentforgetpassword">Click here</a>
        </div>
    </div>
</body>
</html>