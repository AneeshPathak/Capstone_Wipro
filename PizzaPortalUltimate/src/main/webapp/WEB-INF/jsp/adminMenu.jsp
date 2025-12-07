<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Admin - Manage Menu</title>
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
    <div class="card">
        <div class="card-header">
            <h2>Manage Menu</h2>
        </div>

        <h3>Existing Pizzas</h3>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Size</th>
                    <th>Base Price</th>
                    <th class="text-right">Actions</th>
                </tr>
                <c:forEach var="p" items="${pizzas}">
                    <tr>
                        <td>${p.pizza_id}</td>
                        <td>${p.name}</td>
                        <td>${p.size}</td>
                        <td>₹ ${p.base_price}</td>
                        <td class="text-right">
                            <form method="post" action="${pageContext.request.contextPath}/admin/menu/delete" style="display:inline">
                                <input type="hidden" name="pizza_id" value="${p.pizza_id}"/>
                                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <h3 style="margin-top:24px;">Add New Pizza</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/menu/add">
            <div class="form-row">
                <label>Name</label>
                <input name="name" type="text"/>
            </div>
            <div class="form-row">
                <label>Size</label>
                <input name="size" type="text" placeholder="SMALL / MEDIUM / LARGE"/>
            </div>
            <div class="form-row">
                <label>Base Price</label>
                <input name="base_price" type="number" step="0.01"/>
            </div>
            <button type="submit" class="btn btn-primary">Add Pizza</button>
        </form>
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