<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Dashboard - My Pizzaria</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="app-header">
    <div class="brand">MyPizzaria</div>
    <nav class="nav-links">
   
        <c:choose>
            <%-- ADMIN NAV --%>
            <c:when test="${not empty sessionScope.adminName}">
                <span>Admin: ${sessionScope.adminName}</span>
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/customers">Customers</a>
                <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
                <a href="${pageContext.request.contextPath}/admin/menu">Menu</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:when>

            
            <c:when test="${not empty sessionScope.customerName}">
                <span>${sessionScope.customerName}</span>
                <a href="${pageContext.request.contextPath}/dashboard">Home</a>
                <a href="${pageContext.request.contextPath}/customerInfo">Profile</a>
                <a href="${pageContext.request.contextPath}/customerOrders">Orders</a>
                <a href="${pageContext.request.contextPath}/placeOrderPage">Place Order</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:when>

            
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/dashboard">Home</a>
                <a href="${pageContext.request.contextPath}/login">Customer Login</a>
                <a href="${pageContext.request.contextPath}/register">Register</a>
                <a href="${pageContext.request.contextPath}/admin/login">Admin</a>
            </c:otherwise>
        </c:choose>
         <button id="themeToggle" class="btn btn-secondary">🌙 Dark Mode</button>
    </nav>
</header>

<div class="page-wrapper">
    <%--  ================= CUSTOMER DASHBOARD CARDS ================= --%>
    <c:if test="${not empty sessionScope.customerName}">
        <div class="page-title">
            <h2>Welcome, ${sessionScope.customerName}!</h2>
            <p class="text-muted">
                Use these quick actions to manage your account and pizza orders.
            </p>
        </div>

        <div class="card-grid">
            <a class="card card-link" href="${pageContext.request.contextPath}/customerInfo">
                <h3>Your Profile</h3>
                <p>View and update your saved contact details.</p>
            </a>

            <a class="card card-link" href="${pageContext.request.contextPath}/customerOrders">
                <h3>Your Orders</h3>
                <p>See all your past and current pizza orders.</p>
            </a>

            <a class="card card-link" href="${pageContext.request.contextPath}/placeOrderPage">
                <h3>Place Order</h3>
                <p>Browse the pizza menu and place a new order.</p>
            </a>
        </div>
    </c:if>

    <%-- ================= ADMIN DASHBOARD CARDS =================--%>
    <c:if test="${not empty sessionScope.adminName}">
        <div class="page-title">
            <h2>Admin Dashboard</h2>
            <p class="text-muted">
                Quickly jump to the main administration areas below.
            </p>
        </div>

        <div class="card-grid">
            <a class="card card-link" href="${pageContext.request.contextPath}/admin/customers">
                <h3>Customers</h3>
                <p>View all customers and their basic details.</p>
            </a>

            <a class="card card-link" href="${pageContext.request.contextPath}/admin/orders">
                <h3>Orders</h3>
                <p>Review open and historical orders.</p>
            </a>

            <a class="card card-link" href="${pageContext.request.contextPath}/admin/menu">
                <h3>Pizza Menu</h3>
                <p>Manage available pizzas and prices.</p>
            </a>
        </div>
    </c:if>

    <%-- ================= PUBLIC / GUEST LANDING ================= --%>
    <c:if test="${empty sessionScope.customerName and empty sessionScope.adminName}">
        <div class="page-title">
            <h2>Welcome to My Pizzaria 🍕</h2>
            <p class="text-muted">
                Please login or create an account to start ordering. Admins can use the Admin login.
            </p>
        </div>

        <div class="card-grid">
            <a class="card card-link" href="${pageContext.request.contextPath}/login">
                <h3>Customer Login</h3>
                <p>Sign in to view your profile, orders, and place pizzas.</p>
            </a>

            <a class="card card-link" href="${pageContext.request.contextPath}/register">
                <h3>New Customer</h3>
                <p>Create a new account and start ordering right away.</p>
            </a>

            <a class="card card-link" href="${pageContext.request.contextPath}/admin/login">
                <h3>Admin Login</h3>
                <p>Access the admin panel to manage menu, orders, and customers.</p>
            </a>
        </div>
    </c:if>
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
