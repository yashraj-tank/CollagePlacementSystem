<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Companies</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 1200px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        table { width: 100%; border-collapse: collapse; background: white; color: #333; border-radius: 10px; overflow: hidden; }
        th { background: #2980b9; color: white; padding: 12px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        .btn { display: inline-block; padding: 5px 10px; margin: 2px; border-radius: 4px; text-decoration: none; font-size: 13px; color: white; }
        .btn-add { background: #27ae60; margin-bottom: 15px; display: inline-block; }
        .btn-edit { background: #f39c12; }
        .btn-delete { background: #e74c3c; }
        .btn:hover { opacity: 0.8; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="leftsidebar.jsp" />

    <div class="main-content">
        <div class="container">
            <h2>Company List</h2>
            <div style="text-align: right; margin-bottom: 15px;">
                <a href="${pageContext.request.contextPath}/admin/companies/add" class="btn btn-add">+ Add Company</a>
            </div>
            <table>
                <thead>
                    <tr><th>ID</th><th>Name</th><th>Branch</th><th>Created</th><th>Actions</th></thead>
                <tbody>
                    <c:forEach var="c" items="${companies}">
                        <tr>
                            <td>${c.companyId}</td>
                            <td>${c.name}</td>
                            <td>${c.branch}</td>
                            <td>${c.createdAt}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/companies/edit/${c.companyId}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/companies/delete/${c.companyId}" class="btn btn-delete" onclick="return confirm('Delete this company?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>