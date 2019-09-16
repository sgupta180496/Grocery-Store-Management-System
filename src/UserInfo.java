import java.sql.*;
import javax.swing.*;
import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import net.proteanit.sql.DbUtils;

import javax.swing.JButton;
import javax.swing.JTable;
import javax.swing.JScrollPane;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Font;

public class UserInfo extends JFrame {

	private JPanel contentPane;
	private JTable table;
	Connection conn = null;
	ResultSet set = null;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					UserInfo frame = new UserInfo();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public UserInfo() {
		setTitle("Employees");
		conn = mysqlConnection.dbConnector();
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 900, 536);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton btnLoadTable = new JButton("User");
		btnLoadTable.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				try {
					String query = "select * from User";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
		btnLoadTable.setBounds(192, 42, 89, 23);
		contentPane.add(btnLoadTable);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(192, 110, 682, 376);
		contentPane.add(scrollPane);
		
		table = new JTable();
		scrollPane.setViewportView(table);
		
		JButton btnEmployee = new JButton("Employee");
		btnEmployee.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				try {
					String query = "select * from Employee";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
		btnEmployee.setBounds(291, 42, 89, 23);
		contentPane.add(btnEmployee);
		
		JButton btnManager = new JButton("Manager");
		btnManager.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "select * from Manager";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e1) {
					e1.printStackTrace();
				}
			}
		});
		btnManager.setBounds(390, 42, 89, 23);
		contentPane.add(btnManager);
		
		JButton btnSalariedEmployee = new JButton("Salaried");
		btnSalariedEmployee.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "select * from Salaried_employee";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e2) {
					e2.printStackTrace();
				}
			}
		});
		btnSalariedEmployee.setBounds(489, 42, 89, 23);
		contentPane.add(btnSalariedEmployee);
		
		JButton btnHourly = new JButton("Hourly");
		btnHourly.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "select * from Hourly_employee";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e3) {
					e3.printStackTrace();
				}
			}
		});
		btnHourly.setBounds(588, 42, 89, 23);
		contentPane.add(btnHourly);
		
		JButton btnTimesheet = new JButton("Time");
		btnTimesheet.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "select * from Timesheet";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e4) {
					e4.printStackTrace();
				}
			}
		});
		btnTimesheet.setBounds(687, 42, 89, 23);
		contentPane.add(btnTimesheet);
		
		JLabel lblTables = new JLabel("Tables");
		lblTables.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblTables.setBounds(500, 11, 46, 14);
		contentPane.add(lblTables);
		
		JLabel lblExampleQueries = new JLabel("Examples");
		lblExampleQueries.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblExampleQueries.setBounds(63, 70, 65, 14);
		contentPane.add(lblExampleQueries);
		
		JButton btnSalariedEmployees = new JButton("Salaried Employees");
		btnSalariedEmployees.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT employee_id, CONCAT_WS(' ', first_name, last_name) AS Name, salary AS Salary\r\n" + 
							"	FROM User INNER JOIN Employee USING(user_id)\r\n" + 
							"    INNER JOIN Salaried_employee USING(employee_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e5) {
					e5.printStackTrace();
				}
			}
		});
		btnSalariedEmployees.setBounds(10, 95, 166, 23);
		contentPane.add(btnSalariedEmployees);
		
		JButton btnHourlyEmployees = new JButton("Hourly Employees");
		btnHourlyEmployees.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT employee_id, CONCAT_WS(' ', first_name, last_name) AS Name, pay_rate AS 'Pay Rate'\r\n" + 
							"	FROM User INNER JOIN Employee USING(user_id)\r\n" + 
							"    INNER JOIN Hourly_employee USING(employee_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e6) {
					e6.printStackTrace();
				}
			}
		});
		btnHourlyEmployees.setBounds(10, 128, 166, 23);
		
		contentPane.add(btnHourlyEmployees);
		
		JButton btnEmployeeTimesheets = new JButton("Employee Timesheets");
		btnEmployeeTimesheets.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT employee_id, CONCAT_WS(' ', first_name, last_name) AS Name, clock_in_time AS 'Clock-in', clock_out_time AS 'Clock-out'\r\n" + 
							"	FROM User INNER JOIN Employee USING(user_id)\r\n" + 
							"    INNER JOIN Timesheet USING(employee_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e7) {
					e7.printStackTrace();
				}
			}
		});
		btnEmployeeTimesheets.setBounds(10, 162, 166, 23);
		contentPane.add(btnEmployeeTimesheets);
		
		JButton btnEmployeeEmails = new JButton("Employee Emails");
		btnEmployeeEmails.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT employee_id, CONCAT_WS(' ', first_name, last_name) AS Name, email AS Email\r\n" + 
							"	FROM User INNER JOIN Employee USING(user_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnEmployeeEmails.setBounds(10, 196, 166, 23);
		contentPane.add(btnEmployeeEmails);
		
		JButton btnManagedBy = new JButton("ManagedBy");
		btnManagedBy.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT * from Managed_by;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnManagedBy.setBounds(192, 76, 89, 23);
		contentPane.add(btnManagedBy);
		
		JButton btnOrder = new JButton("Order");
		btnOrder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				try {
					String query = "SELECT * from Order_table;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnOrder.setBounds(291, 76, 89, 23);
		contentPane.add(btnOrder);
		
		JButton btnVprodprice = new JButton("VProdPrice");
		btnVprodprice.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT * from Vendor_product_price;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnVprodprice.setBounds(785, 76, 89, 23);
		contentPane.add(btnVprodprice);
		
		JButton btnOrderdetails = new JButton("OrderDets");
		btnOrderdetails.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT * from Order_details;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnOrderdetails.setBounds(390, 76, 89, 23);
		contentPane.add(btnOrderdetails);
		
		JButton btnProduct = new JButton("Product");
		btnProduct.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT * from Product;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnProduct.setBounds(489, 76, 89, 23);
		contentPane.add(btnProduct);
		
		JButton btnProdcat = new JButton("ProdCat");
		btnProdcat.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT * from ProductCategory;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnProdcat.setBounds(588, 76, 89, 23);
		contentPane.add(btnProdcat);
		
		JButton btnCategory = new JButton("Category");
		btnCategory.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT * from Category;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnCategory.setBounds(687, 76, 89, 23);
		contentPane.add(btnCategory);
		
		JButton btnVendor = new JButton("Vendor");
		btnVendor.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT * from Vendor;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnVendor.setBounds(785, 42, 89, 23);
		contentPane.add(btnVendor);
		
		JButton btnItemLocation = new JButton("Item Location");
		btnItemLocation.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT product_name AS Product, aisle_number AS Aisle\r\n" + 
							"FROM Product inner join ProductCategory using(product_id)\r\n" + 
							"	inner join Category using(category_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnItemLocation.setBounds(10, 230, 166, 23);
		contentPane.add(btnItemLocation);
		
		JButton btnCatalog = new JButton("Catalog");
		btnCatalog.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT product_name AS Product, price AS Price, category_name AS Category, quantity_available AS '#Available'\r\n" + 
							"FROM Product inner join ProductCategory using(product_id)\r\n" + 
							"	inner join Category using(category_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnCatalog.setBounds(10, 264, 166, 23);
		contentPane.add(btnCatalog);
		
		JButton btnVendorProducts = new JButton("Vendor Products");
		btnVendorProducts.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT vendor_name AS 'Vendor Name', product_name AS Product\r\n" + 
							"FROM Product inner join Vendor_product_price using(product_id)\r\n" + 
							"	inner join Vendor using (vendor_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnVendorProducts.setBounds(10, 298, 166, 23);
		contentPane.add(btnVendorProducts);
		
		JButton btnVendorPrices = new JButton("Vendor Prices");
		btnVendorPrices.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT vendor_name AS 'Vendor Name', product_name AS Product, vendor_price AS 'Vendor Price'\r\n" + 
							"FROM Product inner join Vendor_product_price using(product_id)\r\n" + 
							"	inner join Vendor using (vendor_id)\r\n" + 
							"WHERE vendor_id = 1;";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnVendorPrices.setBounds(10, 332, 166, 23);
		contentPane.add(btnVendorPrices);
		
		JButton btnProductCategories = new JButton("Product Categories");
		btnProductCategories.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String query = "SELECT product_name AS Product, category_name AS Category\r\n" + 
							"FROM Product inner join ProductCategory using(product_id)\r\n" + 
							"	inner join Category using (category_id);";
					PreparedStatement pst = conn.prepareStatement(query);
					ResultSet rs = pst.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch(Exception e8) {
					e8.printStackTrace();
				}
			}
		});
		btnProductCategories.setBounds(10, 366, 166, 23);
		contentPane.add(btnProductCategories);
	}
}
