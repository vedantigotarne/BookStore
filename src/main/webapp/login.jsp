<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Book Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Login Section -->
    <section class="login-section py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <div class="card shadow border-0">
                        <div class="card-body p-5">
                            <h1 class="text-center mb-4">Login</h1>
                            
                            <!-- Error Alert -->
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                            
                            <!-- Success Alert -->
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${successMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/user/login" method="post" class="needs-validation" novalidate>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                        <div class="invalid-feedback">
                                            Please enter a valid email address.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                        <button class="btn btn-outline-secondary toggle-password" type="button">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <div class="invalid-feedback">
                                            Please enter your password.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4 form-check">
                                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                    <label class="form-check-label" for="rememberMe">Remember me</label>
                                </div>
                                
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>
                                
                                <div class="text-center mt-4">
                                    <p class="mb-2">Don't have an account? <a href="register" class="text-decoration-none">Register here</a></p>
                                    <a href="forgot-password" class="text-decoration-none">Forgot Password?</a>
                                </div>
                            </form>
                            
                       
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
    <script>
	    (function () {
	        'use strict'
	        const forms = document.querySelectorAll('.needs-validation')
	        Array.from(forms).forEach(function (form) {
	            form.addEventListener('submit', function (event) {
	                if (!form.checkValidity()) {
	                    event.preventDefault()
	                    event.stopPropagation()
	                }
	                form.classList.add('was-validated')
	            }, false)
	        })
	    })();
        document.addEventListener('DOMContentLoaded', function() {
            // Toggle password visibility
            const togglePassword = document.querySelector('.toggle-password');
            const passwordInput = document.querySelector('#password');
            
            if (togglePassword && passwordInput) {
                togglePassword.addEventListener('click', function() {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    this.querySelector('i').classList.toggle('fa-eye');
                    this.querySelector('i').classList.toggle('fa-eye-slash');
                });
            }
        });
    </script>
</body>
</html> 