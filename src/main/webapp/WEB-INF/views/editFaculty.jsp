<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Faculty</title>
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
        .edit-container {
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            color: #fff;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 500px;
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
        input, select {
            width: 100%;
            padding: 12px 15px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            background-color: rgba(255,255,255,0.9);
        }
        input:focus, select:focus {
            outline: none;
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
        }
        .btn-cancel {
            background-color: #e74c3c;
            display: block;
            text-align: center;
            text-decoration: none;
            margin-top: 10px;
        }
        .btn-cancel:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <div class="edit-container">
        <h2>Edit Faculty</h2>

        <form action="${pageContext.request.contextPath}/updatefaculty" method="post">
            <input type="hidden" name="facultyId" value="${faculty.facultyId}">

            <div class="form-group">
                <label for="facultyName">Name</label>
                <input type="text" id="facultyName" name="facultyName" value="${faculty.facultyName}" required>
            </div>

            <div class="form-group">
                <label for="facultyEmail">Email</label>
                <input type="email" id="facultyEmail" name="facultyEmail" value="${faculty.facultyEmail}" required readonly>
            </div>

            <div class="form-group">
                <label for="branch">Branch</label>
                <select id="branch" name="branch" required>
                    <option value="">-- Select Branch --</option>
                    <c:forEach var="branchItem" items="${branchList}">
                        <option value="${branchItem.branchName}" ${faculty.branch == branchItem.branchName ? 'selected' : ''}>
                            ${branchItem.branchName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="fpassWord">Password</label>
                <input type="password" id="fpassWord" name="fpassWord" value="${faculty.fpassWord}" required>
            </div>

            <button type="submit" class="btn">Update</button>
            <a href="${pageContext.request.contextPath}/listfaculty" class="btn btn-cancel">Cancel</a>
        </form>
    </div>
</body>
</html>