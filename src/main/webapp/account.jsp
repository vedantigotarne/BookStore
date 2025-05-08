<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="bookstore.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login");
        return;
    }
    request.setAttribute("user", user); // VERY IMPORTANT!
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Book Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Profile Section -->
    <section class="profile-section py-5">
        <div class="container">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-lg-3 mb-4 mb-lg-0">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <div class="text-center mb-4">
                                <div class="avatar-circle mb-3">
                                    <c:choose>
                                        <c:when test="${not empty user.profileImage}">
                                            <img src="${user.profileImage}" alt="Profile Picture" class="img-fluid rounded-circle">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="avatar-initials">
                                            	${fn:substring(user.username, 0, 1)}
                                                <!--  ${user.username.charAt(0)}${user.fullName.charAt(0)}-->
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <h5 class="mb-0">${user.username} ${user.fullName}</h5>
                                <p class="text-muted small">Member since <fmt:formatDate value="${user.registrationDate}" pattern="MMMM yyyy" /></p>
                            </div>
                            
                            <div class="list-group list-group-flush">
                                <a href="${pageContext.request.contextPath}/user/profile" class="list-group-item list-group-item-action active">
                                    <i class="fas fa-user me-2"></i> My Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/user/orders" class="list-group-item list-group-item-action">
                                    <i class="fas fa-shopping-bag me-2"></i> My Orders
                                </a>
                                <a href="${pageContext.request.contextPath}/user/wishlist" class="list-group-item list-group-item-action">
                                    <i class="fas fa-heart me-2"></i> Wishlist
                                </a>
                                <a href="${pageContext.request.contextPath}/user/addresses" class="list-group-item list-group-item-action">
                                    <i class="fas fa-map-marker-alt me-2"></i> Addresses
                                </a>
                                <a href="${pageContext.request.contextPath}/user/settings" class="list-group-item list-group-item-action">
                                    <i class="fas fa-cog me-2"></i> Account Settings
                                </a>
                                <c:if test="${user.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action">
                                        <i class="fas fa-tachometer-alt me-2"></i> Admin Dashboard
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger">
                                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Main Content -->
                <div class="col-lg-9">
                    <!-- Error Alert -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <!-- Success Alert -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                            ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <!-- Profile Info -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-white py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Personal Information</h5>
                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="collapse" data-bs-target="#editProfileForm">
                                    <i class="fas fa-edit me-2"></i>Edit
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
				            <h3>My Profile</h3>
				            <table class="table table-bordered mt-3">
				                <tr><th>Username</th><td>${user.username}</td></tr>
				                <tr><th>Email</th><td>${user.email}</td></tr>
				                <tr><th>Full Name</th><td>${user.fullName}</td></tr>
				                <tr><th>Phone</th><td>${user.phone}</td></tr>
				            </table>
				        </div>
                        
				   
    
                            
                            <!-- Edit Profile Form -->
                        <div class="collapse mt-4" id="editProfileForm">
                            <hr>
                            <h6 class="mb-3">Edit Profile Information</h6>
                            <form action="${pageContext.request.contextPath}/user/update-profile" method="post" class="needs-validation" novalidate>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="username" class="form-label">User Name</label>
                                        <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                                        <div class="invalid-feedback">
                                            Please enter your User name.
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">                                            <label for="fullname" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="fullame" name="fullname" value="${user.fullName}" required>
                                        <div class="invalid-feedback">
                                            Please enter your Full name.
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" value="${user.email}" required readonly>                                            <small class="form-text text-muted">Email cannot be changed</small>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}" pattern="[0-9]{10}">
                                        <div class="invalid-feedback">
                                            Please enter a valid phone number (10 digits).
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-3 d-flex justify-content-end">
                                    <button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="collapse" data-bs-target="#editProfileForm">
                                        Cancel
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Change Password -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-white py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Password</h5>
                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="collapse" data-bs-target="#changePasswordForm">
                                    <i class="fas fa-key me-2"></i>Change Password
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-4">
                            <p class="mb-0">Your password was last changed on <fmt:formatDate value="${user.lastPasswordChange}" pattern="MMMM dd, yyyy" />.</p>
                            
                            <!-- Change Password Form -->
                            <div class="collapse mt-4" id="changePasswordForm">
                                <hr>
                                <h6 class="mb-3">Change Your Password</h6>
                                <form action="${pageContext.request.contextPath}/user/change-password" method="post" class="needs-validation" novalidate>
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">Current Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <div class="invalid-feedback">
                                                Please enter your current password.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                                pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" required>
                                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <div class="invalid-feedback">
                                                Password must be at least 8 characters and include uppercase, lowercase, numbers, and special characters.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-4">
                                        <label for="confirmNewPassword" class="form-label">Confirm New Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
                                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <div class="invalid-feedback">
                                                Passwords do not match.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-3 d-flex justify-content-end">
                                        <button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="collapse" data-bs-target="#changePasswordForm">
                                            Cancel
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            Update Password
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Orders -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Recent Orders</h5>
                                <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-sm btn-link">View All</a>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty recentOrders}">
                                    <div class="p-4 text-center">
                                        <p class="text-muted mb-0">You haven't placed any orders yet.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Order #</th>
                                                    <th>Date</th>
                                                    <th>Items</th>
                                                    <th>Total</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${recentOrders}" var="order">
                                                    <tr>
                                                        <td>#${order.id}</td>
                                                        <td><fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy" /></td>
                                                        <td>${order.totalItems}</td>
                                                        <td>$${order.totalAmount}</td>
                                                        <td><span class="badge bg-${order.orderStatus == 'DELIVERED' ? 'success' : order.orderStatus == 'PROCESSING' ? 'primary' : order.orderStatus == 'SHIPPED' ? 'info' : 'secondary'}">${order.orderStatus}</span></td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/user/orders/${order.id}" class="btn btn-sm btn-outline-primary">
                                                                Details
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Toggle password visibility for all password fields
            document.querySelectorAll('.toggle-password').forEach(function(button) {
                button.addEventListener('click', function() {
                    const passwordInput = this.previousElementSibling;
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    this.querySelector('i').classList.toggle('fa-eye');
                    this.querySelector('i').classList.toggle('fa-eye-slash');
                });
            });
            
            // Confirm new password validation
            const newPassword = document.getElementById('newPassword');
            const confirmNewPassword = document.getElementById('confirmNewPassword');
            
            if (confirmNewPassword && newPassword) {
                confirmNewPassword.addEventListener('input', function() {
                    if (this.value !== newPassword.value) {
                        this.setCustomValidity('Passwords do not match.');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }
        });
    </script>
</body>
</html> 
