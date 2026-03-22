<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Sign Up</title>
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

        .signup-form {
            background-color: #3498db;
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .signup-form h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .signup-form label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #f0f0f0;
        }

        .signup-form input[type="text"],
        .signup-form input[type="email"],
        .signup-form input[type="password"],
        .signup-form input[type="file"],
        .signup-form select {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .signup-form input[type="file"] {
            background-color: #fff;
            color: #333;
            padding: 8px;
        }

        .signup-form select {
            background-color: #fff;
            color: #333;
        }

        .row {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .row .col {
            flex: 1 1 200px;
        }

        .signup-form button {
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

        .signup-form button:hover {
            background-color: #1f618d;
        }

        .hint {
            font-size: 12px;
            color: #d1ecf1;
            margin-top: 3px;
        }

        @media (max-width: 480px) {
            .signup-form {
                padding: 20px;
            }
            .row .col {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>
    <div class="signup-form">
        <h2>Student Sign Up</h2>
        <!-- Form with file upload support -->
        <form action="savestudent" method="post" enctype="multipart/form-data">
            <!-- Full Name -->
            <label for="name">Full Name</label>
            <input type="text" id="name" name="studentName" placeholder="Enter your full name" required>

            <!-- Enrollment Number -->
            <label for="enrollment">Enrollment Number</label>
            <input type="text" id="enrollment" name="enrollmentNum" placeholder="e.g., 2023CS101" required>

            <!-- Email -->
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required>

            <!-- Contact Number -->
            <label for="contact">Contact Number</label>
            <input type="text" id="contact" name="contactNum" placeholder="10-digit mobile number" required>

            <!-- Password -->
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>

           <!-- Branch and Batch dropdowns - fixed parameter names -->
			<div class="row">
			    <div class="col">
			        <label for="branch">Branch</label>
			        <select id="branch" name="branch" required>  <!-- Changed from branchName to branch -->
			            <option value="">-- Select Branch --</option>
			            <c:forEach var="branch" items="${branchList}">
			                <option value="${branch.branchName}">${branch.branchName}</option>
			            </c:forEach>
			        </select>
			    </div>
			    <div class="col">
			        <label for="batch">Batch</label>
			        <select id="batch" name="batch" required>  <!-- Changed from batchYear to batch -->
			            <option value="">-- Select Batch --</option>
			            <c:forEach var="batch" items="${batchList}">
			                <option value="${batch.batchYear}">${batch.batchYear}</option>
			            </c:forEach>
			        </select>
			    </div>
			</div>


            <!-- Submit Button -->
            <button type="submit">Sign Up</button>
        </form>
    </div>
</body>
</html>