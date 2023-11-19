package services;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;


public class SQLServices {
	Connection conn = DBConnection.getConnection();

	public int insertBooking(String dateString, String timeString, String location, int mileage, String vehicleNo,
			String message, String username) {
		int rowsInserted = 0;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
		Date date = null;
		Time time = null;

		try {
			date = new Date(dateFormat.parse(dateString).getTime());
			time = new Time(timeFormat.parse(timeString).getTime());
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			
			// Create a SQL INSERT statement
			String insertSql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";

			// Create a PreparedStatement
			PreparedStatement insertStatement = conn.prepareStatement(insertSql);

			// Set the parameter values
			insertStatement.setTimestamp(1, new Timestamp(date.getTime()));
			insertStatement.setTimestamp(2, new Timestamp(time.getTime()));
			insertStatement.setString(3, location);
			insertStatement.setInt(4, mileage);
			insertStatement.setString(5, vehicleNo);
			insertStatement.setString(6, message);
			insertStatement.setString(7, username);

			// Execute the INSERT statement
			rowsInserted = insertStatement.executeUpdate();

			
		} catch ( SQLException e) {
			e.printStackTrace();
		}
		return rowsInserted;
	}

	public int deleteBooking(int bookingId) {
		int rowsDeleted = 0;
		try {
		
			// Create a SQL DELETE statement
			String deleteSql = "DELETE FROM vehicle_service WHERE booking_id = ?";

			// Create a PreparedStatement
			PreparedStatement deleteStatement = conn.prepareStatement(deleteSql);

			// Set the parameter value
			deleteStatement.setInt(1, bookingId);

			// Execute the DELETE statement
			rowsDeleted = deleteStatement.executeUpdate();

			// Check if the deletion was successful
			

			//response.setIntHeader("Refresh", 5);
			// Close the database connection
			// conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Error: " + e.getMessage());
		}
		return rowsDeleted;
	}

	public ResultSet getAllBookings(String username) {
		ResultSet results = null;

		try {
			
			String sql = "SELECT * FROM vehicle_service WHERE username = ?";

			// Create a PreparedStatement
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1,username);
			// Execute the SELECT query
			results = preparedStatement.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return results;
	}
}
