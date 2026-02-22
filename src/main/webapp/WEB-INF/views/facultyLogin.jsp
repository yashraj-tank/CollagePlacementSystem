<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('images1/deim.jpeg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .login-container {
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            color: #fff;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 400px;
            animation: slideIn 0.5s ease-out;
        }
        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 3px;
            border-bottom: 2px solid rgba(255,255,255,0.3);
            padding-bottom: 15px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #f0f0f0;
        }
        input {
            width: 100%;
            padding: 12px 15px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            background-color: rgba(255,255,255,0.9);
            transition: all 0.3s;
        }
        input:focus {
            outline: none;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            background-color: #fff;
        }
        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
            background-color: #27ae60;
            color: white;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #229954;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .signup-link {
            text-align: center;
            margin-top: 25px;
        }
        .signup-link a {
            color: #FFD700;
            text-decoration: none;
            font-weight: bold;
        }
        .signup-link a:hover {
            text-decoration: underline;
        }
        .error-message {
            background-color: rgba(231, 76, 60, 0.2);
            border: 1px solid #e74c3c;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Faculty Login</h2>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/facultylogin" method="post">
            <div class="form-group">
                <label for="facultyEmail">Email</label>
                <input type="email" id="facultyEmail" name="facultyEmail" placeholder="faculty@college.edu" required>
            </div>

            <div class="form-group">
                <label for="fpassWord">Password</label>
                <input type="password" id="fpassWord" name="fpassWord" placeholder="Enter password" required>
            </div>

            <button type="submit" class="btn">Login</button>
        </form>

        <div class="signup-link">
            New faculty? <a href="${pageContext.request.contextPath}/facultysignup">Register here</a>
        </div>
    </div>
</body>
</html>