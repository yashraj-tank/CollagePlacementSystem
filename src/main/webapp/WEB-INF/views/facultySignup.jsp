<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Registration</title>
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
        .form-container {
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            color: #fff;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 500px;
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
            position: relative;
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
        input, select {
            width: 100%;
            padding: 12px 15px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            background-color: rgba(255,255,255,0.9);
            transition: all 0.3s;
        }
        input:focus, select:focus {
            outline: none;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            background-color: #fff;
        }
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 42px;
            cursor: pointer;
            background: rgba(255,255,255,0.9);
            padding: 2px 8px;
            border-radius: 4px;
            color: #666;
        }
        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 35px;
        }
        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-primary {
            background-color: #27ae60;
            color: white;
        }
        .btn-primary:hover {
            background-color: #229954;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .btn-secondary {
            background-color: #e74c3c;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .login-link {
            text-align: center;
            margin-top: 25px;
        }
        .login-link a {
            color: #FFD700;
            text-decoration: none;
            font-weight: bold;
        }
        .login-link a:hover {
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
        .success-message {
            background-color: rgba(39, 174, 96, 0.2);
            border: 1px solid #27ae60;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        @media (max-width: 480px) {
            .form-container { padding: 25px 20px; }
            .btn-container { flex-direction: column; }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Faculty Registration</h2>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/savefaculty" method="post" id="facultyForm">
            <div class="form-group">
                <label for="facultyName">Full Name</label>
                <input type="text" id="facultyName" name="facultyName" placeholder="Enter faculty name" required>
            </div>

            <div class="form-group">
                <label for="facultyEmail">Email</label>
                <input type="email" id="facultyEmail" name="facultyEmail" placeholder="faculty@college.edu" required>
            </div>

            <div class="form-group">
                <label for="branch">Branch</label>
                <select id="branch" name="branch" required>
                    <option value="">-- Select Branch --</option>
                    <c:forEach var="branchItem" items="${branchList}">
                        <option value="${branchItem.branchName}">${branchItem.branchName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="fpassWord">Password</label>
                <input type="password" id="fpassWord" name="fpassWord" placeholder="Create password" required
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
                       title="Must contain at least one number, one uppercase and lowercase letter, and at least 6 characters">
                <span class="password-toggle" onclick="togglePassword()">👁️</span>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>
            </div>

            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Register</button>
                <button type="reset" class="btn btn-secondary">Clear</button>
            </div>
        </form>

        <div class="login-link">
            Already registered? <a href="${pageContext.request.contextPath}/facultylogin">Login here</a>
        </div>
    </div>

    <script>
        function togglePassword() {
            const pwd = document.getElementById('fpassWord');
            pwd.type = pwd.type === 'password' ? 'text' : 'password';
        }

        document.getElementById('facultyForm').addEventListener('submit', function(e) {
            const pwd = document.getElementById('fpassWord').value;
            const cpwd = document.getElementById('confirmPassword').value;
            if (pwd !== cpwd) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });

        document.getElementById('confirmPassword').addEventListener('keyup', function() {
            const pwd = document.getElementById('fpassWord').value;
            if (this.value !== pwd) {
                this.style.border = '2px solid #e74c3c';
            } else {
                this.style.border = '2px solid #27ae60';
            }
        });
    </script>
</body>
</html>