package dao;

import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BalanceDAO {

    // LẤY SỐ DƯ
    public double getBalance(int userId) {

        String sql = "SELECT balance FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("balance");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // TRỪ TIỀN (DÙNG CHO TÀI XỈU + BUY NOW)
    public boolean deductMoney(int userId, double amount) {

        String sql = "UPDATE users SET balance = balance - ? WHERE id = ? AND balance >= ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, amount);
            ps.setInt(2, userId);
            ps.setDouble(3, amount);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // CỘNG TIỀN (THẮNG TÀI XỈU)
    public void addMoney(int userId, double amount) {

        String sql = "UPDATE users SET balance = balance + ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, amount);
            ps.setInt(2, userId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}