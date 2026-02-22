<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Branch</title>
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

        .form-container {
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

        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .form-container label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #f0f0f0;
        }

        .form-container input[type="text"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-container button {
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

        .form-container button:hover {
            background-color: #1f618d;
        }

        .nav-links {
            text-align: center;
            margin-top: 20px;
            font-size: 15px;
        }

        .nav-links a {
            color: #fff;
            text-decoration: underline;
            font-weight: bold;
            margin: 0 10px;
        }

        .nav-links a:hover {
            color: #f0f0f0;
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Enter Branch</h2>
        <form action="savebranch" method="post">
            <label for="branch">Branch</label>
            <input type="text" id="branch" name="branchName" placeholder="e.g., Computer Science" required>
            <button type="submit">Submit Branch</button>
        </form>
        <div class="nav-links">
        </div>
    </div>
</body>
</html>