package dao;

import model.GameAccount;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GameAccountDAO {

    // =========================
    // GET ALL
    // =========================
    public List<GameAccount> getAllAccounts() {

        List<GameAccount> list = new ArrayList<>();

        String sql =
                "SELECT * FROM game_accounts WHERE status='AVAILABLE'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                GameAccount g = new GameAccount();

                g.setId(rs.getInt("id"));

                // FIX mapping đúng DB
                g.setGameName(rs.getString("game_id") + ""); // tạm hiển thị
                g.setAccountName(rs.getString("account_name"));
                g.setPrice(rs.getDouble("price"));
                g.setStatus(rs.getString("status"));
                g.setImage(rs.getString("image"));

                list.add(g);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // ADD PRODUCT (FIXED)
    // =========================
    public boolean addProduct(GameAccount g) {

        String sql = """
            INSERT INTO game_accounts
            (game_id, account_name, account_user, account_pass, description, rank_name, price, status, image)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // ⚠️ Tạm fix cứng game_id = 1 nếu bạn chưa làm select game
            ps.setInt(1, 1);

            ps.setString(2, g.getAccountName());
            ps.setString(3, "admin_acc");     // tạm demo
            ps.setString(4, "123");           // tạm demo
            ps.setString(5, "No description");
            ps.setString(6, "Normal");
            ps.setDouble(7, g.getPrice());
            ps.setString(8, g.getStatus());
            ps.setString(9, g.getImage());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // DELETE
    // =========================
    public boolean deleteProduct(int id) {

        String sql = "DELETE FROM game_accounts WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // GET BY ID
    // =========================
    public GameAccount getProductById(int id) {

        String sql = "SELECT * FROM game_accounts WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                GameAccount g = new GameAccount();

                g.setId(rs.getInt("id"));
                g.setAccountName(rs.getString("account_name"));
                g.setPrice(rs.getDouble("price"));
                g.setStatus(rs.getString("status"));
                g.setImage(rs.getString("image"));

                return g;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // UPDATE
    // =========================
    public boolean updateProduct(GameAccount g) {

        String sql = """
            UPDATE game_accounts
            SET account_name=?, price=?, status=?, image=?
            WHERE id=?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, g.getAccountName());
            ps.setDouble(2, g.getPrice());
            ps.setString(3, g.getStatus());
            ps.setString(4, g.getImage());
            ps.setInt(5, g.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<GameAccount> searchProducts(String keyword, String category) {

        List<GameAccount> list = new ArrayList<>();

        String sql = "SELECT * FROM game_accounts WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND account_name LIKE ?";
        }

        if (category != null && !category.trim().isEmpty()) {
            sql += " AND game_id = ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }

            if (category != null && !category.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(category));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                GameAccount g = new GameAccount();

                g.setId(rs.getInt("id"));
                g.setGameName(rs.getString("game_id"));
                g.setAccountName(rs.getString("account_name"));
                g.setPrice(rs.getDouble("price"));
                g.setStatus(rs.getString("status"));
                g.setImage(rs.getString("image"));

                list.add(g);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }



    public boolean updateStatus(int id,
                                String status){

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE game_accounts " +
                            "SET status=? WHERE id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, status);

            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }
}