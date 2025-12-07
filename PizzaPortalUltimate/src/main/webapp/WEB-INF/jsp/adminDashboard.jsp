<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Admin Dashboard - My Pizzaria</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="app-header">
    <div class="brand">My Pizzaria Admin</div>
    <nav class="nav-links">
        <span>Admin: ${sessionScope.adminName}</span>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/customers">Customers</a>
        <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
        <a href="${pageContext.request.contextPath}/admin/menu">Menu</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <button id="themeToggle" class="btn btn-secondary">🌙 Dark Mode</button>
    </nav>
</header>

<div class="page-wrapper">
    <h1>Welcome, ${sessionScope.adminName}!</h1>
    <p class="text-muted">
        Use these quick actions to manage customers, orders, and the pizza menu.
    </p>

    <div class="card-grid">

        <!-- Customers card -->
        <a class="card" href="${pageContext.request.contextPath}/admin/customers">
            <h2>Customers</h2>
            <p>View all registered customers and their details.</p>
        </a>

        <!-- Orders card -->
        <a class="card" href="${pageContext.request.contextPath}/admin/orders">
            <h2>Orders</h2>
            <p>See new, in-progress, and completed pizza orders.</p>
        </a>

        <!-- Menu card -->
        <a class="card" href="${pageContext.request.contextPath}/admin/menu">
            <h2>Menu</h2>
            <p>Manage pizza items, prices, and availability.</p>
        </a>

    </div>
</div>
<script>
    const toggleBtn = document.getElementById("themeToggle");

    if (localStorage.getItem("theme") === "dark") {
        document.body.classList.add("dark");
        toggleBtn.innerText = "☀️ Light Mode";
    }

    toggleBtn.addEventListener("click", () => {
        document.body.classList.toggle("dark");

        if (document.body.classList.contains("dark")) {
            localStorage.setItem("theme", "dark");
            toggleBtn.innerText = "☀️ Light Mode";
        } else {
            localStorage.setItem("theme", "light");
            toggleBtn.innerText = "🌙 Dark Mode";
        }
    });
</script>

</body>
</html>
