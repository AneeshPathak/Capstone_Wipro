<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Customer Info - My Pizzaria</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="app-header">
    <div class="brand">My Pizzaria</div>
    <nav class="nav-links">
        <span>${sessionScope.customerName}</span>
        <a href="${pageContext.request.contextPath}/dashboard">Home</a>
        <a href="${pageContext.request.contextPath}/customerInfo">Profile</a>
        <a href="${pageContext.request.contextPath}/customerOrders">Orders</a>
        <a href="${pageContext.request.contextPath}/placeOrderPage">Place Order</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <button id="themeToggle" class="btn btn-secondary">🌙 Dark Mode</button>
    </nav>
</header>

<div class="page-wrapper">
    <div class="card">
        <div class="card-header">
            <h2>Customer Info</h2>
        </div>

        <c:if test="${empty customer}">
            <p>No information available.</p>
        </c:if>

        <c:if test="${not empty customer}">
		    <p><strong>ID:</strong> ${customer.customer_id}</p>
		    <p><strong>Name:</strong> ${customer.customer_name}</p>
		    <p><strong>Phone:</strong> ${customer.phone}</p>
		    <p><strong>Email:</strong> ${customer.email}</p>
		    <p><strong>Address:</strong> ${customer.address}</p>
		
		    <p>
		        <a href="${pageContext.request.contextPath}/customerInfo/edit"
		           class="btn btn-primary">
		            Edit Profile
		        </a>
		    </p>
		</c:if>

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