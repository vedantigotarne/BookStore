package bookstore.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import bookstore.util.DBConnection;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
/**
 * Servlet for initializing database connection and tables
 */
@WebServlet("/init-db")

public class DBConnectionServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            createTables(connection);
            System.out.println("Database initialization completed successfully");
        } catch (Exception e) {
            throw new ServletException("Database initialization failed: " + e.getMessage(), e);
        }
    }
    
    private void createTables(Connection connection) throws Exception {
        try (Statement statement = connection.createStatement()) {
            // Create categories table
            statement.executeUpdate("CREATE TABLE IF NOT EXISTS categories (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(100) NOT NULL, " +
                    "description TEXT" +
                    ")");
            
            // Create books table
            statement.executeUpdate("CREATE TABLE IF NOT EXISTS books (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "title VARCHAR(255) NOT NULL, " +
                    "author VARCHAR(255) NOT NULL, " +
                    "description TEXT, " +
                    "price DECIMAL(10, 2) NOT NULL, " +
                    "category_id INT, " +
                    "quantity INT DEFAULT 0, " +
                    "image_url VARCHAR(255), " +
                    "rating DOUBLE DEFAULT 0, " +
                    "FOREIGN KEY (category_id) REFERENCES categories(id)" +
                    ")");
            
            // Create users table
            statement.executeUpdate("CREATE TABLE IF NOT EXISTS users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "username VARCHAR(50) NOT NULL UNIQUE, " +
                    "password VARCHAR(100) NOT NULL, " +
                    "email VARCHAR(100) NOT NULL UNIQUE, " +
                    "fullname VARCHAR(100), " +
                    "address TEXT, " +
                    "phone VARCHAR(20), " +
                    "is_admin BOOLEAN DEFAULT false" +
                    ")");
            
            // Create orders table
            statement.executeUpdate("CREATE TABLE IF NOT EXISTS orders (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "total_amount DECIMAL(10, 2) NOT NULL, " +
                    "shipping_address TEXT, " +
                    "payment_method VARCHAR(50), " +
                    "order_status VARCHAR(50) DEFAULT 'Pending', " +
                    "FOREIGN KEY (user_id) REFERENCES users(id)" +
                    ")");
            
            // Create order_items table
            statement.executeUpdate("CREATE TABLE IF NOT EXISTS order_items (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "order_id INT NOT NULL, " +
                    "book_id INT NOT NULL, " +
                    "quantity INT NOT NULL, " +
                    "price DECIMAL(10, 2) NOT NULL, " +
                    "FOREIGN KEY (order_id) REFERENCES orders(id), " +
                    "FOREIGN KEY (book_id) REFERENCES books(id)" +
                    ")");
            
            // Create reviews table
            statement.executeUpdate("CREATE TABLE IF NOT EXISTS reviews (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "book_id INT NOT NULL, " +
                    "user_id INT NOT NULL, " +
                    "rating INT NOT NULL, " +
                    "comment TEXT, " +
                    "review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (book_id) REFERENCES books(id), " +
                    "FOREIGN KEY (user_id) REFERENCES users(id)" +
                    ")");
            
            // Insert default admin user
            statement.executeUpdate("INSERT IGNORE INTO users (username, password, email, fullname, is_admin) " +
                    "VALUES ('admin', 'admin123', 'admin@bookstore.com', 'Administrator', true)");
            
            // Insert sample categories
            statement.executeUpdate("INSERT IGNORE INTO categories (id, name, description) VALUES " +
                    "(1, 'Fiction', 'Fictional stories, novels and literature'), " +
                    "(2, 'Non-Fiction', 'Educational and informative books based on facts'), " +
                    "(3, 'Science Fiction', 'Books about futuristic technology and space'), " +
                    "(4, 'Mystery', 'Mystery and detective novels'), " +
                    "(5, 'Biography', 'Books about real people''s lives')");
            
            // Insert sample books
            statement.executeUpdate("INSERT IGNORE INTO books (id, title, author, description, price, category_id, quantity, image_url, rating) VALUES " +
                    "(1, 'To Kill a Mockingbird', 'Harper Lee', 'A classic novel about racism and justice in the American South', 12.99, 1, 100, 'images/mockingbird.jpg', 4.8), " +
                    "(2, 'The Great Gatsby', 'F. Scott Fitzgerald', 'A story of wealth, love, and the American Dream in the 1920s', 10.99, 1, 75, 'images/gatsby.jpg', 4.5), " +
                    "(3, 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'A brief overview of human history and civilization', 15.99, 2, 50, 'images/sapiens.jpg', 4.7), " +
                    "(4, 'Dune', 'Frank Herbert', 'An epic science fiction novel set in a distant future', 14.99, 3, 60, 'images/dune.jpg', 4.6), " +
                    "(5, 'The Silent Patient', 'Alex Michaelides', 'A psychological thriller about a woman who stops speaking after murdering her husband', 13.49, 4, 40, 'images/silentpatient.jpg', 4.4), " +
                    "(6, 'Steve Jobs', 'Walter Isaacson', 'The biography of Apple co-founder Steve Jobs', 16.99, 5, 30, 'images/stevejobs.jpg', 4.9)");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("home");
    }
    
    @Override
    public void destroy() {
        DBConnection.closeConnection();
    }
} 