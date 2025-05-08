package bookstore.dao;

import bookstore.model.User;
import bookstore.util.DBConnection;

import java.sql.*;

/**
 * Data Access Object for User entities
 */
public class UserDAO {
    
    /**
     * Authenticate a user
     * @param username the username
     * @param password the password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticate(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error authenticating user: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Get user by ID
     * @param id the user ID
     * @return User object or null if not found
     */
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting user by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Get user by username
     * @param username the username
     * @return User object or null if not found
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting user by username: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Register a new user
     * @param user the user to register
     * @return true if successful, false otherwise
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email, fullname, address, phone, is_admin) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getFullName());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getPhone());
            pstmt.setBoolean(7, user.isAdmin());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error registering user: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Update user profile
     * @param user the user to update
     * @return true if successful, false otherwise
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET password = ?, email = ?, fullname = ?, address = ?, phone = ? " +
                     "WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getFullName());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getPhone());
            pstmt.setInt(6, user.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error updating user: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Check if username exists
     * @param username the username to check
     * @return true if username exists, false otherwise
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking username existence: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Check if email exists
     * @param email the email to check
     * @return true if email exists, false otherwise
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking email existence: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Helper method to extract a User from a ResultSet
     */
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setFullName(rs.getString("fullname"));
        user.setAddress(rs.getString("address"));
        user.setPhone(rs.getString("phone"));
        user.setAdmin(rs.getBoolean("is_admin"));
        return user;
    }
} 