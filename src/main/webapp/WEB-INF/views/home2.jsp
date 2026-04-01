<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Placement System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('${pageContext.request.contextPath}/images1/deim.jpeg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
            line-height: 1.6;
        }

        /* Navigation */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 10%;
            background: rgba(30, 30, 164, 0.9);
            backdrop-filter: blur(5px);
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
            padding: 5px 0;
            border-bottom: 2px solid transparent;
        }

        .nav-links a:hover {
            color: #ffd700;
            border-bottom-color: #ffd700;
        }

        /* Hero Section */
        .hero {
            text-align: center;
            padding: 100px 20px;
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            transition: transform 0.3s, background 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: #27ae60;
            color: white;
        }

        .btn-primary:hover {
            background: #229954;
            transform: translateY(-3px);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid white;
            color: white;
        }

        .btn-outline:hover {
            background: white;
            color: #2c3e50;
            transform: translateY(-3px);
        }

        /* Stats Section */
        .stats {
            padding: 60px 10%;
            background: rgba(0, 0, 0, 0.7);
        }

        .stats h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 40px;
        }

        .stats-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            padding: 30px;
            width: 220px;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.2);
        }

        .stat-card h3 {
            font-size: 2.5rem;
            color: #ffd700;
            margin-bottom: 10px;
        }

        .stat-card p {
            font-size: 1rem;
        }

        /* Recruiters Section */
        .recruiters {
            padding: 60px 10%;
            background: rgba(30, 30, 164, 0.8);
        }

        .recruiters h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 40px;
        }

        .recruiter-logos {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .logo-box {
            background: white;
            color: #2c3e50;
            width: 160px;
            height: 90px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: transform 0.3s;
        }

        .logo-box:hover {
            transform: scale(1.1);
        }

        /* Footer */
        .footer {
            background: #0b1a33;
            color: #ccc;
            padding: 40px 10% 20px;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 30px;
        }

        .footer-section {
            flex: 1;
            min-width: 200px;
        }

        .footer-section h3 {
            color: #ffd700;
            margin-bottom: 15px;
        }

        .footer-section p, .footer-section a {
            color: #ccc;
            text-decoration: none;
            line-height: 1.8;
        }

        .footer-section a:hover {
            color: #ffd700;
        }

        .copyright {
            text-align: center;
            border-top: 1px solid #2a3f5e;
            padding-top: 20px;
            font-size: 0.9rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                padding: 15px;
            }
            .hero h1 {
                font-size: 2rem;
            }
            .stats, .recruiters {
                padding: 40px 5%;
            }
            .stat-card {
                width: 180px;
                padding: 20px;
            }
            .logo-box {
                width: 130px;
                height: 80px;
            }
        }

        @media (max-width: 480px) {
            .hero h1 {
                font-size: 1.8rem;
            }
            .btn {
                padding: 8px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="logo">🎓 CPS</div>
        <div class="nav-links">
            <a href="#home">Home</a>
            <a href="#stats">Stats</a>
            <a href="#recruiters">Recruiters</a>
            <a href="#contact">Contact</a>
            <a href="${pageContext.request.contextPath}/studentlogin">Student</a>
            <a href="${pageContext.request.contextPath}/facultylogin">Faculty</a>
            <a href="${pageContext.request.contextPath}/hodlogin">HOD</a>
            <a href="${pageContext.request.contextPath}/adminlogin">Admin</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <h1>Welcome to College Placement System</h1>
        <p>Your gateway to dream careers. Connect with top recruiters, track placements, and achieve success.</p>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/studentlogin" class="btn btn-primary">Student Login</a>
            <a href="${pageContext.request.contextPath}/studentsingup" class="btn btn-outline">Student Signup</a>
        </div>
    </section>

    <!-- Stats Section -->
    <section id="stats" class="stats">
        <h2>Placement Highlights</h2>
        <div class="stats-container">
            <div class="stat-card">
                <h3>1200+</h3>
                <p>Students Registered</p>
            </div>
            <div class="stat-card">
                <h3>850+</h3>
                <p>Students Placed</p>
            </div>
            <div class="stat-card">
                <h3>75+</h3>
                <p>Companies Visited</p>
            </div>
            <div class="stat-card">
                <h3>18 LPA</h3>
                <p>Highest Package</p>
            </div>
        </div>
    </section>

    <!-- Recruiters Section -->
    <section id="recruiters" class="recruiters">
        <h2>Our Top Recruiters</h2>
        <div class="recruiter-logos">
            <div class="logo-box">TCS</div>
            <div class="logo-box">Infosys</div>
            <div class="logo-box">Wipro</div>
            <div class="logo-box">Accenture</div>
            <div class="logo-box">Amazon</div>
            <div class="logo-box">Microsoft</div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact" class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>Email: placement@college.edu</p>
                <p>Phone: +91 123 456 7890</p>
                <p>Address: College Road, University Campus, City - 123456</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <p><a href="${pageContext.request.contextPath}/studentlogin">Student Login</a></p>
                <p><a href="${pageContext.request.contextPath}/facultylogin">Faculty Login</a></p>
                <p><a href="${pageContext.request.contextPath}/hodlogin">HOD Login</a></p>
                <p><a href="${pageContext.request.contextPath}/adminlogin">Admin Login</a></p>
            </div>
            <div class="footer-section">
                <h3>Follow Us</h3>
                <p>Facebook</p>
                <p>Twitter</p>
                <p>LinkedIn</p>
                <p>Instagram</p>
            </div>
        </div>
        <div class="copyright">
            &copy; 2026 College Placement System. All rights reserved.
        </div>
    </footer>

    <!-- Smooth scrolling for anchor links -->
    <script>
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });
    </script>
</body>
</html>