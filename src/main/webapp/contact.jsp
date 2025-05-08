<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Contact Us - Book Haven</title>
  <!-- Bootstrap CSS CDN -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
  <style>
    body {
      background-color: #ffffff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #333;
    }

    .container {
      max-width: 1000px;
      margin: 2rem auto;
      padding: 2rem;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .contact-section {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
    }

    .contact-info, .contact-form {
      flex: 1;
    }

    .icon {
      width: 40px;
      height: 40px;
      background-color: #0d6efd;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
      font-weight: bold;
      margin-right: 1rem;
    }

    .form-group {
      margin-bottom: 1rem;
    }

    textarea {
      resize: vertical;
    }

    .map-container {
      height: 300px;
      background-color: #eee;
      border-radius: 8px;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #777;
      font-style: italic;
    }

    footer {
      background-color: #0d6efd;
      color: white;
      text-align: center;
      padding: 1.5rem;
      margin-top: 2rem;
    }

    @media (max-width: 768px) {
      .contact-section {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
 
  <!-- Header -->
    <!-- Bootstrap Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Book Haven</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
        <!--  <li class="nav-item"><a class="nav-link" href="books.jsp">Books</a></li>
        <li class="nav-item"><a class="nav-link" href="">Categories</a></li>-->
        
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
        <li class="nav-item"><a class="nav-link active" href="about.jsp">About Us</a></li>
        <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container">
    <h1>Contact Us</h1>
    <div class="contact-section">
      <div class="contact-info">
        <h2>Get In Touch</h2>
        <p>We'd love to hear from you! Whether you have a question about our books, need help with an order, or want to share your feedback, our team is here to assist you.</p>

        <div class="d-flex mb-3">
          <div class="icon">📍</div>
          <div>
            <strong>Visit Us</strong>
            <p>123 Literary Lane, Bookville, BK 12345</p>
          </div>
        </div>

        <div class="d-flex mb-3">
          <div class="icon">📞</div>
          <div>
            <strong>Call Us</strong>
            <p>(555) 123-4567</p>
            <p>Mon-Fri: 9am-6pm, Sat: 10am-4pm</p>
          </div>
        </div>

        <div class="d-flex mb-3">
          <div class="icon">✉</div>
          <div>
            <strong>Email Us</strong>
            <p>info@bookhaven.com</p>
            <p>support@bookhaven.com</p>
          </div>
        </div>

        <div class="d-flex mb-3">
          <div class="icon">📱</div>
          <div>
            <strong>Connect With Us</strong>
            <p>Facebook • Instagram • Twitter</p>
          </div>
        </div>
      </div>

      <div class="contact-form">
        <h2>Send Us a Message</h2>
        <form>
          <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" class="form-control" placeholder="Your Name" required />
          </div>

          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" class="form-control" placeholder="Your Email" required />
          </div>

          <div class="form-group">
            <label for="subject">Subject</label>
            <select id="subject" class="form-select">
              <option value="general">General Inquiry</option>
              <option value="order">Order Support</option>
              <option value="feedback">Feedback</option>
              <option value="partnership">Partnership Opportunities</option>
              <option value="other">Other</option>
            </select>
          </div>

          <div class="form-group">
            <label for="message">Message</label>
            <textarea id="message" class="form-control" placeholder="Type your message here..." rows="5" required></textarea>
          </div>

          <button type="submit" class="btn btn-primary">Send Message</button>
        </form>
      </div>
    </div>

    <div class="map-section mt-5">
      <h2>Find Us</h2>
      <div class="map-container">
        <p>Map placeholder - Interactive map would appear here</p>
      </div>
    </div>

    <div class="faq-section mt-5">
      <h2>Frequently Asked Questions</h2>

      <div class="faq-item mb-3">
        <h5>What are your store hours?</h5>
        <p>Our physical store is open Monday through Friday from 9:00 AM to 6:00 PM, Saturday from 10:00 AM to 4:00 PM, and closed on Sundays. Our online store is available 24/7.</p>
      </div>

      <div class="faq-item mb-3">
        <h5>Do you offer international shipping?</h5>
        <p>Yes, we ship to most international locations. Shipping rates and delivery times vary by destination. Please check our shipping policy page for more details.</p>
      </div>

      <div class="faq-item mb-3">
        <h5>How can I track my order?</h5>
        <p>Once your order ships, you'll receive a confirmation email with tracking information. You can also check your order status by logging into your account.</p>
      </div>

      <div class="faq-item mb-3">
        <h5>Do you offer gift wrapping?</h5>
        <p>Yes! We offer gift wrapping services for $3.99 per item. You can select this option during checkout and include a personalized message.</p>
      </div>
    </div>
  </div>

 <!-- Footer -->
   <footer>
    <p>&copy; 2025 Book Haven. All rights reserved.</p>
  </footer>

  <!-- Bootstrap JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
    