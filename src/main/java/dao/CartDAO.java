package dao;

import model.GameAccount;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public boolean addToCart(int userId,
                             int accountId){

        try {

            Connection conn =
                    DBConnection.getConnection();

            // CHECK TRÙNG
            String checkSql =
                    "SELECT * FROM cart " +
                            "WHERE user_id=? AND account_id=?";

            PreparedStatement checkPs =
                    conn.prepareStatement(checkSql);

            checkPs.setInt(1, userId);
            checkPs.setInt(2, accountId);

            ResultSet rs =
                    checkPs.executeQuery();

            if(rs.next()){

                return false;
            }

            String sql =
                    "INSERT INTO cart(user_id, account_id) " +
                            "VALUES(?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ps.setInt(2, accountId);

            return ps.executeUpdate() > 0;

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }

    public List<GameAccount> getCartByUser(int userId){

        List<GameAccount> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT g.* FROM cart c " +
                            "JOIN game_accounts g " +
                            "ON c.account_id = g.id " +
                            "WHERE c.user_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                GameAccount g =
                        new GameAccount();

                g.setId(rs.getInt("id"));

                g.setGameName(
                        rs.getString("game_id")
                );

                g.setAccountName(
                        rs.getString("account_user")
                );

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

                System.out.println(g);
            }

        } catch (Exception e){

            e.printStackTrace();
        }

        return list;
    }

    public boolean removeCart(int userId,
                              int accountId){

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "DELETE FROM cart WHERE user_id=? AND account_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, accountId);

            return ps.executeUpdate() > 0;

        } catch (Exception e){

            e.printStackTrace();
        }

        return false;
    }
// COUNT CART

    public int getCartCount(int userId){

        int total = 0;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT COUNT(*) " +
                            "FROM cart " +
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


}