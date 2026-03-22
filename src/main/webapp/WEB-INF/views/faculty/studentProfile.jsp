<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Profile</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .profile-container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 1000px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        .info-card { background: rgba(255,255,255,0.1); padding: 20px; border-radius: 10px; margin-bottom: 20px; }
        .info-row { display: flex; margin-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.2); padding-bottom: 5px; }
        .info-label { font-weight: bold; width: 150px; }
        .info-value { flex: 1; }
        .profile-pic { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 3px solid white; margin: 0 auto 20px; display: block; }
        .status-badge { display: inline-block; padding: 5px 10px; border-radius: 20px; font-weight: bold; }
        .status-verified { background: #27ae60; }
        .status-unverified { background: #e74c3c; }
        .btn { background: #27ae60; color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; margin: 5px; }
        .btn-danger { background: #e74c3c; }
        .btn:hover { opacity: 0.9; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="facultyHeader.jsp" />
    <jsp:include page="facultySidebar.jsp" />

    <div class="main-content">
        <div class="profile-container">
            <h2>Student Profile</h2>

            <c:if test="${not empty success}">
                <div style="background:#27ae60; padding:10px; border-radius:5px; margin-bottom:20px;">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div style="background:#e74c3c; padding:10px; border-radius:5px; margin-bottom:20px;">${error}</div>
            </c:if>

            <!-- Profile Picture -->
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

            <!-- Student Info -->
            <div class="info-card">
                <div class="info-row">
                    <div class="info-label">Name:</div>
                    <div class="info-value">${student.studentName}</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Enrollment:</div>
                    <div class="info-value">${student.enrollmentNum}</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Email:</div>
                    <div class="info-value">${student.email}</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Contact:</div>
                    <div class="info-value">${student.contactNum}</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Branch:</div>
                    <div class="info-value">${student.branch}</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Batch:</div>
                    <div class="info-value">${student.batch}</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Status:</div>
                    <div class="info-value">
                        <c:choose>
                            <c:when test="${student.status}">
                                <span class="status-badge status-verified">Verified</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-unverified">Not Verified</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Resume Download (removed inline viewer) -->
            <h3>Resume</h3>
            <c:if test="${not empty student.resumeURL}">
                <a href="${student.resumeURL}" target="_blank" class="btn">Download Resume</a>
            </c:if>
            <c:if test="${empty student.resumeURL}">
                <p>No resume uploaded.</p>
            </c:if>

            <!-- Action Buttons -->
            <div style="text-align: center; margin-top: 20px;">
                <form action="${pageContext.request.contextPath}/faculty/student/${student.studentId}/toggle-status" method="post" style="display:inline;">
                    <button type="submit" class="btn ${student.status ? 'btn-danger' : ''}">
                        ${student.status ? 'Mark as Unverified' : 'Mark as Verified'}
                    </button>
                </form>
                <a href="${pageContext.request.contextPath}/faculty/students" class="btn">Back to My Students</a>
            </div>
        </div>
    </div>
</body>
</html>