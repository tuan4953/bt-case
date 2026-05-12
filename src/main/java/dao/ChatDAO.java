package dao;

import model.SupportMessage;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class ChatDAO {

    // =========================
    // SEND MESSAGE
    // =========================
    public boolean sendMessage(int userId,
                               String role,
                               String message){

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO support_messages(" +
                            "user_id," +
                            "sender_role," +
                            "message" +
                            ") VALUES(?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ps.setString(2, role);

            ps.setString(3, message);

            return ps.executeUpdate() > 0;

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // USER CHAT
    // =========================
    public List<SupportMessage> getChatByUser(int userId){

        List<SupportMessage> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM support_messages " +
                            "WHERE user_id=? " +
                            "ORDER BY id ASC";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                SupportMessage s =
                        new SupportMessage();

                s.setId(rs.getInt("id"));

                s.setUserId(
                        rs.getInt("user_id")
                );

                s.setSenderRole(
                        rs.getString("sender_role")
                );

                s.setMessage(
                        rs.getString("message")
                );

                list.add(s);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // ADMIN GET ALL
    // =========================
    public List<SupportMessage> getAllMessages(){

        List<SupportMessage> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM support_messages " +
                            "ORDER BY id DESC";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                SupportMessage s =
                        new SupportMessage();

                s.setId(rs.getInt("id"));

                s.setUserId(
                        rs.getInt("user_id")
                );

                s.setSenderRole(
                        rs.getString("sender_role")
                );

                s.setMessage(
                        rs.getString("message")
                );

                list.add(s);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // GET MESSAGES
    // =========================
    public List<SupportMessage> getMessages(){

        return getAllMessages();
    }
}
