package dao;

import model.GameAccount;
import model.User;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =========================
    // CREATE ORDER
    // =========================
    public boolean createOrder(User user,
                               GameAccount game){

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO orders(" +
                            "user_id," +
                            "account_id," +
                            "purchase_price," +
                            "acc_user_delivered," +
                            "acc_pass_delivered" +
                            ") VALUES(?,?,?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1,user.getId());

            ps.setInt(2,game.getId());

            ps.setDouble(3,game.getPrice());

            ps.setString(
                    4,
                    game.getAccountName()
            );

            ps.setString(5,"hidden");

            return ps.executeUpdate() > 0;

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // GET HISTORY
    // =========================
    public List<GameAccount> getHistory(int userId){

        List<GameAccount> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT g.* " +
                            "FROM orders o " +
                            "JOIN game_accounts g " +
                            "ON o.account_id = g.id " +
                            "WHERE o.user_id=? " +
                            "ORDER BY o.id DESC";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                GameAccount g =
                        new GameAccount();

                g.setId(
                        rs.getInt("id")
                );

                g.setGameName(
                        rs.getString("game_id")
                );

                g.setAccountUser( rs.getString("account_user") );
                g.setAccountPass( rs.getString("account_pass") );

                g.setPrice(
                        rs.getDouble("price")
                );

                g.setStatus(
                        rs.getString("status")
                );

                g.setImage(
                        rs.getString("image")
                );

                list.add(g);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // TOTAL PURCHASED
    // =========================
    public int getTotalPurchased(int userId){

        int total = 0;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT COUNT(*) " +
                            "FROM orders " +
                            "WHERE user_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                total = rs.getInt(1);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return total;
    }

    // =========================
    // TOTAL SPENT
    // =========================
    public double getTotalSpent(int userId){

        double total = 0;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT SUM(purchase_price) " +
                            "FROM orders " +
                            "WHERE user_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                total = rs.getDouble(1);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return total;
    }

    public double getTotalRevenue(){

        double total = 0;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT SUM(purchase_price) " +
                            "FROM orders";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                total = rs.getDouble(1);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return total;
    }


    public int getTotalSold(){

        int total = 0;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT COUNT(*) FROM orders";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                total = rs.getInt(1);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return total;
    }


}
