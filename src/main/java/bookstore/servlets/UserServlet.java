package bookstore.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bookstore.dao.OrderDAO;
import bookstore.dao.UserDAO;
import bookstore.model.Order;
import bookstore.model.User;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        orderDAO = new OrderDAO();
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/user/account");
            return;
        }
        
        // Route to appropriate handler based on URL path
        switch (pathInfo) {
            case "/login":
                showLoginPage(request, response);
                break;
            case "/register":
                showRegisterPage(request, response);
                break;
            case "/account":
                showAccountPage(request, response);
                break;
            case "/orders":
                showOrdersPage(request, response);
                break;
            case "/logout":
                logoutUser(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/user/account");
            return;
        }
        
        // Route to appropriate handler based on URL path
        switch (pathInfo) {
        	case "/login":
        		loginUser(request, response);
        		break;
            
            case "/register":
                registerUser(request, response);
                break;
            case "/account":
                updateUserAccount(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
                break;
        }
    }
    
    private void showLoginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/user/account");
            return;
        }
        
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    

    
    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/user/account");
            return;
        }
        
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
    
    private void showAccountPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        // Get user's orders
        List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/account.jsp").forward(request, response);
    }
    
    private void showOrdersPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        // Get user's orders
        List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/orders.jsp").forward(request, response);
    }
    
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	    String email = request.getParameter("email");
    	    String password = request.getParameter("password");

    	    if (email == null || email.trim().isEmpty() || 
    	        password == null || password.trim().isEmpty()) {
    	        
    	        request.setAttribute("errorMessage", "Please enter username and password.");
    	        request.getRequestDispatcher("/login.jsp").forward(request, response);
    	        return;
    	    }
    	    System.out.println("Email: " + email);
    	    System.out.println("Password: " + password);

    	    // Now check user credentials against the database
    	   
    	    User user = userDAO.authenticate(email, password);

        
        if (user != null) {
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Check if there is a redirect URL
            String redirectURL = (String) session.getAttribute("redirectURL");
            if (redirectURL != null) {
                session.removeAttribute("redirectURL");
                response.sendRedirect(request.getContextPath() + "/" + redirectURL);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/account");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        
        // Validate input
        if (username == null || password == null || confirmPassword == null || email == null || 
            username.trim().isEmpty() || password.trim().isEmpty() || 
            confirmPassword.trim().isEmpty() || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists. Please choose a different one.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists. Please use a different one.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setAddress(address);
        user.setPhone(phone);
        user.setAdmin(false);
        
        // Register user
        boolean success = userDAO.registerUser(user);
        
        if (success) {
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Redirect to account page
            response.sendRedirect(request.getContextPath() + "/user/account");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    
    private void updateUserAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        // Get form parameters
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        
        // Update user information
        if (password != null && !password.trim().isEmpty()) {
            user.setPassword(password);
        }
        
        if (email != null && !email.trim().isEmpty()) {
            user.setEmail(email);
        }
        
        user.setFullName(fullName);
        user.setAddress(address);
        user.setPhone(phone);
        
        // Update user in database
        boolean success = userDAO.updateUser(user);
        
        if (success) {
            // Update user in session
            session.setAttribute("user", user);
            request.setAttribute("successMessage", "Your account has been updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to update your account. Please try again.");
        }
        
        // Redirect to account page
        showAccountPage(request, response);
    }
    
    private void logoutUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/home");
    }
} 