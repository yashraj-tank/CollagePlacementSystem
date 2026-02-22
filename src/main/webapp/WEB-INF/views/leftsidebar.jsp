<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            transition: transform 0.3s ease-in-out;
            z-index: 1050;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        /* Mobile overlay */
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1040;
            transition: opacity 0.3s;
        }

        .sidebar-overlay.active {
            display: block;
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

        .menu-divider {
            height: 1px;
            background-color: rgba(255,255,255,0.1);
            margin: 15px 0;
        }

        .menu-title {
            padding: 10px 25px;
            font-size: 12px;
            text-transform: uppercase;
            opacity: 0.6;
            letter-spacing: 1px;
        }

        .sidebar-footer {
            padding: 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 12px;
            text-align: center;
            opacity: 0.6;
        }

        /* Close button inside sidebar for mobile */
        .sidebar-close {
            display: none;
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            font-size: 20px;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            align-items: center;
            justify-content: center;
        }

        /* Responsive behavior */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                box-shadow: none;
            }
            .sidebar.active {
                transform: translateX(0);
                box-shadow: 2px 0 10px rgba(0,0,0,0.2);
            }
            .sidebar-close {
                display: flex;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar Overlay (mobile only) -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <button class="sidebar-close" id="sidebarClose">✕</button>
        <div class="sidebar-header">
            <div style="font-size: 40px;">🎓</div>
            <h3>College Admin</h3>
            <p>Design Engineering</p>
        </div>

        <div class="sidebar-menu">
            <div class="menu-title">MAIN</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
                <i>📊</i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/studentsingup" class="menu-item">
                <i>👥</i>
                <span>Add Student</span>
            </a>
            <a href="${pageContext.request.contextPath}/filterStudents" class="menu-item">
                <i>📋</i>
                <span>Student List</span>
                <span class="menu-badge">${studentCount}</span>
            </a>

            <div class="menu-divider"></div>
            <div class="menu-title">ACADEMIC</div>
            
            <a href="${pageContext.request.contextPath}/listbatch" class="menu-item">
                <i>📅</i>
                <span>Batches</span>
                <span class="menu-badge">${batchCount}</span>
            </a>
            <a href="${pageContext.request.contextPath}/listbranch" class="menu-item">
                <i>🏫</i>
                <span>Branches</span>
                <span class="menu-badge">${branchCount}</span>
            </a>
            <a href="${pageContext.request.contextPath}/listfaculty" class="menu-item">
                <i>👨‍🏫</i>
                <span>Faculty</span>
                <span class="menu-badge">${facultyCount}</span>
            </a>
            <a href="${pageContext.request.contextPath}/listhod" class="menu-item">
                <i>👤</i>
                <span>HODs</span>
                <span class="menu-badge">${hodCount}</span>
            </a>

            <div class="menu-divider"></div>
            <div class="menu-title">REPORTS</div>
            
            <a href="#" class="menu-item">
                <i>📈</i>
                <span>Attendance</span>
            </a>
            <a href="#" class="menu-item">
                <i>📊</i>
                <span>Performance</span>
            </a>
            <a href="#" class="menu-item">
                <i>💰</i>
                <span>Fees</span>
            </a>

            <div class="menu-divider"></div>
            <div class="menu-title">SETTINGS</div>
            
            <a href="#" class="menu-item">
                <i>⚙️</i>
                <span>Settings</span>
            </a>
            <a href="#" class="menu-item">
                <i>❓</i>
                <span>Help</span>
            </a>
        </div>

        <div class="sidebar-footer">
            <p>© 2026 Design Engineering</p>
            <p>Version 1.0.0</p>
        </div>
    </div>

    <script>
        (function() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            const closeBtn = document.getElementById('sidebarClose');
            
            // Function to open sidebar
            function openSidebar() {
                sidebar.classList.add('active');
                overlay.classList.add('active');
                document.body.style.overflow = 'hidden'; // Prevent background scrolling
                // Adjust main content margin if needed (optional, handled by CSS)
                const mainContent = document.querySelector('.main-content');
                if (mainContent) {
                    mainContent.style.marginLeft = '250px';
                }
            }

            // Function to close sidebar
            function closeSidebar() {
                sidebar.classList.remove('active');
                overlay.classList.remove('active');
                document.body.style.overflow = '';
                const mainContent = document.querySelector('.main-content');
                if (mainContent && window.innerWidth <= 768) {
                    mainContent.style.marginLeft = '0';
                }
            }

            // Toggle sidebar when menu button in header is clicked
            // Assuming header has a button with id="menuToggle" (as in previous header.jsp)
            const menuToggle = document.getElementById('menuToggle');
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

            // Close sidebar when close button is clicked
            if (closeBtn) {
                closeBtn.addEventListener('click', closeSidebar);
            }

            // Close sidebar when overlay is clicked
            overlay.addEventListener('click', closeSidebar);

            // Handle window resize: if screen becomes larger than mobile, remove active class and reset margin
            window.addEventListener('resize', function() {
                if (window.innerWidth > 768) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                    const mainContent = document.querySelector('.main-content');
                    if (mainContent) {
                        mainContent.style.marginLeft = '250px'; // Ensure correct margin on desktop
                    }
                } else {
                    // On mobile, if sidebar is closed, ensure main content margin is 0
                    if (!sidebar.classList.contains('active')) {
                        const mainContent = document.querySelector('.main-content');
                        if (mainContent) {
                            mainContent.style.marginLeft = '0';
                        }
                    }
                }
            });

            // Highlight active menu based on current URL
            const currentUrl = window.location.pathname;
            const menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach(item => {
                const href = item.getAttribute('href');
                if (href && (currentUrl === href || currentUrl.startsWith(href + '/'))) {
                    item.classList.add('active');
                }
            });

            // On page load, set initial main content margin based on screen size
            const mainContent = document.querySelector('.main-content');
            if (mainContent) {
                if (window.innerWidth > 768) {
                    mainContent.style.marginLeft = '250px';
                } else {
                    mainContent.style.marginLeft = '0';
                }
            }
        })();
    </script>
</body>
</html>