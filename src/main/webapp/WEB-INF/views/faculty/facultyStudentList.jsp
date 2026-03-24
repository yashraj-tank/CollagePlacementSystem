<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Students</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 1200px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        .filter-bar { display: flex; gap: 10px; align-items: center; margin-bottom: 20px; flex-wrap: wrap; }
        .filter-bar select, .filter-bar button, .filter-bar a { padding: 8px 12px; border-radius: 5px; border: none; cursor: pointer; }
        .filter-bar button { background: #2980b9; color: white; }
        .filter-bar a { background: #95a5a6; color: white; text-decoration: none; display: inline-block; }
        table { width: 100%; border-collapse: collapse; background: white; color: #333; border-radius: 10px; overflow: hidden; margin-top: 20px; }
        th { background: #2980b9; color: white; padding: 12px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        .btn-back { background: #27ae60; color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; margin-top: 20px; }
        .btn-back:hover { background: #229954; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="facultyHeader.jsp" />
    <jsp:include page="facultySidebar.jsp" />

    <div class="main-content">
        <div class="container">
            <h2>My Students (${studentCount})</h2>

            <!-- Filter Bar -->
            <div class="filter-bar">
                <form method="get" action="${pageContext.request.contextPath}/faculty/students" style="display: flex; gap: 10px;">
                    <select name="batch">
                        <option value="">-- All Batches --</option>
                        <c:forEach var="batchItem" items="${batches}">
                            <option value="${batchItem.batchYear}" ${selectedBatch == batchItem.batchYear ? 'selected' : ''}>${batchItem.batchYear}</option>
                        </c:forEach>
                    </select>
                    <button type="submit">Filter</button>
                </form>
                <c:if test="${not empty selectedBatch}">
                    <a href="${pageContext.request.contextPath}/faculty/students">Clear Filter</a>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${empty studentList}">
                    <p>No students assigned to you yet.</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Student Name</th>
                                <th>Enrollment</th>
                                <th>Email</th>
                                <th>Branch</th>
                                <th>Batch</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${studentList}">
                                <tr>
                                    <td>${student.studentId}</td>
                                    <td>${student.studentName}</td>
                                    <td>${student.enrollmentNum}</td>
                                    <td>${student.email}</td>
                                    <td>${student.branch}</td>
                                    <td>${student.batch}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/faculty/student/${student.studentId}" class="btn-back" style="background:#27ae60;">View Profile</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
            <div style="text-align: center;">
                <a href="${pageContext.request.contextPath}/faculty/dashboard" class="btn-back">Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>