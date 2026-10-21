import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/CareMate2";
        String user = "root";
        String password = "your_password"; // replace with your own MySQL password

        // هذا هو الاتصال الصحيح
        return DriverManager.getConnection(url, user, password);
    }

    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            System.out.println("Database connected successfully!");
        } catch (SQLException e) {
            System.out.println("Database connection failed!");
            e.printStackTrace();
        }
    }
}