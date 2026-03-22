<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
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
        .dashboard-container {
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
            align-items: center;
        }
        .profile-pic {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .profile-details {
            flex: 1;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
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
        .placement-updates {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            padding: 20px;
        }
        .update-item {
            padding: 12px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .update-item:last-child {
            border-bottom: none;
        }
        .update-title {
            font-weight: bold;
            font-size: 1.1rem;
        }
        .update-date {
            font-size: 0.8rem;
            opacity: 0.8;
            margin-top: 5px;
        }
        .btn {
            display: inline-block;
            background: #27ae60;
            color: white;
            padding: 10px 20px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            margin-top: 20px;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #229954;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .dashboard-container {
                padding: 20px;
            }
            .profile-card {
                flex-direction: column;
                text-align: center;
            }
            .profile-pic {
                width: 80px;
                height: 80px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="studentHeader.jsp" />
    <jsp:include page="studentSidebar.jsp" />

    <div class="main-content">
        <div class="dashboard-container">
            <h1>Student Dashboard</h1>

            <!-- Profile Section -->
            <div class="profile-card">
                <c:choose>
                    <c:when test="${not empty student.profilePicURL}">
                        <img src="${student.profilePicURL}" alt="Profile Picture" class="profile-pic">
                    </c:when>
                    <c:otherwise>
                        <div class="profile-pic" style="background:#fff; display:flex; align-items:center; justify-content:center; color:#3498db; font-size:2rem;">
                            ${student.studentName.charAt(0)}
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="profile-details">
                    <div class="profile-item">
                        <div class="label">Name</div>
                        <div class="value">${student.studentName}</div>
                    </div>
                    <div class="profile-item">
                        <div class="label">Enrollment No</div>
                        <div class="value">${student.enrollmentNum}</div>
                    </div>
                    <div class="profile-item">
                        <div class="label">Email</div>
                        <div class="value">${student.email}</div>
                    </div>
                    <div class="profile-item">
                        <div class="label">Branch</div>
                        <div class="value">${student.branch}</div>
                    </div>
                    <div class="profile-item">
                        <div class="label">Batch</div>
                        <div class="value">${student.batch}</div>
                    </div>
                </div>
            </div>


            <!-- Resume / Documents Link -->
            <div style="text-align: center; margin-top: 20px;">
                <c:if test="${not empty student.resumeURL}">
                    <a href="${student.resumeURL}" target="_blank" class="btn" style="background:#2980b9;">View Resume</a>
                </c:if>
                <c:if test="${empty student.resumeURL}">
                    <a href="${pageContext.request.contextPath}/student/upload-resume" class="btn">Upload Resume</a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>