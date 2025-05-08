<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - Book Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Order Confirmation Section -->
    <section class="order-confirmation-section py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card border-0 shadow">
                        <div class="card-body p-5 text-center">
                            <div class="mb-4">
                                <i class="fas fa-check-circle text-success fa-4x"></i>
                            </div>
                            <h1 class="display-4 mb-4">Thank You!</h1>
                            <p class="lead mb-4">Your order has been placed successfully.</p>
                            
                            <div class="alert alert-light mb-4">
                                <div class="row">
                                    <div class="col-md-6 text-md-start">
                                        <p class="mb-1"><strong>Order ID:</strong> #${order.id}</p>
                                        <p class="mb-1"><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="MMMM dd, yyyy HH:mm" /></p>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <p class="mb-1"><strong>Payment Method:</strong> ${order.paymentMethod}</p>
                                        <p class="mb-1"><strong>Order Status:</strong> <span class="badge bg-info">${order.orderStatus}</span></p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card mb-4">
                                <div class="card-header bg-light">
                                    <h5 class="mb-0">Order Details</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Item</th>
                                                    <th>Quantity</th>
                                                    <th>Price</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${order.orderItems}" var="item">
                                                    <tr>
                                                        <td>
                                                            <c:if test="${not empty item.book}">
                                                                <strong>${item.book.title}</strong><br>
                                                                <small class="text-muted">by ${item.book.author}</small>
                                                            </c:if>
                                                        </td>
                                                        <td>${item.quantity}</td>
                                                        <td>$${item.price}</td>
                                                        <td>$${item.subtotal}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                                    <td><strong>$${order.totalAmount}</strong></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card mb-4">
                                <div class="card-header bg-light">
                                    <h5 class="mb-0">Shipping Information</h5>
                                </div>
                                <div class="card-body">
                                    <p class="mb-0">${order.shippingAddress}</p>
                                </div>
                            </div>
                            
                            <p class="mb-4">A confirmation email has been sent to your email address.</p>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                                <a href="home" class="btn btn-primary">
                                    <i class="fas fa-home me-2"></i>Back to Home
                                </a>
                                <a href="user/orders" class="btn btn-outline-primary">
                                    <i class="fas fa-list me-2"></i>View Orders
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
</body>
</html> 