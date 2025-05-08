<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Bookstore</title>
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
                            <a class="nav-link active text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="bi bi-speedometer2 me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/books">
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
                    <h1 class="h2">Dashboard</h1>
                </div>

                <!-- Dashboard Stats -->
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title">Total Books</h6>
                                        <h2 class="card-text">${bookCount}</h2>
                                    </div>
                                    <i class="bi bi-book fs-1"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/books" class="text-white">View Details <i class="bi bi-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title">Total Categories</h6>
                                        <h2 class="card-text">${categoryCount}</h2>
                                    </div>
                                    <i class="bi bi-tags fs-1"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/categories" class="text-white">View Details <i class="bi bi-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title">Total Orders</h6>
                                        <h2 class="card-text">${orderCount}</h2>
                                    </div>
                                    <i class="bi bi-bag fs-1"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/orders" class="text-white">View Details <i class="bi bi-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/add-book" class="btn btn-primary w-100">
                                            <i class="bi bi-plus-circle me-2"></i>Add New Book
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/add-category" class="btn btn-success w-100">
                                            <i class="bi bi-plus-circle me-2"></i>Add New Category
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-info w-100">
                                            <i class="bi bi-list-check me-2"></i>Manage Orders
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary w-100">
                                            <i class="bi bi-shop me-2"></i>Visit Store
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>