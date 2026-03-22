<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Applications</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 1200px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        .filter-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px; }
        .filter-form { display: flex; gap: 10px; }
        select, .btn { padding: 6px 12px; border: none; border-radius: 5px; }
        .btn { background: #27ae60; color: white; cursor: pointer; }
        .btn-print { background: #2980b9; }
        .btn:hover { opacity: 0.9; }
        table { width: 100%; border-collapse: collapse; background: white; color: #333; border-radius: 10px; overflow: hidden; }
        th { background: #2980b9; color: white; padding: 12px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        @media print {
            body { background-color: white; }
            .main-content { margin: 0; padding: 0; }
            .sidebar, .header, .filter-bar, .footer { display: none; }
            .container { background: white; color: black; padding: 0; box-shadow: none; }
            table { background: white; }
            th { background: #ddd; color: black; }
        }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="leftsidebar.jsp" />

    <div class="main-content">
        <div class="container">
            <h2>Student Applications</h2>

            <!-- Filter and Print Bar -->
            <div class="filter-bar">
                <form class="filter-form" method="get" action="${pageContext.request.contextPath}/admin/applications">
                    <select name="companyId">
                        <option value="">-- All Companies --</option>
                        <c:forEach var="c" items="${companies}">
                            <option value="${c.companyId}" ${selectedCompanyId == c.companyId ? 'selected' : ''}>${c.name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn">Filter</button>
                </form>
                <button onclick="window.print()" class="btn btn-print">Print List</button>
            </div>

            <!-- Applications Table -->
            <c:choose>
                <c:when test="${empty applications}">
                    <p>No applications found.</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Student Name</th>
                                <th>Enrollment No</th>
                                <th>Branch</th>
                                <th>Email</th>
                                <th>Contact</th>
                                <th>Company</th>
                                <th>Application Date</th>
                            </thead>
                        <tbody>
                            <c:forEach var="app" items="${applications}">
                                <c:set var="apply" value="${app[0]}" />
                                <c:set var="student" value="${app[1]}" />
                                <c:set var="company" value="${app[2]}" />
                                 <tr>
                                    <td>${student.studentName}</td>
                                    <td>${student.enrollmentNum}</td>
                                    <td>${student.branch}</td>
                                    <td>${student.email}</td>
                                    <td>${student.contactNum}</td>
                                    <td>${company.name}</td>
                                    <td>${apply.applicationDate}</td>
                                 </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>