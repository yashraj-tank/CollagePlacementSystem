<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Reports</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; }
        .main-content { margin-left: 250px; margin-top: 70px; padding: 30px; background-color: #f4f6f9; min-height: calc(100vh - 70px); }
        .reports-container { background-color: #3498db; color: #fff; padding: 30px; border-radius: 15px; max-width: 1200px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 25px; border-bottom: 2px solid rgba(255,255,255,0.3); padding-bottom: 15px; }
        .chart-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 30px; margin-top: 20px; }
        .chart-card { background: white; border-radius: 10px; padding: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .chart-card h3 { color: #333; text-align: center; margin-bottom: 15px; }
        canvas { max-height: 300px; width: 100%; }
        @media (max-width: 768px) { .main-content { margin-left: 0; } .chart-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <jsp:include page="leftsidebar.jsp" />

    <div class="main-content">
        <div class="reports-container">
            <h2>Admin Reports</h2>
            <div class="chart-grid">
                <!-- Students by Branch -->
                <div class="chart-card">
                    <h3>Students by Branch</h3>
                    <canvas id="studentsByBranchChart"></canvas>
                </div>

                <!-- Applications by Company -->
                <div class="chart-card">
                    <h3>Applications by Company</h3>
                    <canvas id="appsByCompanyChart"></canvas>
                </div>

                <!-- Placement Status -->
                <div class="chart-card">
                    <h3>Placement Status</h3>
                    <canvas id="placementStatusChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Data from JSP model
        const studentsByBranchData = [
            <c:forEach var="entry" items="${studentsByBranch}" varStatus="status">
                { branch: '${entry[0]}', count: ${entry[1]} }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        const appsByCompanyData = [
            <c:forEach var="entry" items="${appsByCompany}" varStatus="status">
                { company: '${entry[0]}', count: ${entry[1]} }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        const verified = ${verified};
        const rejected = ${rejected};
        const pending = ${pending};

        // Students by Branch Bar Chart
        const branchLabels = studentsByBranchData.map(item => item.branch);
        const branchCounts = studentsByBranchData.map(item => item.count);
        new Chart(document.getElementById('studentsByBranchChart'), {
            type: 'bar',
            data: {
                labels: branchLabels,
                datasets: [{
                    label: 'Number of Students',
                    data: branchCounts,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: { y: { beginAtZero: true } }
            }
        });

        // Applications by Company Bar Chart
        const companyLabels = appsByCompanyData.map(item => item.company);
        const appCounts = appsByCompanyData.map(item => item.count);
        new Chart(document.getElementById('appsByCompanyChart'), {
            type: 'bar',
            data: {
                labels: companyLabels,
                datasets: [{
                    label: 'Number of Applications',
                    data: appCounts,
                    backgroundColor: 'rgba(75, 192, 192, 0.5)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: { y: { beginAtZero: true } }
            }
        });

        // Placement Status Pie Chart (3 categories)
        new Chart(document.getElementById('placementStatusChart'), {
            type: 'pie',
            data: {
                labels: ['Verified', 'Rejected', 'Pending'],
                datasets: [{
                    data: [verified, rejected, pending],
                    backgroundColor: ['#27ae60', '#e74c3c', '#f39c12'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true
            }
        });
    </script>
</body>
</html>