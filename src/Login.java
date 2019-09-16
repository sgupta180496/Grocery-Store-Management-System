import java.awt.EventQueue;
import java.sql.*;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class Login {

	private JFrame frmLogin;
	Connection conn = null;
	ResultSet set = null;
	private JTextField textFieldUN;
	private JPasswordField passwordField;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Login window = new Login();
					window.frmLogin.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public Login() {
		initialize();
		conn = mysqlConnection.dbConnector();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frmLogin = new JFrame();
		frmLogin.setTitle("Login");
		frmLogin.setBounds(100, 100, 450, 300);
		frmLogin.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frmLogin.getContentPane().setLayout(null);
		
		JLabel lblNewLabel = new JLabel("UserName");
		lblNewLabel.setBounds(106, 76, 60, 14);
		frmLogin.getContentPane().add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("Password");
		lblNewLabel_1.setBounds(106, 112, 60, 14);
		frmLogin.getContentPane().add(lblNewLabel_1);
		
		textFieldUN = new JTextField();
		textFieldUN.setBounds(176, 73, 86, 20);
		frmLogin.getContentPane().add(textFieldUN);
		textFieldUN.setColumns(10);
		
		JButton btnNewButton = new JButton("Login");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				try {
					String query = "select * from Login where username=? and password = ?";
					PreparedStatement pst = conn.prepareStatement(query);
					pst.setString(1, textFieldUN.getText());
					pst.setString(2, passwordField.getText());
					
					ResultSet rs = pst.executeQuery();
					int count = 0;
					while(rs.next()) {
						count++;
					}
					if (count == 1) {
						JOptionPane.showMessageDialog(null, "Username and password is correct");
						frmLogin.dispose();
						UserInfo userinfo = new UserInfo();
						userinfo.setVisible(true);
					}
					else if (count > 1) {
						JOptionPane.showMessageDialog(null, "Duplicate Username and password");
					}
					else {
						JOptionPane.showMessageDialog(null, "Username and password is not correct");
					}
					rs.close();
					pst.close();
				}
				catch(Exception e) {
						JOptionPane.showMessageDialog(null, e);
				}
			}
		});
		btnNewButton.setBounds(176, 186, 89, 23);
		frmLogin.getContentPane().add(btnNewButton);
		
		passwordField = new JPasswordField();
		passwordField.setBounds(176, 109, 86, 20);
		frmLogin.getContentPane().add(passwordField);
	}
}
