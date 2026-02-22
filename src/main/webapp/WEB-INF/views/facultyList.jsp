<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty List</title>
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

        /* Main content area – offset by sidebar and header */
        .main-content {
            margin-left: 250px;
            margin-top: 70px;
            padding: 30px;
            transition: margin-left 0.3s;
            min-height: calc(100vh - 70px);
            background-color: #f4f6f9;
        }

        .container {
            background-color: #3498db;
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #fff;
        }

        .add-btn {
            display: inline-block;
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .add-btn:hover {
            background-color: #229954;
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            color: #333;
            border-radius: 5px;
            overflow: hidden;
        }

        th {
            background-color: #2980b9;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .btn {
            display: inline-block;
            padding: 5px 10px;
            margin: 2px;
            border-radius: 3px;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            color: white;
        }

        .btn-edit {
            background-color: #f39c12;
        }

        .btn-edit:hover {
            background-color: #e67e22;
        }

        .btn-delete {
            background-color: #e74c3c;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .nav-links {
            text-align: center;
            margin-top: 25px;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            margin: 0 15px;
            padding: 8px 16px;
            background-color: rgba(255,255,255,0.2);
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: rgba(255,255,255,0.3);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />

    <!-- Include Sidebar -->
    <jsp:include page="leftsidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <h2>Faculty List</h2>

            <div style="text-align: right;">
                <a href="${pageContext.request.contextPath}/facultysignup" class="add-btn">+ Add Faculty</a>
            </div>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Branch</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="faculty" items="${facultyList}">
                            <tr>
                                <td>${faculty.facultyId}</td>
                                <td>${faculty.facultyName}</td>
                                <td>${faculty.facultyEmail}</td>
                                <td>${faculty.branch}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/editfaculty/${faculty.facultyId}" class="btn btn-edit">Edit</a>
                                    <a href="${pageContext.request.contextPath}/deletefaculty/${faculty.facultyId}" 
                                       class="btn btn-delete" 
                                       onclick="return confirm('Delete faculty ${faculty.facultyName}?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty facultyList}">
                            <tr><td colspan="5" style="text-align:center; padding:30px;">No faculty found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/listbranch">Branches</a>
            </div>
        </div>
    </div>
</body>
</html>