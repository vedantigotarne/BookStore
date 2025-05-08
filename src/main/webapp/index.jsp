<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Store - Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Banner/Carousel -->
    <div id="bookCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#bookCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#bookCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#bookCarousel" data-bs-slide-to="2"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/banner1.jpg" class="d-block w-100" alt="Banner 1">
                <div class="carousel-caption">
                    <!--  <h2>Welcome to Book Store</h2>
                    <p>Discover your next favorite book with us</p>-->
                    <a href="books" class="btn btn-primary">Shop Now</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/banner2.jpg" class="d-block w-100" alt="Banner 2">
                <div class="carousel-caption">
                    <h2>New Arrivals</h2>
                    <p>Check out our latest collection</p>
                    <a href="books" class="btn btn-primary">Explore</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/banner3.jpg" class="d-block w-100" alt="Banner 3">
                <div class="carousel-caption">
                    <h2>Special Offers</h2>
                    <p>Limited time discounts on selected books</p>
                    <a href="books" class="btn btn-primary">View Offers</a>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#bookCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#bookCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
    
    <!-- Featured Books Section -->
    <section class="featured-books py-5">
        <div class="container">
            <h2 class="text-center mb-4">Featured Books</h2>
            <div class="row">
                <c:forEach items="${featuredBooks}" var="book">
                    <div class="col-md-4 col-lg-2 mb-4">
                        <div class="card book-card h-100">
                            <img src="${book.imageUrl}" class="card-img-top" alt="${book.title}">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${book.title}</h5>
                                <p class="card-text">by ${book.author}</p>
                                <div class="rating mb-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= book.rating}">
                                                <i class="fas fa-star"></i>
                                            </c:when>
                                            <c:when test="${i <= book.rating + 0.5}">
                                                <i class="fas fa-star-half-alt"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="far fa-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <span class="rating-text">(${book.rating})</span>
                                </div>
                                <p class="card-text price">$${book.price}</p>
                                <div class="mt-auto">
                                    <a href="book/${book.id}" class="btn btn-outline-primary btn-sm mb-2 w-100">View Details</a>
                                    <form action="cart" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookId" value="${book.id}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-primary btn-sm w-100">Add to Cart</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-4">
                <a href="books" class="btn btn-lg btn-outline-primary">View All Books</a>
            </div>
        </div>
    </section>
    
    <!-- Categories Section -->
    <section class="categories-section py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-4">Browse by Category</h2>
            <div class="row">
                <c:forEach items="${categories}" var="category">
                    <div class="col-md-4 mb-4">
                        <div class="card category-card h-100">
                            <div class="card-body">
                                <h5 class="card-title">${category.name}</h5>
                                <p class="card-text">${category.description}</p>
                                <a href="books?category=${category.id}" class="btn btn-outline-primary">Explore</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
    
    <!-- About Section -->
    <section class="about-section py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2>About Our Book Store</h2>
                    <p>Welcome to our online book store, your ultimate destination for literary exploration. We offer a vast collection of books across various genres, from bestselling fiction and non-fiction to academic textbooks and rare finds.</p>
                    <p>Our mission is to connect readers with the books they love and to promote reading culture in our community.</p>
                    <a href="#" class="btn btn-primary">Learn More</a>
                </div>
                <div class="col-md-6">
                    <img src="images/bookstore.jpg" alt="Book Store" class="img-fluid rounded">
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