<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration</title>
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

        .admin-form-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 450px;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .admin-form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 3px;
            font-size: 28px;
            border-bottom: 2px solid rgba(255,255,255,0.3);
            padding-bottom: 15px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #f0f0f0;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
            background-color: rgba(255,255,255,0.9);
        }

        .form-group input:focus {
            outline: none;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            background-color: #fff;
        }

        .form-group input::placeholder {
            color: #999;
            font-size: 13px;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 42px;
            cursor: pointer;
            color: #666;
            font-size: 14px;
            background: rgba(255,255,255,0.9);
            padding: 2px 8px;
            border-radius: 4px;
        }

        .password-toggle:hover {
            background: #fff;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 35px;
        }

        .btn {
            flex: 1;
            padding: 14px 20px;
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
            background-color: #4CAF50;
            color: white;
        }

        .btn-primary:hover {
            background-color: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .btn-secondary {
            background-color: #f44336;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #da190b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            color: #f0f0f0;
        }

        .login-link a {
            color: #FFD700;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        .login-link a:hover {
            color: #FFA500;
            text-decoration: underline;
        }

        .error-message {
            background-color: rgba(255, 0, 0, 0.2);
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid rgba(255, 0, 0, 0.5);
        }

        .success-message {
            background-color: rgba(76, 175, 80, 0.2);
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid rgba(76, 175, 80, 0.5);
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: rgba(255,255,255,0.7);
        }

        @media (max-width: 480px) {
            .admin-form-container {
                padding: 25px 20px;
            }
            .btn-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="admin-form-container">
        <h2>Admin Registration</h2>
        
        <!-- Display error message if any -->
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <!-- Display success message if any -->
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>
        
        <!-- Admin Registration Form -->
        <form action="${pageContext.request.contextPath}/saveadmin" method="post" id="adminForm">
            
            <!-- Admin Name Field -->
            <div class="form-group">
                <label for="adminName">Full Name</label>
                <input type="text" id="adminName" name="adminName" 
                       placeholder="Enter admin full name" 
                       value="${admin != null ? admin.adminName : ''}"
                       required 
                       pattern="[A-Za-z ]{3,50}"
                       title="Name should contain only letters and spaces (3-50 characters)">
            </div>
            
            <!-- Admin Email Field -->
            <div class="form-group">
                <label for="adminEmail">Email Address</label>
                <input type="email" id="adminEmail" name="adminEmail" 
                       placeholder="admin@college.edu" 
                       value="${admin != null ? admin.adminEmail : ''}"
                       required 
                       title="Enter a valid email address">
            </div>
            
            <!-- Password Field -->
            <div class="form-group">
                <label for="apassWord">Password</label>
                <input type="password" id="apassWord" name="apassWord" 
                       placeholder="Create a strong password" 
                       required 
                       minlength="6"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
                       title="Must contain at least one number, one uppercase and lowercase letter, and at least 6 characters">
                <span class="password-toggle" onclick="togglePassword()">👁️</span>
            </div>
            
            <!-- Confirm Password Field (Additional security) -->
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" 
                       placeholder="Re-enter password" 
                       required>
            </div>
            
            <!-- Buttons -->
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Register Admin</button>
                <button type="reset" class="btn btn-secondary">Clear</button>
            </div>
            
            <!-- Login Link -->
            <div class="login-link">
                Already have an account? <a href="${pageContext.request.contextPath}/adminlogin">Login here</a>
            </div>
            
            <div class="form-footer">
                <p>Secure Admin Registration | Design Engineering</p>
            </div>
        </form>
    </div>

    <script>
        // Toggle password visibility
        function togglePassword() {
            const passwordField = document.getElementById('apassWord');
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
        }
        
        // Form validation
        document.getElementById('adminForm').addEventListener('submit', function(e) {
            const password = document.getElementById('apassWord').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
        
        // Real-time password match validation
        document.getElementById('confirmPassword').addEventListener('keyup', function() {
            const password = document.getElementById('apassWord').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.style.border = '2px solid #ff4444';
                this.style.backgroundColor = '#fff0f0';
            } else {
                this.style.border = '2px solid #4CAF50';
                this.style.backgroundColor = '#f0fff0';
            }
        });
        
        // Email format validation
        document.getElementById('adminEmail').addEventListener('blur', function() {
            const email = this.value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailPattern.test(email)) {
                this.style.border = '2px solid #ff4444';
            } else {
                this.style.border = '2px solid #4CAF50';
            }
        });
    </script>
</body>
</html>