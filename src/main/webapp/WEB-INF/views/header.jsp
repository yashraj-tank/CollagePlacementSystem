<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        /* Header Styles */
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 0 20px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            right: 0;
            left: 250px;
            z-index: 100;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: left 0.3s;
        }

        .header-left {
            display: flex;
            align-items: center;
        }

        .menu-toggle {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            margin-right: 20px;
            display: none;
        }

        .header-title {
            font-size: 20px;
            font-weight: bold;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification-icon {
            position: relative;
            cursor: pointer;
        }

        .notification-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: #e74c3c;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .user-profile:hover {
            background-color: #34495e;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3498db;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .user-info {
            display: none;
        }

        .user-info h4 {
            font-size: 14px;
            margin: 0;
        }

        .user-info p {
            font-size: 12px;
            margin: 0;
            opacity: 0.8;
        }

        .dropdown-menu {
            position: absolute;
            top: 60px;
            right: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: none;
            z-index: 1000;
            min-width: 200px;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-item {
            padding: 12px 20px;
            color: #333;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s;
        }

        .dropdown-item:hover {
            background-color: #f5f5f5;
        }

        .dropdown-divider {
            height: 1px;
            background-color: #ddd;
            margin: 5px 0;
        }

        @media (max-width: 768px) {
            .header {
                left: 0;
            }
            .menu-toggle {
                display: block;
            }
            .user-info {
                display: none;
            }
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header class="header" id="header">
        <div class="header-left">
            <button class="menu-toggle" id="menuToggle">☰</button>
            <div class="header-title">Admin Dashboard</div>
        </div>
        <div class="header-right">
            <div class="notification-icon" id="notificationBtn">
                🔔
                <span class="notification-badge">3</span>
            </div>
            <div class="user-profile" id="userProfileBtn">
                <div class="user-avatar">AD</div>
                <div class="user-info">
                    <h4>Admin User</h4>
                    <p>admin@college.edu</p>
                </div>
            </div>
        </div>
    </header>

    <!-- User Dropdown Menu -->
    <div class="dropdown-menu" id="userDropdown">
        <a href="${pageContext.request.contextPath}/admin/profile" class="dropdown-item">Profile</a>
        <a href="${pageContext.request.contextPath}/admin/settings" class="dropdown-item">Settings</a>
        <div class="dropdown-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
    </div>

    <!-- Notification Dropdown Menu -->
    <div class="dropdown-menu" id="notificationDropdown">
        <a href="#" class="dropdown-item">New student registration</a>
        <a href="#" class="dropdown-item">System update completed</a>
        <a href="#" class="dropdown-item">3 pending approvals</a>
        <div class="dropdown-divider"></div>
        <a href="#" class="dropdown-item">View all notifications</a>
    </div>

    <script>
        // Toggle mobile menu
        document.getElementById('menuToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('active');
        });

        // User profile dropdown
        document.getElementById('userProfileBtn').addEventListener('click', function(e) {
            e.stopPropagation();
            const dropdown = document.getElementById('userDropdown');
            dropdown.classList.toggle('show');
            document.getElementById('notificationDropdown').classList.remove('show');
        });

        // Notification dropdown
        document.getElementById('notificationBtn').addEventListener('click', function(e) {
            e.stopPropagation();
            const dropdown = document.getElementById('notificationDropdown');
            dropdown.classList.toggle('show');
            document.getElementById('userDropdown').classList.remove('show');
        });

        // Close dropdowns when clicking outside
        document.addEventListener('click', function() {
            document.getElementById('userDropdown').classList.remove('show');
            document.getElementById('notificationDropdown').classList.remove('show');
        });

        // Prevent dropdowns from closing when clicking inside them
        document.getElementById('userDropdown').addEventListener('click', function(e) {
            e.stopPropagation();
        });
        
        document.getElementById('notificationDropdown').addEventListener('click', function(e) {
            e.stopPropagation();
        });
    </script>
</body>
</html>