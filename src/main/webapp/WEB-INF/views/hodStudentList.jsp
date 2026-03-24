<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - ${hod.branch}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .container { background-color: #3498db; color: #fff; padding: 30px 40px; border-radius: 10px; box-shadow: 0 8px 16px rgba(0,0,0,0.3); width: 100%; max-width: 1200px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; text-transform: uppercase; letter-spacing: 2px; }
        .branch-info { text-align: center; font-size: 18px; margin-bottom: 20px; background-color: rgba(255,255,255,0.1); padding: 10px; border-radius: 5px; }
        .filter-bar { display: flex; gap: 10px; align-items: center; margin-bottom: 20px; flex-wrap: wrap; }
        .filter-bar select, .filter-bar button, .filter-bar a { padding: 8px 12px; border-radius: 5px; border: none; cursor: pointer; }
        .filter-bar button { background: #2980b9; color: white; }
        .filter-bar a { background: #95a5a6; color: white; text-decoration: none; display: inline-block; }
        table { width: 100%; border-collapse: collapse; background-color: #fff; color: #333; border-radius: 5px; overflow: hidden; }
        th { background-color: #2980b9; color: white; padding: 12px; text-align: left; }
        td { padding: 10px 12px; border-bottom: 1px solid #ddd; }
        tr:last-child td { border-bottom: none; }
        .btn { background-color: #27ae60; color: white; border: none; padding: 10px 20px; border-radius: 5px; font-size: 14px; font-weight: bold; cursor: pointer; text-decoration: none; display: inline-block; transition: background-color 0.3s; margin-top: 20px; }
        .btn:hover { background-color: #229954; }
        @media (max-width: 768px) { .main-content { margin-left: 0; padding: 20px; } }
    </style>
</head>
<body>
    <jsp:include page="hodHeader.jsp" />
    <jsp:include page="hodSidebar.jsp" />

    <div class="main-content">
        <div class="container">
            <h2>Student List - ${hod.branch} Department</h2>

            <!-- Filter Bar -->
            <div class="filter-bar">
                <form method="get" action="${pageContext.request.contextPath}/hod/studentlist" style="display: flex; gap: 10px;">
                    <select name="batch">
                        <option value="">-- All Batches --</option>
                        <c:forEach var="batch" items="${batches}">
                            <option value="${batch.batchYear}" ${selectedBatch == batch.batchYear ? 'selected' : ''}>${batch.batchYear}</option>
                        </c:forEach>
                    </select>
                    <button type="submit">Filter</button>
                </form>
                <c:if test="${not empty selectedBatch}">
                    <a href="${pageContext.request.contextPath}/hod/studentlist">Clear Filter</a>
                </c:if>
            </div>

            <div class="branch-info">
                Total Students: <strong>${studentCount}</strong>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Enrollment No</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Batch</th>
                        <th>Faculty</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${studentList}">
                        <tr>
                            <td>${student.studentId}</td>
                            <td>${student.enrollmentNum}</td>
                            <td>${student.studentName}</td>
                            <td>${student.email}</td>
                            <td>${student.contactNum}</td>
                            <td>${student.batch}</td>
                            <td>${student.faculty}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty studentList}">
                        <tr><td colspan="7" style="text-align:center; padding:20px;">No students found in this branch.</td></tr>
                    </c:if>
                </tbody>
            </table>

            <div style="text-align: center;">
                <a href="${pageContext.request.contextPath}/hod/dashboard" class="btn">Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>
