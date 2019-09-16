import java.sql.*;
public class Driver {
	public static void main(String [] args) {
		try {
			Connection conn = 
					DriverManager.getConnection("jdbc:mysql://dbprojectteam8.cmz0qyzslt7e.us-east-2.rds.amazonaws.com/Grocery", "DBProjectTeam8","teMp123!");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from User");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
