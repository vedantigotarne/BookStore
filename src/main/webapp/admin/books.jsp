<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Store - Browse Books</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Books Section -->
    <section class="books-section py-5">
        <div class="container">
            <div class="row">
                <!-- Filter Sidebar -->
                <div class="col-md-3 mb-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Filter Books</h5>
                        </div>
                        <div class="card-body">
                            <form id="filterForm" action="books" method="get">
                                <!-- Category Filter -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Categories</h6>
                                    <div class="form-group">
                                        <select name="category" class="form-select">
                                            <option value="">All Categories</option>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.id}" ${selectedCategory == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Price Range Filter -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Price Range</h6>
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="minPrice" class="form-label">Min ($)</label>
                                                <input type="number" class="form-control" id="minPrice" name="minPrice" 
                                                       min="0" step="0.01" value="${minPrice}">
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="maxPrice" class="form-label">Max ($)</label>
                                                <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                                                       min="0" step="0.01" value="${maxPrice}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Rating Filter -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Rating</h6>
                                    <div class="form-group">
                                        <select name="minRating" class="form-select">
                                            <option value="">Any Rating</option>
                                            <option value="4" ${minRating == 4 ? 'selected' : ''}>4★ & Up</option>
                                            <option value="3" ${minRating == 3 ? 'selected' : ''}>3★ & Up</option>
                                            <option value="2" ${minRating == 2 ? 'selected' : ''}>2★ & Up</option>
                                            <option value="1" ${minRating == 1 ? 'selected' : ''}>1★ & Up</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Apply/Reset Filters -->
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Apply Filters</button>
                                    <button type="button" id="resetFilter" class="btn btn-outline-secondary">Reset Filters</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- Books Grid -->
                <div class="col-md-9">
                    <!-- Search Results Info -->
                    <c:if test="${not empty searchTerm}">
                        <div class="alert alert-info">
                            <h5 class="mb-0">Search results for: "${searchTerm}"</h5>
                        </div>
                    </c:if>
                    
                    <!-- Category Info -->
                    <c:if test="${not empty selectedCategory}">
                        <c:forEach items="${categories}" var="category">
                            <c:if test="${category.id == selectedCategory}">
                                <div class="alert alert-info">
                                    <h5 class="mb-0">Category: ${category.name}</h5>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    
                    <!-- Books Display -->
                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty books}">
                                <c:forEach items="${books}" var="book">
                                    <div class="col-md-6 col-lg-4 mb-4">
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
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <div class="alert alert-info text-center">
                                        <h4>No books found.</h4>
                                        <p>Try adjusting your filters or search criteria.</p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
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