package bookstore.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import bookstore.dao.BookDAO;
import bookstore.model.Book;
import bookstore.model.CartItem;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
/**
 * Servlet for the shopping cart functionality
 */
@WebServlet("/cart") 
public class CartServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = getCart(session);
        
        // Calculate cart totals
        BigDecimal total = calculateCartTotal(cart);
        
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("cart");
            return;
        }
        
        HttpSession session = request.getSession();
        List<CartItem> cart = getCart(session);
        
        switch (action) {
            case "add":
                addToCart(request, cart);
                break;
            case "update":
                updateCart(request, cart);
                break;
            case "remove":
                removeFromCart(request, cart);
                break;
            case "clear":
                clearCart(session);
                break;
            default:
                break;
        }
        
        // Save updated cart back to session
        session.setAttribute("cart", cart);
        
        // Redirect based on the action
        if ("add".equals(action)) {
            String referer = request.getHeader("referer");
            response.sendRedirect(referer != null ? referer : "home");
        } else {
            response.sendRedirect("cart");
        }
    }
    
    private List<CartItem> getCart(HttpSession session) {
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
        return cart;
    }
    
    private void addToCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            // Get parameters
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                quantity = 1;
            }
            
            // Get book information
            Book book = bookDAO.getBookById(bookId);
            
            if (book != null) {
                // Check if the book is already in the cart
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getBook().getId() == bookId) {
                        // Update quantity
                        item.setQuantity(item.getQuantity() + quantity);
                        found = true;
                        break;
                    }
                }
                
                // If not found, add as a new item
                if (!found) {
                    CartItem item = new CartItem(book, quantity);
                    cart.add(item);
                }
            }
        } catch (NumberFormatException e) {
            // Invalid parameters, do nothing
        }
    }
    
    private void updateCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            // Get parameters
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                // Remove the item if quantity is 0 or negative
                cart.removeIf(item -> item.getBook().getId() == bookId);
            } else {
                // Update the quantity
                for (CartItem item : cart) {
                    if (item.getBook().getId() == bookId) {
                        item.setQuantity(quantity);
                        break;
                    }
                }
            }
        } catch (NumberFormatException e) {
            // Invalid parameters, do nothing
        }
    }
    
    private void removeFromCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            // Get parameters
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            
            // Remove the item
            cart.removeIf(item -> item.getBook().getId() == bookId);
        } catch (NumberFormatException e) {
            // Invalid parameters, do nothing
        }
    }
    
    private void clearCart(HttpSession session) {
        session.removeAttribute("cart");
    }
    
    private BigDecimal calculateCartTotal(List<CartItem> cart) {
        BigDecimal total = BigDecimal.ZERO;
        
        for (CartItem item : cart) {
            total = total.add(item.getSubtotal());
        }
        
        return total;
    }
} 