<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Companies - ${student.branch}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 1000px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        table { width: 100%; border-collapse: collapse; background: white; color: #333; border-radius: 10px; overflow: hidden; margin-top: 20px; }
        th { background: #2980b9; color: white; padding: 12px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        .btn-apply { background: #27ae60; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; }
        .btn-apply:hover { background: #229954; }
        .btn-back { background: #27ae60; color: white; border: none; padding: 8px 15px; border-radius: 5px; text-decoration: none; display: inline-block; margin-top: 20px; }
        .alert-success { background: #27ae60; padding: 10px; border-radius: 5px; margin-bottom: 20px; text-align: center; }
        .alert-error { background: #e74c3c; padding: 10px; border-radius: 5px; margin-bottom: 20px; text-align: center; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="studentHeader.jsp" />
    <jsp:include page="studentSidebar.jsp" />

    <div class="main-content">
        <div class="container">
            <h2>Companies Recruiting in ${student.branch}</h2>

            <c:if test="${not empty success}">
                <div class="alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert-error">${error}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty companies}">
                    <p>No companies currently recruiting for your branch.</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Company Name</th>
                                <th>Description</th>
                                <th>Posted On</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="company" items="${companies}">
                                <tr>
                                    <td>${company.name}</td>
                                    <td>${company.description}</td>
                                    <td>${company.createdAt}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/student/apply" method="post" onsubmit="return confirm('Are you sure you want to apply for ${company.name}?');">
                                            <input type="hidden" name="companyId" value="${company.companyId}">
                                            <button type="submit" class="btn-apply">Apply</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>

            <div style="text-align: center;">
                <a href="${pageContext.request.contextPath}/student/dashboard" class="btn-back">Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>