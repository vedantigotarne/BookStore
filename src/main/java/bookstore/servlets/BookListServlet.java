package bookstore.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

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
 * Servlet for the books listing page
 */
@WebServlet("/books")
public class BookListServlet extends HttpServlet {
    
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
        // Get all books
        List<Book> books = bookDAO.getAllBooks();
        
        // Filter by category if specified
        String categoryParam = request.getParameter("category");
        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                books = bookDAO.getBooksByCategory(categoryId);
                request.setAttribute("selectedCategory", categoryId);
            } catch (NumberFormatException e) {
                // Invalid category ID, ignore filter
            }
        }
        
        // Filter by price range if specified
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        if (minPriceParam != null && maxPriceParam != null && !minPriceParam.isEmpty() && !maxPriceParam.isEmpty()) {
            try {
                BigDecimal minPrice = new BigDecimal(minPriceParam);
                BigDecimal maxPrice = new BigDecimal(maxPriceParam);
                final BigDecimal finalMinPrice = minPrice;
                final BigDecimal finalMaxPrice = maxPrice;
                
                books = books.stream()
                        .filter(book -> book.getPrice().compareTo(finalMinPrice) >= 0 && 
                                       book.getPrice().compareTo(finalMaxPrice) <= 0)
                        .collect(Collectors.toList());
                
                request.setAttribute("minPrice", minPrice);
                request.setAttribute("maxPrice", maxPrice);
            } catch (NumberFormatException e) {
                // Invalid price range, ignore filter
            }
        }
        
        // Filter by rating if specified
        String minRatingParam = request.getParameter("minRating");
        if (minRatingParam != null && !minRatingParam.isEmpty()) {
            try {
                double minRating = Double.parseDouble(minRatingParam);
                final double finalMinRating = minRating;
                
                books = books.stream()
                        .filter(book -> book.getRating() >= finalMinRating)
                        .collect(Collectors.toList());
                
                request.setAttribute("minRating", minRating);
            } catch (NumberFormatException e) {
                // Invalid rating, ignore filter
            }
        }
        
        // Get all categories for filter
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("books", books);
        
        // Forward to the books page
        request.getRequestDispatcher("/books.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Same as GET for this servlet - handle filter form submissions
        doGet(request, response);
    }
} 