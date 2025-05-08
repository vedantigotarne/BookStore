<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title} - Book Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Book Detail Section -->
    <section class="book-detail-section py-5">
        <div class="container">
            <div class="row">
                <!-- Book Image -->
                <div class="col-md-4 mb-4">
                    <div class="card border-0">
                        <img id="mainBookImage" src="${book.imageUrl}" class="card-img-top book-detail-image" alt="${book.title}">
                    </div>
                </div>
                
                <!-- Book Details -->
                <div class="col-md-8">
                    <h1 class="mb-2">${book.title}</h1>
                    <p class="text-muted mb-3">by <strong>${book.author}</strong></p>
                    
                    <!-- Rating -->
                    <div class="rating mb-3">
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
                        <span class="ms-2">${book.rating} out of 5</span>
                    </div>
                    
                    <!-- Price -->
                    <div class="mb-3">
                        <span class="book-price">$${book.price}</span>
                    </div>
                    
                    <!-- Availability -->
                    <div class="mb-4">
                        <c:choose>
                            <c:when test="${book.quantity > 0}">
                                <span class="badge bg-success">In Stock</span>
                                <span class="text-muted ms-2">${book.quantity} copies available</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Out of Stock</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Add to Cart Form -->
                    <form action="${pageContext.request.contextPath}/cart" method="post" class="mb-4">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="bookId" value="${book.id}">
                        
                        <div class="row g-3 align-items-center">
                            <div class="col-auto">
                                <label for="quantity" class="col-form-label">Quantity:</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group quantity-control">
                                    <button type="button" class="btn btn-outline-secondary decrease-qty">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <input type="number" id="quantity" name="quantity" class="form-control text-center" 
                                           value="1" min="1" max="${book.quantity}" style="width: 60px;">
                                    <button type="button" class="btn btn-outline-secondary increase-qty">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col">
                                <button type="submit" class="btn btn-primary" ${book.quantity <= 0 ? 'disabled' : ''}>
                                    <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                </button>
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-secondary ms-2">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Books
                                </a>
                            </div>
                        </div>
                    </form>
                    
                    <!-- Book Meta Info -->
                    <div class="row book-meta mb-4">
                        <div class="col-md-6">
                            <p><strong>Category:</strong> ${category.name}</p>
                        </div>
                    </div>
                    
                    <!-- Book Description -->
                    <div class="book-description mb-4">
                        <h4>Description</h4>
                        <p>${book.description}</p>
                    </div>
                </div>
            </div>
            
            <!-- Related Books Section -->
            <c:if test="${not empty relatedBooks}">
                <div class="related-books mt-5">
                    <h3 class="mb-4">You might also like</h3>
                    <div class="row">
                        <c:forEach items="${relatedBooks}" var="relatedBook">
                            <div class="col-md-3 mb-4">
                                <div class="card book-card h-100">
                                    <img src="${relatedBook.imageUrl}" class="card-img-top" alt="${relatedBook.title}">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${relatedBook.title}</h5>
                                        <p class="card-text">by ${relatedBook.author}</p>
                                        <div class="rating mb-2">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= relatedBook.rating}">
                                                        <i class="fas fa-star"></i>
                                                    </c:when>
                                                    <c:when test="${i <= relatedBook.rating + 0.5}">
                                                        <i class="fas fa-star-half-alt"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <p class="card-text price">$${relatedBook.price}</p>
                                        <div class="mt-auto">
                                            <a href="${pageContext.request.contextPath}/book/${relatedBook.id}" class="btn btn-outline-primary btn-sm w-100">View Details</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html> 