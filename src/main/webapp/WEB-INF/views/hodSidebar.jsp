<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        .hod-sidebar {
            width: 250px;
            height: 100vh;
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            transition: transform 0.3s;
            z-index: 1000;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .sidebar-header h3 {
            margin: 10px 0 0;
            font-size: 20px;
        }
        .sidebar-header p {
            margin: 5px 0 0;
            font-size: 12px;
            opacity: 0.8;
        }
        .sidebar-menu {
            padding: 20px 0;
        }
        .menu-item {
            padding: 12px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }
        .menu-item:hover {
            background-color: rgba(255,255,255,0.1);
            border-left-color: #ffd700;
        }
        .menu-item.active {
            background-color: rgba(255,255,255,0.2);
            border-left-color: #ffd700;
        }
        .menu-item i {
            width: 20px;
            text-align: center;
        }
        .menu-item span {
            flex: 1;
        }
        .menu-badge {
            background-color: #e74c3c;
            color: white;
            border-radius: 12px;
            padding: 2px 8px;
            font-size: 12px;
        }
        .sidebar-footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 12px;
            text-align: center;
            opacity: 0.6;
        }
        @media (max-width: 768px) {
            .hod-sidebar {
                transform: translateX(-100%);
            }
            .hod-sidebar.active {
                transform: translateX(0);
            }
        }
    </style>
</head>
<body>
    <div class="hod-sidebar" id="hodSidebar">
        <div class="sidebar-header">
            <div style="font-size: 40px;">🏛️</div>
            <h3>${hod.branch}</h3>
            <p>HOD: ${hod.hodName}</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/hod/dashboard" class="menu-item">
                <i>📊</i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/hod/facultylist" class="menu-item">
                <i>👨‍🏫</i>
                <span>Faculty</span>
                <span class="menu-badge">${facultyCount}</span>
            </a>
            <a href="${pageContext.request.contextPath}/hod/studentlist" class="menu-item">
                <i>👥</i>
                <span>Students</span>
                <span class="menu-badge">${studentCount}</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/hod/assign-faculty" class="menu-item">
    			<i>👥</i>
   			 	<span>Assign Faculty</span>
			</a>
			<a href="${pageContext.request.contextPath}/hod/auto-assign-faculty" class="menu-item">
    			<i>🔄</i>
    			<span>Auto Assign Faculty</span>
			</a>
			<a href="${pageContext.request.contextPath}/hod/unassigned-students" class="menu-item">
   				 <i>⚠️</i>
    			 <span>Unassigned Students</span>
    		<span class="menu-badge">${unassignedCount}</span>
			</a>
			<a href="${pageContext.request.contextPath}/hod/companies" class="menu-item">
    			<i>🏢</i>
    			<span>Companies</span>
			</a>
        </div>
        <div class="sidebar-footer">
            <p>© 2026 Design Engineering</p>
        </div>
    </div>

    <script>
        // Toggle sidebar on mobile (if menuToggle exists)
        const menuToggle = document.getElementById('menuToggle');
        if (menuToggle) {
            menuToggle.addEventListener('click', function() {
                document.getElementById('hodSidebar').classList.toggle('active');
            });
        }
        // Highlight active menu
        const currentUrl = window.location.pathname;
        document.querySelectorAll('.menu-item').forEach(item => {
            if (item.getAttribute('href') === currentUrl) {
                item.classList.add('active');
            }
        });
    </script>
</body>
</html>