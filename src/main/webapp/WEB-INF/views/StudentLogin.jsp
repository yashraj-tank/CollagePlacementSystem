<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            /* Background image with dark overlay */
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('images1/deim.jpeg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* Login container – blue theme */
        .login-form {
            background-color: #3498db; /* Bright blue */
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 400px; /* Slightly narrower than signup */
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

        /* Sign‑up link styling */
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

        /* Optional small hint */
        .hint {
            font-size: 12px;
            color: #d1ecf1;
            margin-top: 5px;
        }

        @media (max-width: 480px) {
            .login-form {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-form">
        <h2>Student Login</h2>
        <!-- Login form (adjust action to your login servlet) -->
        <form action="" method="post">
            <!-- Email -->
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required>

            <!-- Password -->
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <!-- Login Button -->
            <button type="submit">Log In</button>
        </form>

        <!-- Link to Sign Up page -->
        <div class="signup-link">
            Don't have an account? <a href="/studentsingup">Login here</a>
        </div>
    </div>
</body>
</html>