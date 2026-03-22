<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOD Dashboard</title>
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
            transition: margin-left 0.3s;
            min-height: calc(100vh - 70px);
            background-color: #f4f6f9;
        }
        .dashboard-container {
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
        }
        .info-card {
            background-color: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
        }
        .info-row {
            display: flex;
            margin-bottom: 10px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
            padding-bottom: 5px;
        }
        .info-label {
            font-weight: bold;
            width: 120px;
        }
        .info-value {
            flex: 1;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            color: #333;
            border-radius: 5px;
            overflow: hidden;
            margin-top: 20px;
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
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
            margin: 5px;
        }
        .btn:hover {
            background-color: #229954;
        }
        .btn-secondary {
            background-color: #2980b9;
        }
        .btn-secondary:hover {
            background-color: #1f618d;
        }
        .btn-danger {
            background-color: #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="hodHeader.jsp" />
    <jsp:include page="hodSidebar.jsp" />

    <div class="main-content">
        <div class="dashboard-container">
            <h2>HOD Dashboard - ${hod.branch} Department</h2>
            
            <div class="info-card">
                <div class="info-row">
                    <span class="info-label">Name:</span>
                    <span class="info-value">${hod.hodName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Email:</span>
                    <span class="info-value">${hod.hodEmail}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Branch:</span>
                    <span class="info-value">${hod.branch}</span>
                </div>
            </div>

            <h3>Faculty Members in ${hod.branch}</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="faculty" items="${facultyList}">
                        <tr>
                            <td>${faculty.facultyId}</td>
                            <td>${faculty.facultyName}</td>
                            <td>${faculty.facultyEmail}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty facultyList}">
                        <tr>
                            <td colspan="3" style="text-align:center; padding:20px;">No faculty found in this branch.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <h3 style="margin-top:30px;">Students in ${hod.branch}</h3>
            
            <div style="text-align: center; margin-top: 25px;">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
</body>
</html>