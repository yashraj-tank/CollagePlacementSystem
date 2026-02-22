<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOD Registration</title>
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

        .hod-form-container {
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
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .hod-form-container h2 {
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

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
            background-color: rgba(255,255,255,0.9);
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            background-color: #fff;
        }

        .form-group input::placeholder {
            color: #999;
            font-size: 13px;
        }

        .form-group select {
            cursor: pointer;
            color: #333;
        }

        .form-group select option {
            background-color: #fff;
            color: #333;
            padding: 10px;
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
            z-index: 10;
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
            background-color: rgba(231, 76, 60, 0.2);
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #e74c3c;
        }

        .success-message {
            background-color: rgba(39, 174, 96, 0.2);
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #27ae60;
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: rgba(255,255,255,0.7);
        }

        .branch-icon {
            position: absolute;
            right: 15px;
            top: 42px;
            color: #666;
            pointer-events: none;
        }

        @media (max-width: 480px) {
            .hod-form-container {
                padding: 25px 20px;
            }
            .btn-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="hod-form-container">
        <h2>HOD Registration</h2>
        
        <!-- Display error message if any -->
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <!-- Display success message if any -->
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>
        
        <!-- HOD Registration Form -->
        <form action="${pageContext.request.contextPath}/savehod" method="post" id="hodForm">
            
            <!-- HOD Name Field -->
            <div class="form-group">
                <label for="hodName">Full Name</label>
                <input type="text" id="hodName" name="hodName" 
                       placeholder="Enter HOD full name" 
                       value="${hod != null ? hod.hodName : ''}"
                       required 
                       pattern="[A-Za-z ]{3,50}"
                       title="Name should contain only letters and spaces (3-50 characters)">
            </div>
            
            <!-- HOD Email Field -->
            <div class="form-group">
                <label for="hodEmail">Email Address</label>
                <input type="email" id="hodEmail" name="hodEmail" 
                       placeholder="hod@college.edu" 
                       value="${hod != null ? hod.hodEmail : ''}"
                       required 
                       title="Enter a valid email address">
            </div>
            
            <!-- Branch Dropdown (Foreign Key) -->
            <div class="form-group">
                <label for="branch">Select Branch</label>
                <select id="branch" name="branch" required>
                    <option value="">-- Choose Branch --</option>
                    <c:forEach var="branchItem" items="${branchList}">
                        <option value="${branchItem.branchName}" 
                            <c:if test="${hod != null && hod.branch == branchItem.branchName}">selected</c:if>>
                            ${branchItem.branchName}
                        </option>
                    </c:forEach>
                </select>
                <span class="branch-icon">🏫</span>
            </div>
            
            <!-- Password Field -->
            <div class="form-group">
                <label for="hpassWord">Password</label>
                <input type="password" id="hpassWord" name="hpassWord" 
                       placeholder="Create a strong password" 
                       required 
                       minlength="6"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
                       title="Must contain at least one number, one uppercase and lowercase letter, and at least 6 characters">
                <span class="password-toggle" onclick="togglePassword()">👁️</span>
            </div>
            
            <!-- Confirm Password Field -->
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" 
                       placeholder="Re-enter password" 
                       required>
            </div>
            
            <!-- Buttons -->
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Register HOD</button>
                <button type="reset" class="btn btn-secondary">Clear</button>
            </div>
            
            <!-- Login Link -->
            <div class="login-link">
                Already have an account? <a href="${pageContext.request.contextPath}/hodlogin">Login here</a>
            </div>
            
            <div class="form-footer">
                <p>Head of Department Registration | Design Engineering</p>
            </div>
        </form>
    </div>

    <script>
        // Toggle password visibility
        function togglePassword() {
            const passwordField = document.getElementById('hpassWord');
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
        }
        
        // Form validation
        document.getElementById('hodForm').addEventListener('submit', function(e) {
            const password = document.getElementById('hpassWord').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
            
            // Check if branch is selected
            const branch = document.getElementById('branch').value;
            if (!branch) {
                e.preventDefault();
                alert('Please select a branch!');
            }
        });
        
        // Real-time password match validation
        document.getElementById('confirmPassword').addEventListener('keyup', function() {
            const password = document.getElementById('hpassWord').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.style.border = '2px solid #e74c3c';
                this.style.backgroundColor = '#fff0f0';
            } else {
                this.style.border = '2px solid #27ae60';
                this.style.backgroundColor = '#f0fff0';
            }
        });
        
        // Email format validation
        document.getElementById('hodEmail').addEventListener('blur', function() {
            const email = this.value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailPattern.test(email)) {
                this.style.border = '2px solid #e74c3c';
            } else {
                this.style.border = '2px solid #27ae60';
            }
        });
        
        // Branch selection highlight
        document.getElementById('branch').addEventListener('change', function() {
            if (this.value) {
                this.style.border = '2px solid #27ae60';
            } else {
                this.style.border = 'none';
            }
        });
    </script>
</body>
</html>