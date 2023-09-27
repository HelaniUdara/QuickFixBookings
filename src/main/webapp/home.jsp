<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<title>QuickFixBookings-Home</title>
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
</head>
<body>
	<nav class="navbar fixed-top navbar-expand-lg">
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
						href="#newBooking">New Booking</a></li>
					<li class="nav-item"><a class="nav-link item" href="#bookings">Bookings</a>
					</li>
				</ul>
				<button class="btn btn-outline-primary" type="submit">Logout</button>
				<!-- x
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
				-->
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
								<td>Helani</td>
							</tr>
							<tr>
								<th>Username :</th>
								<td></td>
								<td>Helani_Udara</td>
							</tr>
							<tr>
								<th>Email :</th>
								<td></td>
								<td>udarahSeekku@gmail.com</td>
							</tr>
							<tr>
								<th>Contact No :</th>
								<td></td>
								<td>0712345673</td>
							</tr>
							<tr>
								<th>Country :</th>
								<td></td>
								<td>Sri Lanka</td>
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
								type="date" class="form-control" id="servDate">
						</div>
						<div class="col-md-6">
							<label for="servTime" class="form-label">Time</label> <input
								type="time" class="form-control" id="servTime">
						</div>
						<div class="col-12">
							<label for="servLocation" class="form-label">Preferred
								Location</label> <select class="form-select"
								aria-label="Default select example" id="servLocation">
								<option selected>Choose preferred district</option>
								<option value="1">Colombo</option>
								<option value="2">Gampaga</option>
								<option value="3">Kaluthara</option>
								<option value="4">Galle</option>
								<option value="5">Matara</option>
								<option value="6">Hambanthota</option>
							</select>
						</div>
						<div class="col-6">
							<label for="vehNum" class="form-label">Vehicle
								Registration Number</label> <input type="text" class="form-control"
								id="vehNum" placeholder="CAT 6224">
						</div>
						<div class="col-md-6">
							<label for="mileage" class="form-label">Current Mileage
								(km)</label> <input type="number" min="0" step="0.01"
								class="form-control" id="mileage">
						</div>
						<div class="col-12">
							<label for="servmsg" class="form-label">Message</label>
							<textarea class="form-control" id="servmsg" rows="3"></textarea>
						</div>

						<div class="col-12">
							<button type="submit" class="btn btn-primary">Book</button>
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
					<tr>
						<th scope="row">1</th>
						<td>Mark</td>
						<td>Otto</td>
						<td>@mdo</td>
						<td>Mark</td>
						<td>Otto</td>
						<td>@mdo</td>
					</tr>
					<tr>
						<th scope="row">2</th>
						<td>Jacob</td>
						<td>Thornton</td>
						<td>@fat</td>
						<td>Jacob</td>
						<td>Thornton</td>
						<td>@fat</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
	 <div class="footer-dark">
        <footer>
            <div class="container">
                <div class="row social">
                    <div class="col-md-12 item text">
                        <h3>Quick Fix Bookings</h3>
                        <p>Praesent sed lobortis mi. Suspendisse vel placerat ligula. Vivamus ac sem lacus. Ut vehicula rhoncus elementum. Etiam quis tristique lectus. Aliquam in arcu eget velit pulvinar dictum vel in justo.</p>
                    </div>
                    <div class="col item social"><a href="#"><i class="icon ion-social-facebook"></i></a><a href="#"><i class="icon ion-social-twitter"></i></a><a href="#"><i class="icon ion-social-instagram"></i></a></div>
                </div>
                <p class="copyright">QuickFixBookings © 2023 | Created by Helani Seekkubadu</p>
            </div>
        </footer>
    </div>
</body>
</html>