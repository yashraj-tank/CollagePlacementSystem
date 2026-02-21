<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Sign Up</title>
    <style>
        /* Reset margins and paddings */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            /* Background image with overlay */
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('images1/deim.jpeg') no-repeat center center fixed;
            background-size: cover;
            /* Flexbox centering */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;        /* Always at least full viewport height */
            padding: 20px;             /* Space from edges */
        }

        /* Form container – blue theme */
        .signup-form {
            background-color: #3498db; /* Bright blue */
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 600px;
            /* Scroll inside if content exceeds viewport */
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
            box-sizing: border-box;
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

        /* Two‑column layout for branch & batch */
        .row {
            display: flex;
            gap: 15px;
            flex-wrap: wrap; /* Allow wrapping on small screens */
        }

        .row .col {
            flex: 1 1 200px; /* Grow, shrink, basis */
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

        /* Responsive tweaks for very small screens */
        @media (max-width: 480px) {
            .signup-form {
                padding: 20px;
            }
            .row .col {
                flex: 1 1 100%; /* Stack fields vertically */
            }
        }
        /* login link styling */
        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 15px;
        }

        .login-link a {
            color: #fff;
            text-decoration: underline;
            font-weight: bold;
        }

        .login-link a:hover {
            color: #f0f0f0;
        }
        
    </style>
</head>
<body>
    <div class="signup-form">
        <h2>Student Sign Up</h2>
        <!-- Form with file upload support -->
        <form action="" method="post" >
            <!-- Full Name -->
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your full name" required>

            <!-- Enrollment Number -->
            <label for="enrollment">Enrollment Number</label>
            <input type="text" id="enrollment" name="enrollment" placeholder="e.g., 2023CS101" required>

            <!-- Email -->
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required>

            <!-- Contact Number -->
            <label for="contact">Contact Number</label>
            <input type="text" id="contact" name="contact" placeholder="10-digit mobile number" required>

            <!-- Password -->
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>

            <!-- Branch and Batch -->
            <div class="row">
                <div class="col">
                    <label for="branch">Branch</label>
                    <select id="branch" name="branch" required>
                        <option value="">-- Select Branch --</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Information Technology">Information Technology</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Mechanical">Mechanical</option>
                        <option value="Civil">Civil</option>
                        <option value="Electrical">Electrical</option>
                    </select>
                </div>
                <div class="col">
                    <label for="batch">Batch</label>
                    <select id="batch" name="batch" required>
                        <option value="">-- Select Batch --</option>
                        <option value="2020-2024">2020-2024</option>
                        <option value="2021-2025">2021-2025</option>
                        <option value="2022-2026">2022-2026</option>
                        <option value="2023-2027">2023-2027</option>
                        <option value="2024-2028">2024-2028</option>
                    </select>
                </div>
            </div>

            <!-- Profile Picture -->
            <label for="profilePic">Profile Picture</label>
            <input type="file" id="profilePic" name="profilePic" accept="image/*" required>
            <div class="hint">Upload a square image (JPEG, PNG).</div>

            <!-- Resume Upload -->
            <label for="resume">Resume (PDF/DOC)</label>
            <input type="file" id="resume" name="resume" accept=".pdf,.doc,.docx" required>
            <div class="hint">Max size 2MB.</div>

            <button type="submit">Sign Up</button>
        </form>
        <!-- Link to Sign Up page -->
        <div class="login-link">
            Allready have an account <a href="/studentlogin">Login here</a>
        </div>
    </div>
</body>
</html>