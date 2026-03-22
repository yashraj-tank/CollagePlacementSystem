<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
        .dashboard-wrapper {
            background-color: #3498db;
            color: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            max-width: 1200px;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            border-bottom: 2px solid rgba(255,255,255,0.3);
            padding-bottom: 15px;
        }
        h2 {
            margin: 25px 0 15px;
            font-size: 1.5rem;
        }
        .profile-card {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .profile-item {
            flex: 1 1 200px;
        }
        .profile-item .label {
            font-weight: bold;
            font-size: 0.9rem;
            opacity: 0.8;
            text-transform: uppercase;
        }
        .profile-item .value {
            font-size: 1.2rem;
            margin-top: 5px;
        }
        .hod-card {
            background: rgba(255,255,255,0.15);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
            border-left: 5px solid #ffd700;
        }
        .hod-card .hod-name {
            font-size: 1.8rem;
            font-weight: bold;
        }
        .hod-card .hod-title {
            font-size: 1rem;
            opacity: 0.9;
        }
        .table-container {
            overflow-x: auto;
            margin-bottom: 25px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            color: #333;
            border-radius: 10px;
            overflow: hidden;
        }
        th {
            background: #2980b9;
            color: white;
            padding: 12px;
            font-weight: 600;
            text-align: left;
        }
        td {
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        tr:last-child td {
            border-bottom: none;
        }
        tr:hover {
            background: #f5f5f5;
        }
        .btn-logout {
            display: inline-block;
            background: #e74c3c;
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            font-size: 1rem;
            transition: background 0.3s, transform 0.2s;
            border: none;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn-logout:hover {
            background: #c0392b;
            transform: scale(1.05);
        }
        .footer-note {
            text-align: center;
            margin-top: 25px;
            font-size: 0.9rem;
            opacity: 0.7;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .dashboard-wrapper {
                padding: 20px;
            }
            h1 {
                font-size: 1.8rem;
            }
            .profile-card {
                flex-direction: column;
                gap: 10px;
            }
            .hod-card .hod-name {
                font-size: 1.5rem;
            }
        }
        @media (max-width: 480px) {
            h1 {
                font-size: 1.5rem;
            }
            .profile-item .value {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="facultyHeader.jsp" />
    <jsp:include page="facultySidebar.jsp" />

    <div class="main-content">
        <div class="dashboard-wrapper">
            <h1>Faculty Dashboard</h1>

            <!-- Faculty Profile -->
            <div class="profile-card">
                <div class="profile-item">
                    <div class="label">Name</div>
                    <div class="value">${faculty.facultyName}</div>
                </div>
                <div class="profile-item">
                    <div class="label">Email</div>
                    <div class="value">${faculty.facultyEmail}</div>
                </div>
                <div class="profile-item">
                    <div class="label">Branch</div>
                    <div class="value">${faculty.branch}</div>
                </div>
            </div>

            <!-- HOD Information -->
            <c:if test="${not empty hod}">
                <div class="hod-card">
                    <div class="hod-title">Your Head of Department</div>
                    <div class="hod-name">${hod.hodName}</div>
                    <div class="hod-title">${hod.hodEmail}</div>
                </div>
            </c:if>
            <c:if test="${empty hod}">
                <div class="hod-card" style="border-left-color: #e74c3c;">
                    <div class="hod-name">No HOD Assigned</div>
                </div>
            </c:if>

            <!-- Students List -->
            <h2>Students in ${faculty.branch} (${studentCount})</h2>
            
            </div>

            
            <div class="footer-note">
                &copy; 2026 Design Engineering College
            </div>
        </div>
    </div>
</body>
</html>