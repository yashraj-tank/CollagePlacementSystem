<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Company Form</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .form-container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 600px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        .form-group { margin-bottom: 20px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
        input, select, textarea { width: 100%; padding: 8px; border: none; border-radius: 5px; }
        .btn { background: #27ae60; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; margin-top: 10px; }
        .btn:hover { background: #229954; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="leftsidebar.jsp" />

    <div class="main-content">
        <div class="form-container">
            <h2>${company.companyId == null ? 'Add Company' : 'Edit Company'}</h2>
            <form action="${pageContext.request.contextPath}/admin/companies/${company.companyId == null ? 'save' : 'update'}" method="post">
                <input type="hidden" name="companyId" value="${company.companyId}">
                <div class="form-group">
                    <label>Company Name</label>
                    <input type="text" name="name" value="${company.name}" required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="4">${company.description}</textarea>
                </div>
                <div class="form-group">
                    <label>Branch (for which branch this company is relevant)</label>
                    <select name="branchName" required>
                        <option value="">-- Select Branch --</option>
                        <c:forEach var="branch" items="${branchList}">
                            <option value="${branch.branchName}" ${company.branch == branch.branchName ? 'selected' : ''}>${branch.branchName}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn">Save</button>
                <a href="${pageContext.request.contextPath}/admin/companies" class="btn" style="background: #e74c3c;">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>