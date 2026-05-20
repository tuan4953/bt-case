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
                g.setGameName(rs.getString("game_id") + "");
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
    // ADD PRODUCT
    // =========================
    public boolean addProduct(GameAccount g) {

        String sql = """
            INSERT INTO game_accounts
            (game_id, account_name, account_user, account_pass, description, rank_name, price, status, image)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, 1);
            ps.setString(2, g.getAccountName());
            ps.setString(3, "admin_acc");
            ps.setString(4, "123");
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
    // DELETE (soft delete khuyên dùng)
    // =========================
    public boolean deleteProduct(int id) {

        // ❗ NÊN dùng soft delete thay vì DELETE
        String sql = "UPDATE game_accounts SET status='DELETED' WHERE id=?";

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

    // =========================
    // SEARCH
    // =========================
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

    // =========================================================
    // 🔥🔥🔥 PHẦN QUAN TRỌNG - CHỐNG XUNG ĐỘT (MỚI THÊM)
    // =========================================================

    /**
     * 🔒 KHÓA ROW khi user chuẩn bị mua (tránh admin sửa/xóa cùng lúc)
     */
    public GameAccount getForUpdate(Connection conn, int id) throws SQLException {

        String sql = "SELECT * FROM game_accounts WHERE id=? FOR UPDATE";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            GameAccount g = new GameAccount();
            g.setId(rs.getInt("id"));
            g.setAccountName(rs.getString("account_name"));
            g.setPrice(rs.getDouble("price"));
            g.setStatus(rs.getString("status"));

            return g;
        }

        return null;
    }

    /**
     * 💰 MUA AN TOÀN - chỉ mua nếu còn AVAILABLE
     */
    public boolean buyAccountSafe(Connection conn, int id) throws SQLException {

        String sql =
                "UPDATE game_accounts " +
                        "SET status='SOLD' " +
                        "WHERE id=? AND status='AVAILABLE'";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);

        return ps.executeUpdate() > 0;
    }

    /**
     * 🔄 UPDATE STATUS CÓ ĐIỀU KIỆN (tránh admin đè dữ liệu)
     */
    public boolean updateStatusSafe(Connection conn,
                                    int id,
                                    String status) throws SQLException {

        String sql =
                "UPDATE game_accounts " +
                        "SET status=? " +
                        "WHERE id=? AND status != 'SOLD'";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, status);
        ps.setInt(2, id);

        return ps.executeUpdate() > 0;
    }

    // =========================
    // OLD METHOD (giữ lại nhưng KHÔNG khuyến khích)
    // =========================
    public boolean updateStatus(int id, String status) {

        try {

            Connection conn = DBConnection.getConnection();

            String sql =
                    "UPDATE game_accounts SET status=? WHERE id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}