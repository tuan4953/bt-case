package dao;

import model.User;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // =========================
    // REGISTER
    // =========================
    public boolean register(User user) {

        String sql = "INSERT INTO users(username, password, email, role, balance) VALUES(?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, "USER");
            ps.setDouble(5, 0); // mặc định tiền = 0

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // LOGIN
    // =========================
    public User login(String username, String password) {

        String sql = "SELECT * FROM users WHERE username=? AND password=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setBalance(rs.getDouble("balance"));
                user.setRole(rs.getString("role"));

                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // UPDATE BALANCE (CỐT LÕI)
    // =========================
    public boolean updateBalance(int userId, double balance) {

        String sql = "UPDATE users SET balance=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, balance);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // CHECK USERNAME EXIST
    // =========================
    public boolean isUsernameExist(String username) {

        String sql = "SELECT id FROM users WHERE username=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    public int getTotalUsers(){ int total = 0; try { Connection conn = DBConnection.getConnection(); String sql = "SELECT COUNT(*) FROM users"; PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery(); if(rs.next()){ total = rs.getInt(1); } } catch (Exception e){ e.printStackTrace(); } return total; }
}