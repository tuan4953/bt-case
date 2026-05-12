package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/game_shop?useSSL=false&serverTimezone=UTC";

    private static final String USER = "root";

    private static final String PASSWORD = "tuan2006@";

    // LOAD DRIVER 1 LẦN
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Cannot load MySQL driver");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {

        try {

            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

            if (conn == null) {
                throw new SQLException("Cannot connect to MySQL");
            }

            return conn;

        } catch (SQLException e) {
            System.out.println("DB Connection error");
            e.printStackTrace();
            return null;
        }
    }
}