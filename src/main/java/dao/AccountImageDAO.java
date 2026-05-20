package dao;

import model.AccountImage;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AccountImageDAO {

    public List<AccountImage> getImagesByAccountId(int accountId){

        List<AccountImage> list =
                new ArrayList<>();

        String sql =
                "SELECT * FROM account_images WHERE account_id=?";

        try(
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(sql)
        ){

            ps.setInt(1, accountId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                AccountImage img =
                        new AccountImage();

                img.setId(rs.getInt("id"));

                img.setAccountId(
                        rs.getInt("account_id")
                );

                img.setImageName(
                        rs.getString("image_name")
                );

                list.add(img);
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return list;
    }

    public boolean addImage(int accountId,
                            String imageName){

        String sql =
                "INSERT INTO account_images(account_id, image_name) VALUES(?, ?)";

        try(
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(sql)
        ){

            ps.setInt(1, accountId);

            ps.setString(2, imageName);

            return ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();
        }

        return false;
    }
}