import java.sql.*;
import javax.swing.*;

public class mysqlConnection {
	Connection conn = null;
	public static Connection dbConnector() {
		try {
			Connection conn = DriverManager.getConnection("jdbc:mysql://dbprojectteam8.cmz0qyzslt7e.us-east-2.rds.amazonaws.com/Grocery", "DBProjectTeam8","teMp123!");
			return conn;
			
		}catch(Exception e) {
			JOptionPane.showMessageDialog(null, e);
			return null;
		}
	}
}
