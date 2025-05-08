package bookstore.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bookstore.dao.OrderDAO;
import bookstore.model.CartItem;
import bookstore.model.Order;
import bookstore.model.OrderItem;
import bookstore.model.User;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
/**
 * Servlet for the checkout process
 */
@WebServlet("/checkout") 
public class CheckoutServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            // Store the original URL for redirect after login
            session.setAttribute("redirectURL", "checkout");
            response.sendRedirect("user/login");
            return;
        }
        
        // Get cart items
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        // Check if cart is empty
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        
        // Calculate cart total
        BigDecimal total = calculateCartTotal(cart);
        
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("user/login");
            return;
        }
        
        // Get cart items
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        // Check if cart is empty
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        
        // Get form parameters
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        
        if (shippingAddress == null || shippingAddress.trim().isEmpty() || 
            paymentMethod == null || paymentMethod.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            doGet(request, response);
            return;
        }
        
        // Create order
        Order order = new Order();
        order.setUserId(user.getId());
        order.setOrderDate(new Date());
        order.setTotalAmount(calculateCartTotal(cart));
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("Pending");
        
        // Create order items
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cart) {
            OrderItem orderItem = new OrderItem();
            orderItem.setBookId(cartItem.getBook().getId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getBook().getPrice());
            orderItems.add(orderItem);
        }
        
        order.setOrderItems(orderItems);
        
        // Save order to database
        boolean success = orderDAO.createOrder(order);
        
        if (success) {
            // Clear cart
            session.removeAttribute("cart");
            
            // Set order confirmation details
            request.setAttribute("order", order);
            request.getRequestDispatcher("/order-confirmation.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "An error occurred while processing your order. Please try again.");
            doGet(request, response);
        }
    }
    
    private BigDecimal calculateCartTotal(List<CartItem> cart) {
        BigDecimal total = BigDecimal.ZERO;
        
        if (cart != null) {
            for (CartItem item : cart) {
                total = total.add(item.getSubtotal());
            }
        }
        
        return total;
    }
} 