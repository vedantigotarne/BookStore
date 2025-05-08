<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book"></i> Book Haven
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                    </li>
                    <!--  <li class="nav-item">
                        <a class="nav-link" href="books.jsp">Books</a>
                    </li>-->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            Categories
                        </a>
                        <ul class="dropdown-menu">
                            <c:forEach items="${categories}" var="category">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/books?category=${category.id}">
                                        ${category.name}
                                    </a>
                                </li>
                            </c:forEach>
                            <c:if test="${empty categories}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/books">All Books</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.jsp">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">Contact</a>
                    </li>
                </ul>
                
                <!-- Search Form -->
                <form class="d-flex me-2" action="${pageContext.request.contextPath}/home" method="post">
                    <input class="form-control me-2" type="search" name="searchTerm" placeholder="Search books..." aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
                
                <!-- User Account Menu -->
                <div class="d-flex">
                    <a href="cart.jsp" class="btn btn-outline-light position-relative me-2">
                        <i class="fas fa-shopping-cart"></i>
                        <c:if test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${sessionScope.cart.size()}
                            </span>
                        </c:if>
                    </a>
                    
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown">
                                <button class="btn btn-outline-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <i class="fas fa-user"></i> ${sessionScope.user.username}
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/account">My Account</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/orders">My Orders</a></li>
                                    <c:if test="${sessionScope.user.admin}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Logout</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-outline-light me-2">
                                <i class="fas fa-sign-in-alt"></i> Login
                            </a>
                            <a href="${pageContext.request.contextPath}/user/register" class="btn btn-light">
                                Register
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header> 