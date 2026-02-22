<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Batch</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
        }
        .main-content {
            margin-left: 250px;
            margin-top: 70px;
            padding: 30px;
            min-height: calc(100vh - 70px);
            background-color: #f4f6f9;
        }
        .form-container {
            background-color: #3498db;
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            max-width: 500px;
            margin: 0 auto;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #229954;
        }
        .btn-cancel {
            background-color: #e74c3c;
            display: inline-block;
            text-align: center;
            text-decoration: none;
            margin-top: 10px;
        }
        .btn-cancel:hover {
            background-color: #c0392b;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="leftsidebar.jsp" />

    <div class="main-content">
        <div class="form-container">
            <h2>Edit Batch</h2>
            <form action="${pageContext.request.contextPath}/updatebatch" method="post">
                <input type="hidden" name="batchId" value="${batch.batchId}" />
                <div class="form-group">
                    <label for="batchYear">Batch Year</label>
                    <input type="text" id="batchYear" name="batchYear" value="${batch.batchYear}" required />
                </div>
                <button type="submit" class="btn">Update</button>
                <a href="${pageContext.request.contextPath}/listbatch" class="btn btn-cancel" style="display:block; text-align:center; text-decoration:none;">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>