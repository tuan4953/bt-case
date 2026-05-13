package dao;

import model.SupportMessage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupportMessageDAO {

    private Connection conn;

    public SupportMessageDAO(Connection conn) {
        this.conn = conn;
    }

    // =========================
    // GỬI TIN NHẮN (FIXED)
    // =========================
    public void sendMessage(int userId, String role, String message) throws SQLException {

        String sql = "INSERT INTO support_messages(user_id, sender_role, message) VALUES (?, ?, ?)";

        PreparedStatement ps = null;

        try {
            ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, role);
            ps.setString(3, message);

            ps.executeUpdate();

        } finally {
            if (ps != null) ps.close();
        }
    }

    // =========================
    // LẤY CHAT THEO USER
    // =========================
    public List<SupportMessage> getByUserId(int userId) throws SQLException {

        List<SupportMessage> list = new ArrayList<>();

        String sql = "SELECT * FROM support_messages WHERE user_id=? ORDER BY created_at ASC";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {

                SupportMessage msg = new SupportMessage();

                msg.setId(rs.getInt("id"));
                msg.setUserId(rs.getInt("user_id"));
                msg.setSenderRole(rs.getString("sender_role"));
                msg.setMessage(rs.getString("message"));
                msg.setCreatedAt(rs.getString("created_at"));

                list.add(msg);
            }

        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }

        return list;
    }

    // =========================
    // ADMIN XEM TẤT CẢ CHAT
    // =========================
    public List<SupportMessage> getAll() throws SQLException {

        List<SupportMessage> list = new ArrayList<>();

        String sql = "SELECT * FROM support_messages ORDER BY created_at ASC";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                SupportMessage msg = new SupportMessage();

                msg.setId(rs.getInt("id"));
                msg.setUserId(rs.getInt("user_id"));
                msg.setSenderRole(rs.getString("sender_role"));
                msg.setMessage(rs.getString("message"));
                msg.setCreatedAt(rs.getString("created_at"));

                list.add(msg);
            }

        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }

        return list;
    }

    public Object getChatByUser(int id) {
    }
}