<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('images1/deim.jpeg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            background-color: #3498db;
            color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 1300px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* Filter form styling */
        .filter-form {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: flex-end;
            margin-bottom: 30px;
            background-color: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 8px;
        }

        .filter-form .form-group {
            flex: 1 1 200px;
        }

        .filter-form label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #f0f0f0;
        }

        .filter-form select,
        .filter-form button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .filter-form select {
            background-color: #fff;
            color: #333;
        }

        .filter-form button {
            background-color: #2980b9;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .filter-form button:hover {
            background-color: #1f618d;
        }

        /* Counter styling - NEW */
        .filter-counter {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
            font-size: 18px;
            animation: fadeIn 0.5s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .filter-counter span {
            font-size: 24px;
            margin: 0 5px;
        }

        /* Table styling */
        .table-responsive {
            overflow-x: auto;
            margin-top: 20px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            color: #333;
            border-radius: 5px;
            overflow: hidden;
        }

        th {
            background-color: #2980b9;
            color: white;
            padding: 12px;
            text-align: left;
            white-space: nowrap;
        }

        td {
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

        .status-inactive {
            color: red;
            font-weight: bold;
        }

        .nav-links {
            text-align: center;
            margin-top: 25px;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            margin: 0 15px;
            padding: 8px 16px;
            background-color: rgba(255,255,255,0.2);
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: rgba(255,255,255,0.3);
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }
            .filter-form .form-group {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Student List</h2>

        <!-- Filter Form -->
        <form class="filter-form" action="${pageContext.request.contextPath}/filterStudents" method="get">
            <div class="form-group">
                <label for="branch">Select Branch</label>
                <select id="branch" name="branch">
                    <option value="">-- All Branches --</option>
                    <c:forEach var="branchItem" items="${branchList}">
                        <option value="${branchItem.branchName}" 
                            <c:if test="${param.branch == branchItem.branchName}">selected</c:if>>
                            ${branchItem.branchName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="batch">Select Batch</label>
                <select id="batch" name="batch">
                    <option value="">-- All Batches --</option>
                    <c:forEach var="batchItem" items="${batchList}">
                        <option value="${batchItem.batchYear}" 
                            <c:if test="${param.batch == batchItem.batchYear}">selected</c:if>>
                            ${batchItem.batchYear}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <button type="submit">Filter Students</button>
            </div>
        </form>

        <!-- TEMPORARY COUNTER - Shows only when filter is applied -->
        <c:if test="${not empty param.branch or not empty param.batch}">
            <div class="filter-counter">
                <c:choose>
                    <c:when test="${not empty param.branch and not empty param.batch}">
                        Filtered by Branch: <strong>${param.branch}</strong> and Batch: <strong>${param.batch}</strong> | 
                        Found: <span>${empty studentList ? 0 : studentList.size()}</span> student(s)
                    </c:when>
                    <c:when test="${not empty param.branch}">
                        Filtered by Branch: <strong>${param.branch}</strong> | 
                        Found: <span>${empty studentList ? 0 : studentList.size()}</span> student(s)
                    </c:when>
                    <c:when test="${not empty param.batch}">
                        Filtered by Batch: <strong>${param.batch}</strong> | 
                        Found: <span>${empty studentList ? 0 : studentList.size()}</span> student(s)
                    </c:when>
                </c:choose>
            </div>
        </c:if>

        <!-- Student List Table -->
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Enrollment No</th>
                        <th>Student Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Branch</th>
                        <th>Batch</th>
                        <th>Faculty</th>
                        <th>Created Date</th>
                        <th>Status</th>
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
                            <td>${student.branch}</td>
                            <td>${student.batch}</td>
                            <td>${student.faculty}</td>
                            <td>
                                <c:if test="${not empty student.createdAt}">
                                    ${student.createdAt}
                                </c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${student.active}">
                                        <span class="status-active">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-inactive">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty studentList}">
                        <tr>
                            <td colspan="10" style="text-align: center; padding: 30px; color: #666;">
                                <strong>No students found for the selected criteria.</strong>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Navigation Links -->
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/studentsingup">Add New Student</a>
            <a href="${pageContext.request.contextPath}/listbatch">Manage Batches</a>
            <a href="${pageContext.request.contextPath}/listbranch">Manage Branches</a>
        </div>
    </div>
</body>
</html>