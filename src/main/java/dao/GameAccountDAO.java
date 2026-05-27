package dao;

import model.GameAccount;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GameAccountDAO {
    public List<GameAccount> getAllAccounts() {
        List<GameAccount> list = new ArrayList<>();
        String sql = "SELECT ga.*, games.name AS game_name FROM game_accounts ga JOIN games ON ga.game_id = games.id WHERE ga.status='AVAILABLE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addProduct(GameAccount g) {
        String sql = "INSERT INTO game_accounts (game_id, account_name, account_user, account_pass, description, rank_name, price, status, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, g.getGameId());
            ps.setString(2, g.getAccountName());
            ps.setString(3, g.getAccountUser());
            ps.setString(4, g.getAccountPass());
            ps.setString(5, g.getDescription());
            ps.setString(6, g.getRankName());
            ps.setDouble(7, g.getPrice());
            ps.setString(8, g.getStatus());
            ps.setString(9, g.getImage());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
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

    public GameAccount getProductById(int id) {
        String sql = "SELECT ga.*, games.name AS game_name FROM game_accounts ga JOIN games ON ga.game_id = games.id WHERE ga.id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProduct(GameAccount g) {
        String sql = "UPDATE game_accounts SET game_id=?, account_name=?, account_user=?, account_pass=?, description=?, rank_name=?, price=?, status=?, image=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, g.getGameId());
            ps.setString(2, g.getAccountName());
            ps.setString(3, g.getAccountUser());
            ps.setString(4, g.getAccountPass());
            ps.setString(5, g.getDescription());
            ps.setString(6, g.getRankName());
            ps.setDouble(7, g.getPrice());
            ps.setString(8, g.getStatus());
            ps.setString(9, g.getImage());
            ps.setInt(10, g.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE game_accounts SET status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<GameAccount> searchProducts(String keyword, String categoryId) {
        List<GameAccount> list = new ArrayList<>();
        String sql = "SELECT ga.*, games.name AS game_name FROM game_accounts ga JOIN games ON ga.game_id = games.id WHERE ga.status='AVAILABLE'";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (ga.account_name LIKE ? OR games.name LIKE ?)";
        }
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            sql += " AND ga.game_id=?";
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(categoryId));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public GameAccount getForUpdate(Connection conn, int id) throws SQLException {
        String sql = "SELECT ga.*, games.name AS game_name FROM game_accounts ga JOIN games ON ga.game_id = games.id WHERE ga.id=? FOR UPDATE";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return mapResultSet(rs);
        }
        return null;
    }

    public boolean buyAccountSafe(Connection conn, int id) throws SQLException {
        String sql = "UPDATE game_accounts SET status='SOLD' WHERE id=? AND status='AVAILABLE'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }

    public boolean updateStatusSafe(Connection conn, int id, String status) throws SQLException {
        String sql = "UPDATE game_accounts SET status=? WHERE id=? AND status != 'SOLD'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, id);
        return ps.executeUpdate() > 0;
    }
    public int getOrCreateGame(String gameName) {
        String findSql = "SELECT id FROM games WHERE name=?";
        String insertSql = "INSERT INTO games(name) VALUES(?)";

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement findPs = conn.prepareStatement(findSql);
            findPs.setString(1, gameName.trim());

            ResultSet rs = findPs.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");
            }

            PreparedStatement insertPs = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            insertPs.setString(1, gameName.trim());
            insertPs.executeUpdate();

            ResultSet keys = insertPs.getGeneratedKeys();

            if (keys.next()) {
                return keys.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 1;
    }
    private GameAccount mapResultSet(ResultSet rs) throws SQLException {
        GameAccount g = new GameAccount();
        g.setId(rs.getInt("id"));
        g.setGameId(rs.getInt("game_id"));
        g.setGameName(rs.getString("game_name"));
        g.setAccountName(rs.getString("account_name"));
        g.setAccountUser(rs.getString("account_user"));
        g.setAccountPass(rs.getString("account_pass"));
        g.setDescription(rs.getString("description"));
        g.setRankName(rs.getString("rank_name"));
        g.setPrice(rs.getDouble("price"));
        g.setStatus(rs.getString("status"));
        g.setImage(rs.getString("image"));
        return g;
    }
}