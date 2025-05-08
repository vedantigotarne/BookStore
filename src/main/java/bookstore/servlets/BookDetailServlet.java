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
 * Servlet for the book detail page
 */
@WebServlet("/books-detail")
public class BookDetailServlet extends HttpServlet {
    
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
        // Get the book ID from the URL
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/books");
            return;
        }
        
        // Extract the book ID from the URL path
        String[] pathParts = pathInfo.split("/");
        if (pathParts.length < 2) {
            response.sendRedirect(request.getContextPath() + "/books");
            return;
        }
        
        String bookId = pathParts[1];
        
        try {
            int id = Integer.parseInt(bookId);
            Book book = bookDAO.getBookById(id);
            
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/books");
                return;
            }
            
            // Get the book's category
            Category category = categoryDAO.getCategoryById(book.getCategoryId());
            request.setAttribute("category", category);
            
            // Get related books (same category)
            List<Book> relatedBooks = bookDAO.getBooksByCategory(book.getCategoryId());
            relatedBooks.removeIf(b -> b.getId() == book.getId());
            if (relatedBooks.size() > 4) {
                relatedBooks = relatedBooks.subList(0, 4);
            }
            
            // Get all categories for navigation
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Set attributes for the JSP
            request.setAttribute("book", book);
            request.setAttribute("relatedBooks", relatedBooks);
            request.setAttribute("categories", categories);
            
            // Forward to the book detail page
            request.getRequestDispatcher("/book-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/books");
        }
    }
} 