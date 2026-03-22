<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .profile-container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 800px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        .form-group { margin-bottom: 20px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
        input[type="text"], input[type="email"], input[type="file"] { width: 100%; padding: 8px; border: none; border-radius: 5px; }
        .btn { background-color: #27ae60; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; margin-top: 10px; }
        .btn:hover { background-color: #229954; }
        .profile-pic { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 3px solid white; margin-bottom: 15px; }
        .resume-link { display: inline-block; margin-top: 10px; color: #ffd700; }
        .success { background-color: #27ae60; color: white; padding: 10px; border-radius: 5px; margin-bottom: 15px; text-align: center; }
        .error { background-color: #e74c3c; color: white; padding: 10px; border-radius: 5px; margin-bottom: 15px; text-align: center; }
        .status-badge { display: inline-block; padding: 5px 10px; border-radius: 20px; font-weight: bold; }
        .status-verified { background: #27ae60; color: white; }
        .status-unverified { background: #e74c3c; color: white; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="studentHeader.jsp" />
    <jsp:include page="studentSidebar.jsp" />

    <div class="main-content">
        <div class="profile-container">
            <h2>My Profile</h2>

            <c:if test="${not empty success}">
                <div class="success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <!-- Profile Picture -->
            <div style="text-align: center;">
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
                <form action="${pageContext.request.contextPath}/student/upload-profile-pic" method="post" enctype="multipart/form-data">
                    <input type="file" name="profilePic" accept="image/*" required>
                    <button type="submit" class="btn">Upload Profile Picture</button>
                </form>
            </div>

            <!-- Update Personal Info -->
            <form action="${pageContext.request.contextPath}/student/update-profile" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="studentName" value="${student.studentName}" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${student.email}" readonly>
                </div>
                <div class="form-group">
                    <label>Contact Number</label>
                    <input type="text" name="contactNum" value="${student.contactNum}" required>
                </div>
                <div class="form-group">
                    <label>Branch</label>
                    <input type="text" value="${student.branch}" disabled>
                </div>
                <div class="form-group">
                    <label>Batch</label>
                    <input type="text" value="${student.batch}" disabled>
                </div>
                <div class="form-group">
                    <label>Faculty</label>
                    <input type="text" value="${student.faculty}" disabled>
                </div>
                <div class="form-group">
                    <label>Placement Status</label>
                    <span class="status-badge ${student.status ? 'status-verified' : 'status-unverified'}">
                        ${student.status ? 'Verified' : 'Not Verified'}
                    </span>
                </div>
                <button type="submit" class="btn">Update Info</button>
            </form>

            <!-- Resume Upload -->
            <hr style="margin: 20px 0; border-color: rgba(255,255,255,0.3);">
            <h3>Resume</h3>
            <c:if test="${not empty student.resumeURL}">
                <a href="${student.resumeURL}" target="_blank" class="resume-link">View Current Resume</a><br>
            </c:if>
            <form action="${pageContext.request.contextPath}/student/upload-resume" method="post" enctype="multipart/form-data">
                <input type="file" name="resume" accept=".pdf,.doc,.docx" required>
                <button type="submit" class="btn">Upload Resume</button>
            </form>
        </div>
    </div>
</body>
</html>