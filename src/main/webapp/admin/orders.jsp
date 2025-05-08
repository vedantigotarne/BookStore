<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Account</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
   <jsp:include page="header.jsp" />




    <!-- Main Content -->
    <div class="container my-5">
        <h1 class="text-center">Welcome, <span class="text-primary">User!</span></h1>
        <h2 class="text-center my-4">Your Order History</h2>

        <!-- Conditional Logic -->
        <c:choose>
            <c:when test="${empty orderList}">
                <div class="alert alert-warning text-center">
                    <strong>No orders found.</strong> Start browsing and add books to your cart!
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered text-center">
                        <thead class="thead-dark">
                            <tr>
                                <th>Order ID</th>
                                <th>Book Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Order Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td>${order.bookName}</td>
                                    <td>${order.quantity}</td>
                                    <td>&#8377; ${order.price}</td>
                                    <td>${order.orderDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="text-center mt-4">
            <a href="logout.jsp" class="btn btn-danger">Logout</a>
        </div>
    </div>

    
   
    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
