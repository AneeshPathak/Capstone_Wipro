<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Customer Login - MyPizzaProject</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="app-header">
    <div class="brand">My Pizzaria</div>
    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/dashboard">Home</a>
        <a href="${pageContext.request.contextPath}/login">Customer Login</a>
        <a href="${pageContext.request.contextPath}/register">Register</a>
        <a href="${pageContext.request.contextPath}/admin/login">Admin</a>
        <button id="themeToggle" class="btn btn-secondary">🌙 Dark Mode</button>
    </nav>
</header>

<div class="page-wrapper page-auth">
    <div class="card">
        <div class="card-header">
            <h2>Customer Login</h2>
        </div>

        <form method="post" action="login">
            <div class="form-row">
                <label>Username</label>
                <input name="username" type="text"/>
            </div>
            <div class="form-row">
                <label>Password</label>
                <input name="password" type="password"/>
            </div>
            <button class="btn btn-primary" type="submit">Login</button>
        </form>

        <c:if test="${not empty error}">
            <p class="message-error">${error}</p>
        </c:if>
        <c:if test="${not empty success}">
            <p class="message-success">${success}</p>
        </c:if>

        <p style="margin-top:16px;">
            <span class="text-muted">New customer?</span>
            <a href="${pageContext.request.contextPath}/register">Register here</a>
        </p>
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