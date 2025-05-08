<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book - Bookstore Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="bi bi-speedometer2 me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active text-white" href="${pageContext.request.contextPath}/admin/books">
                                <i class="bi bi-book me-2"></i>Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="bi bi-tags me-2"></i>Categories
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="bi bi-bag me-2"></i>Orders
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Edit Book</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-sm btn-outline-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Books
                        </a>
                    </div>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Edit Book Form -->
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/edit-book" method="post">
                            <input type="hidden" name="id" value="${book.id}">
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="title" class="form-label">Title *</label>
                                    <input type="text" class="form-control" id="title" name="title" value="${book.title}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="author" class="form-label">Author *</label>
                                    <input type="text" class="form-control" id="author" name="author" value="${book.author}" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="4">${book.description}</textarea>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="price" class="form-label">Price *</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" class="form-control" id="price" name="price" step="0.01" value="${book.price}" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="quantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" min="0" value="${book.quantity}">
                                </div>
                                <div class="col-md-4">
                                    <label for="rating" class="form-label">Rating</label>
                                    <input type="number" class="form-control" id="rating" name="rating" min="0" max="5" step="0.1" value="${book.rating}">
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="categoryId" class="form-label">Category *</label>
                                    <select class="form-select" id="categoryId" name="categoryId" required>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}" <c:if test="${category.id == book.categoryId}">selected</c:if>>${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="imageUrl" class="form-label">Image URL</label>
                                    <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${book.imageUrl}">
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary me-md-2">Cancel</a>
                                <button type="submit" class="btn btn-primary">Update Book</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>