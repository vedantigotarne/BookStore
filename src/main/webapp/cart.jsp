<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Book Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Cart Section -->
    <section class="cart-section py-5">
        <div class="container">
            <h1 class="mb-4">Shopping Cart</h1>
            
            <c:choose>
                <c:when test="${empty cart}">
                    <!-- Empty Cart -->
                    <div class="text-center py-5">
                        <i class="fas fa-shopping-cart fa-4x mb-3 text-muted"></i>
                        <h3>Your cart is empty</h3>
                        <p class="text-muted mb-4">Looks like you haven't added any books to your cart yet.</p>
                        <a href="books.jsp" class="btn btn-primary">Browse Books</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Cart Items -->
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card mb-4">
                                <div class="card-header bg-white">
                                    <h5 class="mb-0">Cart Items (${cart.size()})</h5>
                                </div>
                                <div class="card-body">
                                    <c:forEach items="${cart}" var="item" varStatus="status">
                                        <div class="row cart-item align-items-center ${status.last ? '' : 'border-bottom pb-3 mb-3'}">
                                            <div class="col-md-2">
                                                <img src="${item.book.imageUrl}" alt="${item.book.title}" class="img-fluid rounded">
                                            </div>
                                            <div class="col-md-4">
                                                <h5 class="mb-1">${item.book.title}</h5>
                                                <p class="text-muted mb-0">by ${item.book.author}</p>
                                            </div>
                                            <div class="col-md-2">
                                                <span class="fw-bold">$${item.book.price}</span>
                                            </div>
                                            <div class="col-md-2">
                                                <form action="cart" method="post" class="cart-update-form">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="bookId" value="${item.book.id}">
                                                    <div class="input-group quantity-control">
                                                        <button type="button" class="btn btn-sm btn-outline-secondary decrease-qty">
                                                            <i class="fas fa-minus"></i>
                                                        </button>
                                                        <input type="number" name="quantity" class="form-control form-control-sm text-center quantity-input" 
                                                               value="${item.quantity}" min="1" max="99">
                                                        <button type="button" class="btn btn-sm btn-outline-secondary increase-qty">
                                                            <i class="fas fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="col-md-2 text-end">
                                                <span class="fw-bold d-block mb-2">$${item.subtotal}</span>
                                                <form action="cart" method="post">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="bookId" value="${item.book.id}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger">
                                                        <i class="fas fa-trash-alt"></i> Remove
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            
                            <!-- Continue Shopping and Clear Cart -->
                            <div class="d-flex justify-content-between">
                                <a href="books" class="btn btn-outline-primary">
                                    <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                                </a>
                                <form action="cart" method="post">
                                    <input type="hidden" name="action" value="clear">
                                    <button type="submit" class="btn btn-outline-danger">
                                        <i class="fas fa-trash-alt me-2"></i>Clear Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                        
                        <!-- Order Summary -->
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-header bg-white">
                                    <h5 class="mb-0">Order Summary</h5>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-3">
                                        <span>Subtotal:</span>
                                        <span class="fw-bold">$${total}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span>Shipping:</span>
                                        <span>Free</span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between mb-4">
                                        <span class="fw-bold">Total:</span>
                                        <span class="fw-bold fs-5">$${total}</span>
                                    </div>
                                    <div class="d-grid">
                                        <a href="checkout" class="btn btn-primary">
                                            Proceed to Checkout
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
</body>
</html> 