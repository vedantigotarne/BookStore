package bookstore.servlets;

import java.io.IOException;
import java.util.List;

import bookstore.dao.BookDAO;
import bookstore.dao.CategoryDAO;
import bookstore.model.Book;
import bookstore.model.Category;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;


/**
 * Servlet for the home page
 */
@WebServlet("/") 
public class HomeServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private BookDAO bookDAO;
    private CategoryDAO categoryDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get featured books (top rated books)
        List<Book> featuredBooks = bookDAO.getTopRatedBooks(6);
        request.setAttribute("featuredBooks", featuredBooks);
        
        // Get all categories for navigation
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        // Forward to the home page
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Search functionality
        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Book> searchResults = bookDAO.searchBooks(searchTerm);
            request.setAttribute("books", searchResults);
            request.setAttribute("searchTerm", searchTerm);
            request.getRequestDispatcher("/books.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
} 