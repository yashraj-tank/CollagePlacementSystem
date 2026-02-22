<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Branch List</title>
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

        .list-container {
            background-color: #3498db;
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        .list-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .btn-add {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin-bottom: 20px;
            display: inline-block;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn-add:hover {
            background-color: #229954;
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

        tr:last-child td {
            border-bottom: none;
        }

        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin: 2px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            color: white;
            transition: background-color 0.3s;
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
            margin-top: 20px;
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

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .list-container {
                padding: 20px;
            }
            table {
                font-size: 14px;
            }
            .btn {
                padding: 4px 8px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <!-- Include Header and Sidebar -->
    <jsp:include page="header.jsp" />
    <jsp:include page="leftsidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <div class="list-container">
            <h2>Branch List</h2>

            <div style="text-align: right; margin-bottom: 15px;">
                <a href="${pageContext.request.contextPath}/branch" class="btn-add">+ Add New Branch</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Branch ID</th>
                        <th>Branch Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="branch" items="${branchList}">
                        <tr>
                            <td>${branch.branchId}</td>
                            <td>${branch.branchName}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/editbranch/${branch.branchId}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/deletebranch/${branch.branchId}" 
                                   class="btn btn-delete" 
                                   onclick="return confirm('Are you sure you want to delete branch ${branch.branchName}?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty branchList}">
                        <tr>
                            <td colspan="3" style="text-align: center; padding: 20px;">No branches found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

        </div>
    </div>
</body>
</html>