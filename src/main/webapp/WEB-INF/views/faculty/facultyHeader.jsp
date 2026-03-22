<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        :root {
            --sidebar-width: 250px;
        }

        .faculty-header {
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
            left: var(--sidebar-width);    /* matches sidebar width on desktop */
            z-index: 100;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: left 0.3s ease;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
            flex: 1;
        }

        .menu-toggle {
            background: none;
            border: none;
            color: white;
            font-size: 28px;
            cursor: pointer;
            display: none;         /* hidden on desktop */
            width: 40px;
            height: 40px;
            border-radius: 5px;
            transition: background 0.2s;
        }
        .menu-toggle:hover {
            background-color: rgba(255,255,255,0.1);
        }

        .header-title {
            font-size: 1.3rem;
            font-weight: bold;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .header-right {
            display: flex;
            align-items: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 5px 15px;
            border-radius: 30px;
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
            font-size: 1.2rem;
        }

        .user-name {
            display: inline-block;
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .dropdown-menu {
            position: absolute;
            top: 60px;
            right: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            display: none;
            z-index: 1000;
            min-width: 180px;
            overflow: hidden;
        }
        .dropdown-menu.show {
            display: block;
        }
        .dropdown-item {
            padding: 12px 20px;
            color: #333;
            text-decoration: none;
            display: block;
            transition: background 0.2s;
            border-bottom: 1px solid #f0f0f0;
        }
        .dropdown-item:last-child {
            border-bottom: none;
        }
        .dropdown-item:hover {
            background-color: #f5f5f5;
        }

        /* ---------- Mobile Styles ---------- */
        @media (max-width: 768px) {
            .faculty-header {
                left: 0;                /* full width when sidebar hidden */
            }
            .menu-toggle {
                display: flex;          /* show hamburger */
                align-items: center;
                justify-content: center;
            }
            .header-title {
                font-size: 1rem;
                max-width: calc(100vw - 140px);
            }
        }

        @media (max-width: 480px) {
            .user-name {
                display: none;          /* hide name on very small screens */
            }
            .user-avatar {
                width: 35px;
                height: 35px;
            }
            .header-title {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <header class="faculty-header" id="facultyHeader">
        <div class="header-left">
            <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu">☰</button>
            <div class="header-title">Faculty Dashboard - ${faculty.branch}</div>
        </div>
        <div class="header-right">
            <div class="user-profile" id="userProfileBtn">
                <div class="user-avatar">${faculty.facultyName.charAt(0)}</div>
                <span class="user-name">${faculty.facultyName}</span>
            </div>
        </div>
    </header>

    <div class="dropdown-menu" id="userDropdown">
        <div style="height:1px; background:#ddd; margin:5px 0;"></div>
        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
    </div>

    <script>
        (function() {
            const profileBtn = document.getElementById('userProfileBtn');
            const dropdown = document.getElementById('userDropdown');
            profileBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                dropdown.classList.toggle('show');
            });
            document.addEventListener('click', function() {
                dropdown.classList.remove('show');
            });
            dropdown.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        })();
    </script>
</body>
</html>