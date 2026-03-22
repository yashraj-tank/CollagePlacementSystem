<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty List - ${hod.branch}</title>
    <style>
        /* same as dashboard styles */
        body { font-family: Arial; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; }
        .container { background-color: #3498db; color: white; padding: 30px; border-radius: 10px; }
        table { width:100%; background:white; color:#333; border-collapse: collapse; }
        th { background:#2980b9; color:white; padding:12px; }
        td { padding:10px; border-bottom:1px solid #ddd; }
    </style>
</head>
<body>
    <jsp:include page="hodHeader.jsp" />
    <jsp:include page="hodSidebar.jsp" />
    <div class="main-content">
        <div class="container">
            <h2>Faculty - ${hod.branch}</h2>
            <table>
                <thead>
                    <tr><th>ID</th><th>Name</th><th>Email</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="f" items="${facultyList}">
                        <tr><td>${f.facultyId}</td><td>${f.facultyName}</td><td>${f.facultyEmail}</td></tr>
                    </c:forEach>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/hod/dashboard">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>