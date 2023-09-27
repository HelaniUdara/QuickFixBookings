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
						<table>
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
	<section id="newBooking"></section>
	<section id="bookings"></section>
</body>
</html>