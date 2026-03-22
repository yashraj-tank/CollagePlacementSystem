<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assign Faculty to Students</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 1200px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        table { width: 100%; border-collapse: collapse; background: white; color: #333; border-radius: 10px; overflow: hidden; margin-top: 20px; }
        th { background: #2980b9; color: white; padding: 12px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        select, button { padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc; }
        .btn { background: #27ae60; color: white; border: none; cursor: pointer; }
        .btn:hover { background: #229954; }
        .alert { padding: 10px; border-radius: 5px; margin-bottom: 20px; text-align: center; }
        .alert-success { background: #27ae60; color: white; }
        .alert-danger { background: #e74c3c; color: white; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="hodHeader.jsp" />
    <jsp:include page="hodSidebar.jsp" />
    
    <form action="${pageContext.request.contextPath}/hod/auto-assign-faculty" method="post" style="margin-bottom:20px;">
    <button type="submit" class="btn btn-primary" style="background:#2980b9;">Auto-Assign Faculty (Even Distribution)</button>
    </form>

    <div class="main-content">
        <div class="container">
            <h2>Assign Faculty to Students - ${hod.branch}</h2>

            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:if test="${empty studentList}">
                <p>No students found in this branch.</p>
            </c:if>
            <c:if test="${not empty studentList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Student Name</th>
                            <th>Enrollment</th>
                            <th>Email</th>
                            <th>Current Faculty</th>
                            <th>Assign New Faculty</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${studentList}">
                            <tr>
                                <td>${student.studentId}</td>
                                <td>${student.studentName}</td>
                                <td>${student.enrollmentNum}</td>
                                <td>${student.email}</td>
                                <td>${not empty student.faculty ? student.faculty : 'Not Assigned'}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/hod/assign-faculty" method="post" style="display:flex; gap:5px;">
                                        <input type="hidden" name="studentId" value="${student.studentId}">
                                        <select name="facultyId" required>
                                            <option value="">-- Select --</option>
                                            <c:forEach var="faculty" items="${facultyList}">
                                                <option value="${faculty.facultyId}" ${student.faculty == faculty.facultyName ? 'selected' : ''}>
                                                    ${faculty.facultyName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <button type="submit" class="btn">Assign</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</body>
</html>