import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Scanner;

/**
 * This class demonstrates how to connect to MySQL and run some basic commands.
 * 
 * In order to use this, you have to download the Connector/J driver and add its
 * .jar file to your build path. You can find it here:
 * 
 * http://dev.mysql.com/downloads/connector/j/
 * 
 * You will see the following exception if it's not in your class path:
 * 
 * java.sql.SQLException: No suitable driver found for
 * jdbc:mysql://localhost:3306/
 * 
 * To add it to your class path: 1. Right click on your project 2. Go to Build
 * Path -> Add External Archives... 3. Select the file
 * mysql-connector-java-5.1.24-bin.jar NOTE: If you have a different version of
 * the .jar file, the name may be a little different.
 * 
 * The user name and password are both "root", which should be correct if you
 * followed the advice in the MySQL tutorial. If you want to use different
 * credentials, you can change them below.
 * 
 * You will get the following exception if the credentials are wrong:
 * 
 * java.sql.SQLException: Access denied for user 'userName'@'localhost' (using
 * password: YES)
 * 
 * You will instead get the following exception if MySQL isn't installed, isn't
 * running, or if your serverName or portNumber are wrong:
 * 
 * java.net.ConnectException: Connection refused
 */
public class DBDemo {

	/** The name of the MySQL account to use (or empty for anonymous) */
	private String userName;

	/** The password for the MySQL account (or empty for anonymous) */
	private String password;

	/** The name of the computer running MySQL */
	private final String serverName = "localhost";

	/** The port of the MySQL server (default is 3306) */
	private final int portNumber = 3306;

	/**
	 * The name of the database we are testing with (this default is installed
	 * with MySQL)
	 */
	private final String dbName = "starwarsfinal";

	/** The name of the character user provided */
	private String character;

	/** The scanner for user input */
	private Scanner scan = new Scanner(System.in);

	/** The connection to database */
	private Connection conn = null;

	/** the list of character name from database */
	ArrayList<String> chaList = new ArrayList<String>();

	/**
	 * Get a new database connection
	 * 
	 * @return
	 * @throws SQLException
	 */
	public Connection getConnection() throws SQLException {

		Properties connectionProps = new Properties();
		connectionProps.put("user", this.userName);
		connectionProps.put("password", this.password);

		conn = DriverManager.getConnection(
				"jdbc:mysql://" + this.serverName + ":" + this.portNumber + "/" + this.dbName + "?useSSL=true",
				connectionProps);
		return conn;
	}

	/**
	 * Connect to MySQL and do some stuff.
	 */
	public void run() {
		do {
			// Request login of database
			System.out.println("Please enter your valid username of database.");
			this.userName = scan.next();
			System.out.println();
			System.out.println("Please enter your valid password of database.");
			this.password = scan.next();
			System.out.println();

			// Connect to MySQL
			try {
				conn = this.getConnection();
				System.out.println("Connected to the database: " + this.dbName);
				System.out.println();
			} catch (SQLException e) {
				System.out.println(e.getMessage());

			}
		} while (conn == null);
		// Request a input character name
		this.requestCharacter();
	}

	/** Request a character name from user and test */
	public void requestCharacter() {
		// List and store the valid character names
		Statement stmt = null;
		String query = "select * from starwarsfinal.characters";
		ResultSet rs = null;
		chaList = new ArrayList<String>();

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				String characterName = rs.getString("character_name");
				chaList.add(characterName);
			}
			System.out.println(chaList.toString());
			System.out.println();
			this.checkCha();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
		    if (rs != null) {
		        try {
		            rs.close();
		        } catch (SQLException e) { /* ignored */}
		    }
		    if (stmt != null) {
		        try {
		        	stmt.close();
		        } catch (SQLException e) { /* ignored */}
		    }
		}
	}

	/** Check whether the input character name is valid */
	public void checkCha() {
		// Store the character name
		this.character = scan.nextLine();
		while (!chaList.contains(character)) {
			System.out.println("Please enter/reenter a valid character name in the above list (Case sensitive).");
			this.character = scan.nextLine();
		}
		System.out.println("The input character name '" + this.character + "' is valid and stored.");
		callTrack_character();
	}

	/** Call the procedure track_character */
	public void callTrack_character() {
		System.out.println();
		System.out.println("Tracking this character in database.");
		System.out.println("The information below are name, home, movie name and number of scenes (from left to right).");
		Statement stmt = null;
		String query = "call track_character('" + this.character + "')";
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();
			while (rs.next()) {
				for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
					Object object = rs.getObject(columnIndex);
					System.out.printf("%35s |", object == null ? "NULL" : object.toString());
				}
				System.out.printf("%n");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		    if (rs != null) {
		        try {
		            rs.close();
		        } catch (SQLException e) { /* ignored */}
		    }
		    if (stmt != null) {
		        try {
		        	stmt.close();
		        } catch (SQLException e) { /* ignored */}
		    }
		    if (conn != null) {
		        try {
		            conn.close();
		        } catch (SQLException e) { /* ignored */}
		    }
		    if (scan != null) {
		        try {
		        	scan.close();
		        } catch (Exception e) { /* ignored */}
		    }
		}
	}

	/**
	 * Connect to the DB and do some stuff
	 */
	public static void main(String[] args) {
		DBDemo app = new DBDemo();
		app.run();
	}

}
