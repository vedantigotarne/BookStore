package bookstore.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import bookstore.dao.BookDAO;
import bookstore.dao.CategoryDAO;
import bookstore.dao.OrderDAO;
import bookstore.model.Book;
import bookstore.model.Category;
import bookstore.model.Order;
import bookstore.model.User;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private BookDAO bookDAO;
    private CategoryDAO categoryDAO;
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        // Route to appropriate handler based on URL path
        switch (pathInfo) {
            case "/dashboard":
                showDashboard(request, response);
                break;
            case "/books":
                showBooks(request, response);
                break;
            case "/categories":
                showCategories(request, response);
                break;
            case "/orders":
                showOrders(request, response);
                break;
            case "/add-book":
                showAddBookForm(request, response);
                break;
            case "/edit-book":
                showEditBookForm(request, response);
                break;
            case "/add-category":
                showAddCategoryForm(request, response);
                break;
            case "/edit-category":
                showEditCategoryForm(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        // Route to appropriate handler based on URL path
        switch (pathInfo) {
            case "/add-book":
                addBook(request, response);
                break;
            case "/edit-book":
                updateBook(request, response);
                break;
            case "/delete-book":
                deleteBook(request, response);
                break;
            case "/add-category":
                addCategory(request, response);
                break;
            case "/edit-category":
                updateCategory(request, response);
                break;
            case "/delete-category":
                deleteCategory(request, response);
                break;
            case "/update-order-status":
                updateOrderStatus(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get counts for dashboard
        List<Book> books = bookDAO.getAllBooks();
        List<Category> categories = categoryDAO.getAllCategories();
        List<Order> orders = orderDAO.getAllOrders();
        
        request.setAttribute("bookCount", books.size());
        request.setAttribute("categoryCount", categories.size());
        request.setAttribute("orderCount", orders.size());
        
        // Forward to dashboard page
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
    
    private void showBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> books = bookDAO.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/admin/books.jsp").forward(request, response);
    }
    
    private void showCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }
    
    private void showOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }
    
    private void showAddBookForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/add-book.jsp").forward(request, response);
    }
    
    private void showEditBookForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("id");
        
        if (bookId == null || bookId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/books");
            return;
        }
        
        try {
            int id = Integer.parseInt(bookId);
            Book book = bookDAO.getBookById(id);
            
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/admin/books");
                return;
            }
            
            List<Category> categories = categoryDAO.getAllCategories();
            
            request.setAttribute("book", book);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/edit-book.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books");
        }
    }
    
    private void showAddCategoryForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/add-category.jsp").forward(request, response);
    }
    
    private void showEditCategoryForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("id");
        
        if (categoryId == null || categoryId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }
        
        try {
            int id = Integer.parseInt(categoryId);
            Category category = categoryDAO.getCategoryById(id);
            
            if (category == null) {
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }
            
            request.setAttribute("category", category);
            request.getRequestDispatcher("/admin/edit-category.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }
    
    private void addBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String categoryIdStr = request.getParameter("categoryId");
        String quantityStr = request.getParameter("quantity");
        String imageUrl = request.getParameter("imageUrl");
        String ratingStr = request.getParameter("rating");
        
        // Validate input
        if (title == null || author == null || priceStr == null || categoryIdStr == null || 
            title.trim().isEmpty() || author.trim().isEmpty() || 
            priceStr.trim().isEmpty() || categoryIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            showAddBookForm(request, response);
            return;
        }
        
        try {
            // Parse numeric values
            BigDecimal price = new BigDecimal(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int quantity = quantityStr != null && !quantityStr.trim().isEmpty() ? Integer.parseInt(quantityStr) : 0;
            double rating = ratingStr != null && !ratingStr.trim().isEmpty() ? Double.parseDouble(ratingStr) : 0.0;
            
            // Create book object
            Book book = new Book();
            book.setTitle(title);
            book.setAuthor(author);
            book.setDescription(description);
            book.setPrice(price);
            book.setCategoryId(categoryId);
            book.setQuantity(quantity);
            book.setImageUrl(imageUrl);
            book.setRating(rating);
            
            // Add book to database
            boolean success = bookDAO.addBook(book);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/books");
            } else {
                request.setAttribute("errorMessage", "Failed to add book. Please try again.");
                showAddBookForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric values. Please check your input.");
            showAddBookForm(request, response);
        }
    }
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String bookIdStr = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String categoryIdStr = request.getParameter("categoryId");
        String quantityStr = request.getParameter("quantity");
        String imageUrl = request.getParameter("imageUrl");
        String ratingStr = request.getParameter("rating");
        
        // Validate input
        if (bookIdStr == null || title == null || author == null || priceStr == null || categoryIdStr == null || 
            bookIdStr.trim().isEmpty() || title.trim().isEmpty() || author.trim().isEmpty() || 
            priceStr.trim().isEmpty() || categoryIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            showEditBookForm(request, response);
            return;
        }
        
        try {
            // Parse numeric values
            int bookId = Integer.parseInt(bookIdStr);
            BigDecimal price = new BigDecimal(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int quantity = quantityStr != null && !quantityStr.trim().isEmpty() ? Integer.parseInt(quantityStr) : 0;
            double rating = ratingStr != null && !ratingStr.trim().isEmpty() ? Double.parseDouble(ratingStr) : 0.0;
            
            // Get existing book
            Book book = bookDAO.getBookById(bookId);
            
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/admin/books");
                return;
            }
            
            // Update book properties
            book.setTitle(title);
            book.setAuthor(author);
            book.setDescription(description);
            book.setPrice(price);
            book.setCategoryId(categoryId);
            book.setQuantity(quantity);
            book.setImageUrl(imageUrl);
            book.setRating(rating);
            
            // Update book in database
            boolean success = bookDAO.updateBook(book);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/books");
            } else {
                request.setAttribute("errorMessage", "Failed to update book. Please try again.");
                request.setAttribute("book", book);
                showEditBookForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric values. Please check your input.");
            showEditBookForm(request, response);
        }
    }
    
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String bookIdStr = request.getParameter("id");
        
        if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/books");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdStr);
            bookDAO.deleteBook(bookId);
            
            response.sendRedirect(request.getContextPath() + "/admin/books");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books");
        }
    }
    
    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        // Validate input
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter a category name.");
            showAddCategoryForm(request, response);
            return;
        }
        
        // Create category object
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        
        // Add category to database
        boolean success = categoryDAO.addCategory(category);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } else {
            request.setAttribute("errorMessage", "Failed to add category. Please try again.");
            showAddCategoryForm(request, response);
        }
    }
    
    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String categoryIdStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        // Validate input
        if (categoryIdStr == null || name == null || 
            categoryIdStr.trim().isEmpty() || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            showEditCategoryForm(request, response);
            return;
        }
        
        try {
            // Parse numeric values
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Get existing category
            Category category = categoryDAO.getCategoryById(categoryId);
            
            if (category == null) {
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }
            
            // Update category properties
            category.setName(name);
            category.setDescription(description);
            
            // Update category in database
            boolean success = categoryDAO.updateCategory(category);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories");
            } else {
                request.setAttribute("errorMessage", "Failed to update category. Please try again.");
                request.setAttribute("category", category);
                showEditCategoryForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category ID.");
            showEditCategoryForm(request, response);
        }
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String categoryIdStr = request.getParameter("id");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }
        
        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            categoryDAO.deleteCategory(categoryId);
            
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }
    
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");
        
        if (orderIdStr == null || status == null || 
            orderIdStr.trim().isEmpty() || status.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            orderDAO.updateOrderStatus(orderId, status);
            
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
} 