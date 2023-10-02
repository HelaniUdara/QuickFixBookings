<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat"%>

<%
//Database connection parameters
String dbUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
String dbUser = "isec";
String dbPassword = "EUHHaYAmtzbv";
ResultSet results = null;

try {
	// Load the MySQL JDBC driver
	Class.forName("com.mysql.cj.jdbc.Driver");

	// Establish a database connection
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	// Create a SQL SELECT query
	String sql = "SELECT * FROM vehicle_service";

	// Create a PreparedStatement
	PreparedStatement preparedStatement = conn.prepareStatement(sql);

	// Execute the SELECT query
	results = preparedStatement.executeQuery();

} catch (ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException e) {
	e.printStackTrace();
}
if (request.getParameter("submit") != null) {
	// Get form data
	String dateString = request.getParameter("servDate");
	String timeString = request.getParameter("servTime");
	String location = request.getParameter("servLocation");
	int mileage = Integer.parseInt(request.getParameter("mileage"));
	String vehicleNo = request.getParameter("vehNum");
	String message = request.getParameter("servmsg");
	//String userName = request.getParameter("Boss2");

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
		// Load the MySQL JDBC driver
		Class.forName("com.mysql.cj.jdbc.Driver");

		// Establish a database connection
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

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
		insertStatement.setString(7, "Boss2");

		// Execute the INSERT statement
		int rowsInserted = insertStatement.executeUpdate();

		// Check if the insertion was successful
		if (rowsInserted > 0) {
	out.println("Data inserted successfully.");
		} else {
	out.println("Failed to insert data.");
		}

		// Close the database connection
		//conn.close();
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
	 const introspectionEndpointUrl = 'https://api.asgardeo.io/t/orghsx24/oauth2/introspect';
	 const accessToken = localStorage.getItem('access_token');
	 const idToken = localStorage.getItem('id_token');

	 if (accessToken && idToken) {
		 /*
	 var settings = {
	 "url" : introspectionEndpointUrl,
	 "method" : "POST",
	 "timeout" : 0,
	 "headers" : {
	 "Authorization" : "Bearer " + accessToken
	 },
	 "data" : {
	 "token" : accessToken
	 }
	 };

	 $
	 .ajax(settings)
	 .done(
	 function(response) {
	 console.log(response);
	 */

	 // Check if the token is active before making the userinfo request
	// if (response.active) {
	 var userinfoSettings = {
	 "url" : "https://api.asgardeo.io/t/orghsx24/oauth2/userinfo",
	 "method" : "GET",
	 "timeout" : 0,
	 "headers" : {
	 "Authorization" : "Bearer "
	 + accessToken
	 },
	 };

	 $.ajax(userinfoSettings).done(
	 function(userinfoResponse) {
	 console.log(userinfoResponse);
	  var username =  userinfoResponse.username;
      var name = userinfoResponse.given_name;
      var surname = userinfoResponse.family_name;
      var phone = userinfoResponse.phone_number;
      var email = userinfoResponse.email;
      var country = userinfoResponse.address.country;
      
      document.getElementById('name').textContent = name + " " + surname;
      document.getElementById('country').textContent = country;
      document.getElementById('email').textContent = email;
      document.getElementById('phone').textContent = phone;
      document.getElementById('username').textContent = username;
	 // Process userinfoResponse as needed
	 }).fail(
	 function(userinfoError) {
	 console.error('Userinfo Error:',
	 userinfoError);
	 alert("Userinfo Error:");
	 });
	 /*} else {
	 // Handle inactive token
	 console.error('Token is inactive');
	 alert("Token is inactive");
	 }
	 }).fail(function(introspectionError) {
	 // Handle introspection error
	 console.error('Introspection Error:', introspectionError);
	 alert("Introspection Error:");
	 });*/
	 } else {
	 window.location.href = "index.jsp";
	 }
	 
	
</script>


<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<title>QuickFixBookings-Home</title>
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
</head>
<body>
<nav class="navbar fixed-top navbar-expand-lg navbar-dark ">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"><img class="brand-logo"
				src="./images/qFixLogo.png"></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02"
				aria-controls="navbarTogglerDemo02" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active item"
						aria-current="page" href="#profile">Profile</a></li>
						<li class="nav-item"><a class="nav-link item"
						aria-current="page" href="#profile">Services</a></li>
					<li class="nav-item"><a class="nav-link item"
						href="#newBooking">New Booking</a></li>
					<li class="nav-item"><a class="nav-link item" href="#bookings">Bookings</a>
					</li>
				</ul>
				<button class="btn btn-outline-primary" type="submit">Logout</button>
			
			</div>
		</div>
	</nav>
	
	<section id="profile">
		<div class="prof-left col-4">
			<h3>Book Smarter, Drive Safer</h3>
			<h1>Quick Fix Bookings</h1>
			<p>Book your service easily.</p>
		</div>
		<div class="prof-right col-5">
			<div class="card">
				<div class="card-body">
					<div class="avatadiv">
						<img class="avata" src="./images/avata.png">
					</div>
					<div>
						<table id="profTable">
							<tr>
								<th>Name :</th>
								<td></td>
								<td><span id='name'></span></td>
							</tr>
							<tr>
								<th>Username :</th>
								<td></td>
								<td><span id='username'></span></td>
							</tr>
							<tr>
								<th>Email :</th>
								<td></td>
								<td><span id='email'></span></td>
							</tr>
							<tr>
								<th>Contact No :</th>
								<td></td>
								<td><span id='phone'></span></td>
							</tr>
							<tr>
								<th>Country :</th>
								<td></td>
								<td><span id='country'></span></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section id="newBooking">
		<div class="container">
			<div class="card">
				<div class="card-body">
					<h1 class="topic">Make a Reservation</h1>
					<hr>
					<form class="row g-3">
						<div class="col-md-6">
							<label for="servDate" class="form-label">Date</label> <input
								type="date" class="form-control" id="servDate" name="servDate">
						</div>
						<div class="col-md-6">
							<label for="servTime" class="form-label">Time</label> <input
								type="time" class="form-control" id="servTime" name="servTime">
						</div>
						<div class="col-12">
							<label for="servLocation" class="form-label">Preferred
								Location</label> <select class="form-select"
								aria-label="Default select example" id="servLocation"
								name="servLocation">
								<option selected>Choose preferred district</option>
								<option value="Colombo">Colombo</option>
								<option value="Gampaga">Gampaga</option>
								<option value="Kaluthara">Kaluthara</option>
								<option value="Galle">Galle</option>
								<option value="Matara">Matara</option>
								<option value="Hambanthota">Hambanthota</option>
								<option value="Kandy">Kandy</option>
								<option value="Matale">Matale</option>
								<option value="Nuwara Eliya">Nuwara Eliya</option>
								<option value="Kegalle">Kegalle</option>
								<option value="Ratnapura">Ratnapura</option>
								<option value="Anuradhapura">Anuradhapura</option>
								<option value="Polonnaruwa">Polonnaruwa</option>
								<option value="Puttalam">Puttalam</option>
								<option value="Kurunegala">Kurunegala</option>
								<option value="Badulla">Badulla</option>
								<option value="Monaragala">Monaragala</option>
								<option value="Trincomalee">Trincomalee</option>
								<option value="Batticaloa">Batticaloa</option>
								<option value="Ampara">Ampara</option>
								<option value="Jaffna">Jaffna</option>
								<option value="Kilinochchi">Kilinochchi</option>
								<option value="Mannar">Mannar</option>
								<option value="Mullaitivu">Mullaitivu</option>
								<option value="Vavuniya">Vavuniya</option>
							</select>
						</div>
						<div class="col-6">
							<label for="vehNum" class="form-label">Vehicle
								Registration Number</label> <input type="text" class="form-control"
								id="vehNum" name="vehNum" placeholder="CAT 6224">
						</div>
						<div class="col-md-6">
							<label for="mileage" class="form-label">Current Mileage
								(km)</label> <input type="number" min="0" class="form-control"
								id="mileage" name="mileage">
						</div>
						<div class="col-12">
							<label for="servmsg" class="form-label">Message</label>
							<textarea class="form-control" id="servmsg" name="servmsg"
								rows="3"></textarea>
						</div>

						<div class="col-12">
							<button type="submit" id="submit" name="submit"
								class="btn btn-primary">Book</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<section id="bookings">
		<div class="container">
			<h1 class="topic list">Booking List</h1>
			<table class="table table-dark table-striped">
				<thead>
					<tr>
						<th scope="col">Booking ID</th>
						<th scope="col">Date</th>
						<th scope="col">Time</th>
						<th scope="col">Location</th>
						<th scope="col">Vehicle Number</th>
						<th scope="col">Mileage</th>
						<th scope="col">Message</th>
					</tr>
				</thead>
				<tbody>

					<%
					if (results != null) {

						while (results.next()) {

							int bookingId = results.getInt("booking_id");
							Date date = results.getDate("date");
							Time time = results.getTime("time");
							String location = results.getString("location");
							int mileage = results.getInt("mileage");
							String vehicleNo = results.getString("vehicle_no");
							String message = results.getString("message");
					%>

					<tr>
						<td><%=bookingId%></td>
						<td><%=date%></td>
						<td><%=time%></td>
						<td><%=location%></td>
						<td><%=vehicleNo%></td>
						<td><%=mileage%></td>
						<td><%=message%></td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>
	</section>
	
	<footer class="text-center text-lg-start" style="background-color: black; color:#ababab;">
  <div class="container p-5">
    <div class="row p-4">      
    <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
       
        <img class="footer-logo"
				src="./images/qFixLogo.png">
      </div>
    
      <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
       <h4 class="text-uppercase">Quick Fix Bookings</h4>
        <h5 class="text-uppercase">Effortless Service Booking for Your Wheel</h5>

        <p>
          Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iste atque ea quis
          molestias. Fugiat pariatur maxime quis culpa corporis vitae repudiandae
          aliquam voluptatem veniam, est atque cumque eum delectus sint!
        </p>
        <div class="footer-dark row social">
					<div class="col item social">
						<a href="#"><i class="icon ion-social-facebook"></i></a><a
							href="#"><i class="icon ion-social-twitter"></i></a><a href="#"><i
							class="icon ion-social-instagram"></i></a>
					</div>
				</div>
        
      </div>
    </div>
  </div>
  
  <div class="text-center p-2" style="background-color: black;">
    <p>QuickFixBookings © 2023 | Created by Helani Seekkubadu</p>
  </div>
</footer>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>