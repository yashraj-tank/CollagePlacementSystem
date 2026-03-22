<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        .hod-header {
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
        @media (max-width: 768px) {
            .hod-header {
                left: 0;
            }
            .menu-toggle {
                display: block;
            }
        }
    </style>
</head>
<body>
    <header class="hod-header" id="hodHeader">
        <div class="header-left">
            <button class="menu-toggle" id="menuToggle">☰</button>
            <div class="header-title">HOD Dashboard - ${hod.branch}</div>
        </div>
        <div class="header-right">
            <div class="user-profile" id="userProfileBtn">
                <div class="user-avatar">${hod.hodName.charAt(0)}</div>
                <div class="user-info">
                    <span>${hod.hodName}</span>
                </div>
            </div>
        </div>
    </header>

    <div class="dropdown-menu" id="userDropdown">
        <div class="dropdown-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
    </div>

    <script>
        document.getElementById('userProfileBtn').addEventListener('click', function(e) {
            e.stopPropagation();
            document.getElementById('userDropdown').classList.toggle('show');
        });
        document.addEventListener('click', function() {
            document.getElementById('userDropdown').classList.remove('show');
        });
    </script>
</body>
</html>