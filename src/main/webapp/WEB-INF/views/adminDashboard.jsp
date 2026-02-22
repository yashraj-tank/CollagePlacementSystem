<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Design Engineering</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
        }

        /* Main content area */
        .main-content {
            margin-left: 250px;
            margin-top: 70px;
            padding: 30px;
            transition: margin-left 0.3s;
            min-height: calc(100vh - 70px);
            background-color: #f4f6f9;
        }

        /* Dashboard Cards */
        .dashboard-header {
            margin-bottom: 30px;
        }

        .dashboard-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .dashboard-header p {
            color: #666;
            font-size: 16px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .stat-info h3 {
            color: #666;
            font-size: 14px;
            font-weight: normal;
            margin-bottom: 10px;
        }

        .stat-info .stat-number {
            color: #333;
            font-size: 32px;
            font-weight: bold;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
        }

        .stat-icon.blue {
            background-color: rgba(52, 152, 219, 0.1);
            color: #3498db;
        }

        .stat-icon.green {
            background-color: rgba(46, 204, 113, 0.1);
            color: #2ecc71;
        }

        .stat-icon.purple {
            background-color: rgba(155, 89, 182, 0.1);
            color: #9b59b6;
        }

        .stat-icon.orange {
            background-color: rgba(230, 126, 34, 0.1);
            color: #e67e22;
        }

        .stat-icon.teal {
            background-color: rgba(26, 188, 156, 0.1);
            color: #1abc9c;
        }

        .stat-icon.red {
            background-color: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
        }

        /* Charts and Tables Section */
        .dashboard-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .dashboard-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .card-header h3 {
            color: #333;
            font-size: 18px;
        }

        .card-header a {
            color: #3498db;
            text-decoration: none;
            font-size: 14px;
        }

        .card-header a:hover {
            text-decoration: underline;
        }

        /* Recent Students Table */
        .recent-table {
            width: 100%;
            border-collapse: collapse;
        }

        .recent-table th {
            text-align: left;
            padding: 12px;
            color: #666;
            font-weight: normal;
            border-bottom: 2px solid #f0f0f0;
        }

        .recent-table td {
            padding: 12px;
            border-bottom: 1px solid #f0f0f0;
        }

        .recent-table tr:hover {
            background-color: #f9f9f9;
        }

        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-badge.active {
            background-color: #d4edda;
            color: #155724;
        }

        .status-badge.inactive {
            background-color: #f8d7da;
            color: #721c24;
        }

        /* Activity List */
        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .activity-details {
            flex: 1;
        }

        .activity-details p {
            color: #333;
            margin-bottom: 3px;
        }

        .activity-time {
            color: #999;
            font-size: 12px;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 25px;
        }

        .action-btn {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            color: #333;
        }

        .action-btn:hover {
            background-color: #e9ecef;
            transform: translateY(-2px);
        }

        .action-btn i {
            font-size: 24px;
            display: block;
            margin-bottom: 8px;
            color: #3498db;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .dashboard-row {
                grid-template-columns: 1fr;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Include Sidebar -->
    <jsp:include page="leftsidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content" id="mainContent">
        <div class="dashboard-header">
            <h1>Welcome back, Admin!</h1>
            <p>Here's what's happening with your institute today.</p>
        </div>

        <!-- Statistics Cards (now includes Faculty & HOD) -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total Students</h3>
                    <div class="stat-number">${totalStudents}</div>
                </div>
                <div class="stat-icon blue">👥</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Active Students</h3>
                    <div class="stat-number">${activeStudents}</div>
                </div>
                <div class="stat-icon green">✓</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total Faculty</h3>
                    <div class="stat-number">${facultyCount}</div>
                </div>
                <div class="stat-icon teal">👨‍🏫</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total HODs</h3>
                    <div class="stat-number">${hodCount}</div>
                </div>
                <div class="stat-icon red">👤</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total Batches</h3>
                    <div class="stat-number">${totalBatches}</div>
                </div>
                <div class="stat-icon purple">📅</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total Branches</h3>
                    <div class="stat-number">${totalBranches}</div>
                </div>
                <div class="stat-icon orange">🏫</div>
            </div>
        </div>

        <!-- Dashboard Row (Recent Students & Activity) -->
        <div class="dashboard-row">
            <!-- Recent Students -->
            <div class="dashboard-card">
                <div class="card-header">
                    <h3>Recently Added Students</h3>
                    <a href="${pageContext.request.contextPath}/filterStudents">View All →</a>
                </div>
                <table class="recent-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Enrollment</th>
                            <th>Branch</th>
                            <th>Batch</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${recentStudents}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <tr>
                                    <td>${student.studentName}</td>
                                    <td>${student.enrollmentNum}</td>
                                    <td>${student.branch}</td>
                                    <td>${student.batch}</td>
                                    <td>
                                        <span class="status-badge ${student.active ? 'active' : 'inactive'}">
                                            ${student.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Recent Activity -->
            <div class="dashboard-card">
                <div class="card-header">
                    <h3>Recent Activity</h3>
                    <a href="#">View All</a>
                </div>
                <ul class="activity-list">
                    <li class="activity-item">
                        <div class="activity-icon">👤</div>
                        <div class="activity-details">
                            <p>New student registration</p>
                            <span class="activity-time">5 minutes ago</span>
                        </div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">📅</div>
                        <div class="activity-details">
                            <p>Batch 2026-2027 created</p>
                            <span class="activity-time">1 hour ago</span>
                        </div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">🏫</div>
                        <div class="activity-details">
                            <p>New branch added: AI & ML</p>
                            <span class="activity-time">3 hours ago</span>
                        </div>
                    </li>
                    <li class="activity-item">
                        <div class="activity-icon">📝</div>
                        <div class="activity-details">
                            <p>Student profile updated</p>
                            <span class="activity-time">5 hours ago</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Quick Actions (added Faculty & HOD links) -->
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/studentsingup" class="action-btn">
                <i>➕</i>
                Add Student
            </a>
            <a href="${pageContext.request.contextPath}/listfaculty" class="action-btn">
                <i>👨‍🏫</i>
                Manage Faculty
            </a>
            <a href="${pageContext.request.contextPath}/listhod" class="action-btn">
                <i>👤</i>
                Manage HODs
            </a>
            <a href="${pageContext.request.contextPath}/listbatch" class="action-btn">
                <i>📅</i>
                Manage Batches
            </a>
            <a href="${pageContext.request.contextPath}/listbranch" class="action-btn">
                <i>🏫</i>
                Manage Branches
            </a>
            <a href="#" class="action-btn">
                <i>📊</i>
                Generate Report
            </a>
        </div>
    </div>

    <script>
        // Toggle sidebar on mobile (if menuToggle exists in header)
        document.addEventListener('DOMContentLoaded', function() {
            const menuToggle = document.getElementById('menuToggle');
            if (menuToggle) {
                menuToggle.addEventListener('click', function() {
                    document.querySelector('.sidebar').classList.toggle('active');
                });
            }
        });
    </script>
</body>
</html>