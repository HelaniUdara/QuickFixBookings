<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat"%>
<%@ page import="services.DBConnection"%>
<%@ page import="services.SQLServices"%>
<%@ page import="java.io.InputStream, java.io.IOException, java.util.Properties" %>

<%

//Retrieve client_id and sessionState from the session 
String clientId = (String) session.getAttribute("client_id"); 
String sessionState = (String) session.getAttribute("session_state"); 


SQLServices sqlservice = new SQLServices();
ResultSet results = null;
try {
	String username = "Boss2";
	results = sqlservice.getAllBookings(username);
} catch (Exception e) {
	e.printStackTrace();
}

if (request.getParameter("submit") != null) {

	String dateString = request.getParameter("servDate");
	String timeString = request.getParameter("servTime");
	String location = request.getParameter("servLocation");
	int mileage = Integer.parseInt(request.getParameter("mileage"));
	String vehicleNo = request.getParameter("vehNum");
	String message = request.getParameter("servmsg");
	String userName = "Boss2";

	try {

		int rowsInserted = sqlservice.insertBooking(dateString, timeString, location, mileage, vehicleNo, message,
		userName);

		if (rowsInserted > 0) {
	out.println("Data inserted successfully.");
	response.sendRedirect(request.getRequestURI());
		} else {
	out.println("Failed to insert data.");
		}

		// Close the database connection
		//conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}

if (request.getParameter("delete") != null) {

	int bookingIdToDelete = Integer.parseInt(request.getParameter("bookingID"));
	System.out.println(bookingIdToDelete);

	try {

		int rowsDeleted = sqlservice.deleteBooking(bookingIdToDelete);

		if (rowsDeleted > 0) {
	out.println("Record deleted successfully.");
	response.sendRedirect(request.getRequestURI());
		} else {
	out.println("Failed to delete the record.");
		}

		//response.setIntHeader("Refresh", 5);
		// Close the database connection
		//conn.close();

	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error: " + e.getMessage());
	}
}


//Initialize a Properties object
Properties properties = new Properties();

//Load the properties file
try {
 InputStream inputStream = application.getResourceAsStream("/WEB-INF/classes/application.properties");
 properties.load(inputStream);
} catch (IOException e) {
 e.printStackTrace();
}

String post_logout_redirect_uri = properties.getProperty("baseurl")+"/QuickFixBookings/index.jsp"; 
String client_id =  properties.getProperty("client_id");
%>




<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	
	 const introspectionEndpointUrl = '<%= properties.getProperty("introspectionEndpoint") %>';
	// const accessToken = localStorage.getItem('access_token');
	 //const idToken = localStorage.getItem('id_token');
	 const accessToken = sessionStorage.getItem('access_token'); 
	 const idToken = sessionStorage.getItem("id_token"); 
	 const infoUrl = '<%= properties.getProperty("userinfoEndpoint") %>';

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
	 "url" : infoUrl,
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
     // document.getElementById('username').textContent = username;
     document.getElementById('submit').addEventListener('click', function () {
                    // Set the username as a hidden field value in the form
                    document.getElementById('currentUser').value = username;
                });
      
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

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
						aria-current="page" href="#service">Services</a></li>
					<li class="nav-item"><a class="nav-link item"
						href="#newBooking">New Booking</a></li>
					<li class="nav-item"><a class="nav-link item" href="#bookings">Bookings</a>
					</li>
				</ul>
				<li>
     			<form id="logout-form" action= "<%= properties.getProperty("logoutEndpoint") %>" method="POST">
				    <input type="hidden" id="client-id" name="client_id" value="<%= client_id %>">
				    <input type="hidden" id="post-logout-redirect-uri" name="post_logout_redirect_uri" value="<%= post_logout_redirect_uri %>">
				    <input type="hidden" id="state" name="state" value="<%= sessionState %>">
        			<button class="btn btn-outline-primary" id="logout-btn" type="submit">Logout</button>
   				</form>
				</li>
				
				<!--  
				<button class="btn btn-outline-primary" type="submit"
					onclick="window.location.href='https://api.asgardeo.io/t/orghsx24/oidc/logout'">Logout</button>
-->
			</div>
		</div>
	</nav>

	<section id="profile">
		<div class="prof-left col-lg-6 col-md-12">
			<div id="carouselExampleAutoplaying" class="carousel slide"
				data-bs-ride="carousel">
				<div class="carousel-inner">
					<div class="carousel-item active">
						<div class="slide-content">
							<h3>Your Journey, Our Priority</h3>
							<h1>Trust us for Reliable Vehicle Repairs and Service.</h1>

						</div>

					</div>
					<div class="carousel-item">
						<div class="slide-content">
							<h3>Book Smarter, Drive Safer</h3>
							<h1>Quick Fix Bookings</h1>
							<p>Book your service easily.</p>
						</div>
					</div>
					<div class="carousel-item">
						<div class="slide-content">
							<h3>From Tune-Ups to Overhauls</h3>
							<h1>We've Got Your Vehicle Covered</h1>
							<p>Choose Us for All Your Auto Repair Needs</p>
						</div>
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>

		</div>
		<div class="prof-right col-lg-4 col-md-12">
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
	<section id="service">
		<div class="center">
			<h1>Our Services</h1>
			<div class="wrapper">
				<div class="inner">
					<div class="card">
						<img src="images/1.png">
						<div class="content">
							<h1>Oil changing</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/2.png">
						<div class="content">
							<h1>Brake inspection & replacement</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/3.png">
						<div class="content">
							<h1>Tire balancing & replacement</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/4.png">
						<div class="content">
							<h1>Wheel alignment</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/5.png">
						<div class="content">
							<h1>Battery testing & replacement</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/6.png">
						<div class="content">
							<h1>A/C system inspection & repair</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/7.png">
						<div class="content">
							<h1>Fuel System Services</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/8.png">
						<div class="content">
							<h1>Wheel bearing replacement</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/9.png">
						<div class="content">
							<h1>Interior and exterior cleaning</h1>
						</div>
					</div>
					<div class="card">
						<img src="images/10.png">
						<div class="content">
							<h1>Wiring repairs</h1>
						</div>
					</div>
				</div>

			</div>
			<div class="map">
				<button class="active first"></button>
				<button class="second"></button>
				<button class="third"></button>
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
							<label for="servDate" class="form-label">Date<span
								class="require">*</span></label> <input type="date" class="form-control"
								id="servDate" name="servDate" required>
						</div>
						<div class="col-md-6">
							<label for="servTime" class="form-label">Time<span
								class="require">*</span></label> <input type="time" class="form-control"
								id="servTime" name="servTime" required>
						</div>
						<div class="col-12">
							<label for="servLocation" class="form-label">Preferred
								Location<span class="require">*</span>
							</label> <select class="form-select" aria-label="Default select example"
								id="servLocation" name="servLocation" required>
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
								Registration Number<span class="require">*</span>
							</label> <input type="text" class="form-control" id="vehNum"
								name="vehNum" placeholder="CAT 6224" required>
						</div>
						<div class="col-md-6">
							<label for="mileage" class="form-label">Current Mileage
								(km)<span class="require">*</span>
							</label> <input type="number" min="0" class="form-control" id="mileage"
								name="mileage" required>
						</div>
						<div class="col-12">
							<label for="servmsg" class="form-label">Message</label>
							<textarea class="form-control" id="servmsg" name="servmsg"
								rows="3"></textarea>
						</div>
						<input type="hidden" id="currentUser" name="currentUser" value="">
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
						<th scope="col"></th>
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

							// Compare the date with the current date
							Date currentDate = new Date();
							boolean isPastDate = date.before(currentDate);
					%>

					<tr>
						<td><%=bookingId%></td>
						<td><%=date%></td>
						<td><%=time%></td>
						<td><%=location%></td>
						<td><%=vehicleNo%></td>
						<td><%=mileage%></td>
						<td><%=message%></td>
						<td>
							<%
							if (isPastDate) {
							%> <!-- Show view icon for past dates -->
							<button class="btn btn-light" type="button" disabled>
								<i class="fa-solid fa-eye" style="color: #000000;"></i>
							</button> 
							<%
 							} else {
 							%> <!-- Show delete button for future dates -->
							<button class="btn btn-danger" type="submit"
								name="deleteConfirmation"
								onclick="$('#deleteConfirmationModal').modal('show'); document.getElementById('bookingID').value = <%=bookingId%>;">
								<i class="fa-solid fa-trash" style="color: #ffffff;"></i>
							</button> 
							<%
 								}
							%>
						</td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>
		<!-- Confirmation Popup Modal -->
		<div class="modal" id="deleteConfirmationModal" tabindex="-1"
			aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
			<form method="post">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="deleteConfirmationModalLabel">Delete
								Confirmation</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							Are you sure you want to delete? <input type="hidden"
								id="bookingID" name="bookingID" value="">

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal"
								onclick="$('#deleteConfirmationModal').modal('hide');">Cancel</button>
							<input type="submit" class="btn btn-danger" name="delete"
								id="delete" value="Delete"
								onclick="$('#deleteConfirmationModal').modal('hide');">
						</div>
					</div>
				</div>
			</form>
		</div>
	</section>

	<footer class="text-center text-lg-start"
		style="background-color: black; color: #ababab;">
		<div class="container p-5">
			<div class="row p-4">
				<div class="col-lg-6 col-md-12 mb-4 mb-md-0">

					<img class="footer-logo" src="./images/qFixLogo.png">
				</div>

				<div class="col-lg-6 col-md-12 mb-4 mb-md-0">
					<h4 class="text-uppercase">Quick Fix Bookings</h4>
					<h5 class="text-uppercase">Effortless Service Booking for Your
						Wheel</h5>

					<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit.
						Iste atque ea quis molestias. Fugiat pariatur maxime quis culpa
						corporis vitae repudiandae aliquam voluptatem veniam, est atque
						cumque eum delectus sint!</p>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="js/home.js"></script>
</body>
</html>