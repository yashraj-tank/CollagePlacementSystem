<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        :root {
            --sidebar-width: 250px;
        }

        .student-sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            transition: transform 0.3s ease-in-out;
            z-index: 1050;
            box-shadow: 2px 0 10px rgba(0,0,0,0.2);
            transform: translateX(0);
        }

        .sidebar-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            position: relative;
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

        .close-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            font-size: 24px;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: none;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background 0.2s;
        }
        .close-btn:hover {
            background: rgba(255,255,255,0.3);
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
            width: 24px;
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
            padding: 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 12px;
            text-align: center;
            opacity: 0.6;
        }

        /* Overlay for mobile */
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1040;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .sidebar-overlay.active {
            display: block;
            opacity: 1;
        }

        @media (max-width: 768px) {
            .student-sidebar {
                transform: translateX(-100%);
                box-shadow: none;
            }
            .student-sidebar.active {
                transform: translateX(0);
                box-shadow: 2px 0 15px rgba(0,0,0,0.3);
            }
            .close-btn {
                display: flex;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar-overlay" id="sidebarOverlay"></div>
    <div class="student-sidebar" id="studentSidebar">
        <div class="sidebar-header">
            <button class="close-btn" id="closeSidebar">✕</button>
            <div style="font-size: 40px;">👨‍🎓</div>
            <h3>${student.branch}</h3>
            <p>Student: ${student.studentName}</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/student/dashboard" class="menu-item">
                <i>📊</i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/student/profile" class="menu-item">
                <i>👤</i>
                <span>My Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/student/companies" class="menu-item">
    			<i>🏢</i>
    			<span>Companies</span>
			</a>
        </div>
        <div class="sidebar-footer">
            <p>© 2026 Design Engineering</p>
        </div>
    </div>

    <script>
        (function() {
            const sidebar = document.getElementById('studentSidebar');
            const overlay = document.getElementById('sidebarOverlay');
            const closeBtn = document.getElementById('closeSidebar');
            const menuToggle = document.getElementById('menuToggle');

            function openSidebar() {
                sidebar.classList.add('active');
                overlay.classList.add('active');
                document.body.style.overflow = 'hidden';
            }

            function closeSidebar() {
                sidebar.classList.remove('active');
                overlay.classList.remove('active');
                document.body.style.overflow = '';
            }

            if (menuToggle) {
                menuToggle.addEventListener('click', function(e) {
                    e.stopPropagation();
                    if (sidebar.classList.contains('active')) {
                        closeSidebar();
                    } else {
                        openSidebar();
                    }
                });
            }

            if (closeBtn) {
                closeBtn.addEventListener('click', closeSidebar);
            }

            if (overlay) {
                overlay.addEventListener('click', closeSidebar);
            }

            window.addEventListener('resize', function() {
                if (window.innerWidth > 768) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            });

            // Highlight active menu
            const currentUrl = window.location.pathname;
            document.querySelectorAll('.menu-item').forEach(item => {
                if (item.getAttribute('href') === currentUrl) {
                    item.classList.add('active');
                }
            });
        })();
    </script>
</body>
</html>