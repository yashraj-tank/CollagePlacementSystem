<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Design Engineering College</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('images1/deim.jpeg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
            line-height: 1.6;
        }

        /* Header / Navigation */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 10%;
            background-color: rgba(52, 152, 219, 0.9);
            backdrop-filter: blur(5px);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #fff;
        }

        .nav-links {
            display: flex;
            gap: 30px;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #ffd700;
        }

        /* Hero Section */
        .hero {
            text-align: center;
            padding: 100px 20px;
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 40px;
            opacity: 0.9;
        }

        /* Cards Section */
        .services {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            padding: 50px 10%;
        }

        .card {
            background: rgba(52, 152, 219, 0.85);
            backdrop-filter: blur(5px);
            border-radius: 15px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.4);
        }

        .card-icon {
            font-size: 50px;
            margin-bottom: 20px;
        }

        .card h3 {
            font-size: 24px;
            margin-bottom: 15px;
            color: #fff;
        }

        .card p {
            font-size: 14px;
            margin-bottom: 25px;
            opacity: 0.9;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.2s;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #27ae60;
            color: white;
        }

        .btn-primary:hover {
            background-color: #229954;
            transform: scale(1.05);
        }

        .btn-secondary {
            background-color: #2980b9;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #1f618d;
            transform: scale(1.05);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid #fff;
            color: #fff;
        }

        .btn-outline:hover {
            background-color: #fff;
            color: #333;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 30px;
            background-color: rgba(0,0,0,0.5);
            margin-top: 50px;
        }

        .footer p {
            opacity: 0.8;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                padding: 15px;
            }
            .hero h1 {
                font-size: 36px;
            }
            .services {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="logo">🎓 Design Engineering</div>
        <div class="nav-links">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#contact">Contact</a>
            <a href="#about">About</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <h1>Welcome to Design Engineering College</h1>
        <p>Empowering future engineers with cutting‑edge education and research. Access student, faculty, and administrative portals below.</p>
    </section>

    <!-- Services Cards -->
    <section class="services" id="services">
        <!-- Student Card -->
        <div class="card">
            <div class="card-icon">👨‍🎓</div>
            <h3>Student Portal</h3>
            <p>Register for courses, view results, and manage your profile.</p>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/studentsingup" class="btn btn-primary">Sign Up</a>
                <a href="${pageContext.request.contextPath}/studentlogin" class="btn btn-secondary">Login</a>
            </div>
        </div>

        <!-- Faculty Card -->
        <div class="card">
            <div class="card-icon">👩‍🏫</div>
            <h3>Faculty Portal</h3>
            <p>Manage classes, upload marks, and communicate with students.</p>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/facultysignup" class="btn btn-primary">Sign Up</a>
                <a href="${pageContext.request.contextPath}/facultylogin" class="btn btn-secondary">Login</a>
            </div>
        </div>

        <!-- HOD Card -->
        <div class="card">
            <div class="card-icon">👤</div>
            <h3>HOD Portal</h3>
            <p>Oversee department activities, faculty, and student progress.</p>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/hodsignup" class="btn btn-primary">Sign Up</a>
                <a href="${pageContext.request.contextPath}/hodlogin" class="btn btn-secondary">Login</a>
            </div>
        </div>

        <!-- Admin Card -->
        <div class="card">
            <div class="card-icon">⚙️</div>
            <h3>Admin Portal</h3>
            <p>Manage users, batches, branches, and system settings.</p>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/adminsignup" class="btn btn-primary">Sign Up</a>
                <a href="${pageContext.request.contextPath}/adminlogin" class="btn btn-secondary">Login</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer" id="contact">
        <p>© 2026 Design Engineering College. All rights reserved.</p>
        <p>📍 123 Education Street, Innovation City | 📞 +1 234 567 890 | ✉️ info@designeng.edu</p>
    </footer>
</body>
</html>