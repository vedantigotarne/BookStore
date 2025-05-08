package bookstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Utility Class
 */
public class DBConnection {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookstore";
    private static final String USER = "root";
    private static final String PASSWORD = "2005"; // Change to your MySQL password
    
    private static Connection connection = null;
    
    /**
     * Get a connection to the database
     * @return Connection object
     */
    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName(JDBC_DRIVER);
                connection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
        }
        return connection;
    }
    
    /**
     * Close the database connection
     */
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
    

	public static void main(String[] args) {
    Connection conn = getConnection();
    if (conn != null) {
        System.out.println("Database connected successfully!");
        closeConnection();
    } else {
        System.out.println("Database connection failed.");
    }
	}
}
