<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-3 mb-4">
                <h5>Book Store</h5>
                <p>Your ultimate destination for quality books at affordable prices. Happy reading!</p>
                <div class="social-icons">
                    <a href="#" class="text-white me-2"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-2"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white me-2"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            
            <div class="col-md-3 mb-4">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/home" class="text-white text-decoration-none">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/books" class="text-white text-decoration-none">Books</a></li>
                    <li><a href="#" class="text-white text-decoration-none">About Us</a></li>
                    <li><a href="#" class="text-white text-decoration-none">Contact</a></li>
                    <li><a href="#" class="text-white text-decoration-none">Privacy Policy</a></li>
                </ul>
            </div>
            
            <div class="col-md-3 mb-4">
                <h5>Contact Info</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fas fa-map-marker-alt me-2"></i> 123 Book Street, Reading City</li>
                    <li class="mb-2"><i class="fas fa-phone me-2"></i> (123) 456-7890</li>
                    <li class="mb-2"><i class="fas fa-envelope me-2"></i> info@bookstore.com</li>
                </ul>
            </div>
            
            <div class="col-md-3 mb-4">
                <h5>Newsletter</h5>
                <p>Subscribe for the latest updates, offers, and more.</p>
                <form>
                    <div class="input-group mb-3">
                        <input type="email" class="form-control" placeholder="Your Email">
                        <button class="btn btn-primary" type="button">Subscribe</button>
                    </div>
                </form>
            </div>
        </div>
        
        <hr class="my-4">
        
        <div class="text-center">
            <p class="mb-0">&copy; 2023 Book Store. All rights reserved.</p>
        </div>
    </div>
</footer> 