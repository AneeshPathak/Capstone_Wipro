package com.aneesh.pizza.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final JdbcTemplate jdbc;

    public AdminController(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    private boolean isAdminLoggedIn(HttpSession session) {
        return session.getAttribute("adminId") != null;
    }

    //DASHBOARD 

    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) {
            return "redirect:/admin/login";
        }

        Integer customerCount = jdbc.queryForObject(
                "SELECT COUNT(*) FROM customers", Integer.class);
        Integer orderCount = jdbc.queryForObject(
                "SELECT COUNT(*) FROM orders", Integer.class);
        Integer pizzaCount = jdbc.queryForObject(
                "SELECT COUNT(*) FROM pizzas", Integer.class);

        model.addAttribute("adminName", session.getAttribute("adminName"));
        model.addAttribute("customerCount", customerCount);
        model.addAttribute("orderCount", orderCount);
        model.addAttribute("pizzaCount", pizzaCount);

        return "adminDashboard";
    }

    //  CUSTOMERS LIST 

    @GetMapping("/customers")
    public String viewCustomers(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) {
            return "redirect:/admin/login";
        }

        List<Map<String, Object>> customers =
                jdbc.queryForList("SELECT * FROM customers ORDER BY customer_id");

        model.addAttribute("customers", customers);
        return "adminCustomers";
    }

    //  ADMIN - DELETE CUSTOMER 

    @PostMapping("/customers/delete")
    public String deleteCustomer(@RequestParam("customer_id") int customerId,
                                 HttpSession session) {

        if (session.getAttribute("adminId") == null) {
            return "redirect:/admin/login";
        }

        // 1) find all orders for this customer
        List<Map<String, Object>> orders = jdbc.queryForList(
                "SELECT order_id FROM orders WHERE customer_id = ?",
                customerId
        );

        // 2) delete order_items for each order
        for (Map<String, Object> o : orders) {
            Object oidObj = o.get("order_id");
            if (oidObj == null) continue;

            int orderId = ((Number) oidObj).intValue();
            jdbc.update("DELETE FROM order_items WHERE order_id = ?", orderId);
        }

        // 3) delete orders for this customer
        jdbc.update("DELETE FROM orders WHERE customer_id = ?", customerId);

        // 4) finally delete the customer
        jdbc.update("DELETE FROM customers WHERE customer_id = ?", customerId);

        return "redirect:/admin/customers";
    }


    @GetMapping("/orders")
    public String viewOrders(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) {
            return "redirect:/admin/login";
        }

        String sql =
            "SELECT o.*, c.customer_name " +
            "FROM orders o " +
            "JOIN customers c ON o.customer_id = c.customer_id " +
            "ORDER BY o.order_date DESC";

        List<Map<String, Object>> orders = jdbc.queryForList(sql);
        model.addAttribute("orders", orders);
        return "adminOrders";
    }

    //  MENU MANAGEMENT 

    @GetMapping("/menu")
    public String viewMenu(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) {
            return "redirect:/admin/login";
        }

        List<Map<String, Object>> pizzas =
                jdbc.queryForList("SELECT * FROM pizzas ORDER BY pizza_id");

        model.addAttribute("pizzas", pizzas);
        return "adminMenu";
    }

    @PostMapping("/menu/add")
    public String addPizza(@RequestParam("name") String name,
                           @RequestParam("size") String size,
                           @RequestParam("base_price") BigDecimal basePrice,
                           HttpSession session) {

        if (!isAdminLoggedIn(session)) {
            return "redirect:/admin/login";
        }

        jdbc.update("INSERT INTO pizzas (name, size, base_price, price) VALUES (?,?,?,?)",
                name, size, basePrice, basePrice);

        return "redirect:/admin/menu";
    }

    @PostMapping("/menu/delete")
    public String deletePizza(@RequestParam("pizza_id") int pizzaId,
                              HttpSession session) {

        if (!isAdminLoggedIn(session)) {
            return "redirect:/admin/login";
        }

        // NOTE: simple delete; assumes no foreign key constraint errors
        jdbc.update("DELETE FROM order_items WHERE pizza_id = ?", pizzaId);
        jdbc.update("DELETE FROM pizzas WHERE pizza_id = ?", pizzaId);

        return "redirect:/admin/menu";
    }

    @PostMapping("/orders/updateStatus")
    public String updateOrderStatus(@RequestParam("order_id") int orderId,
                                    @RequestParam("status") String status,
                                    HttpSession session) {

        if (!isAdminLoggedIn(session)) {
            return "redirect:/admin/login";
        }

        // optional: validate status value if you want
        jdbc.update("UPDATE orders SET status = ? WHERE order_id = ?", status, orderId);

        return "redirect:/admin/orders";
    }
}
