<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="apple-touch-icon" sizes="180x180" href="./images/icon/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="./images/icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="./images/icon/favicon-16x16.png">
<link rel="manifest" href="./images/icon/site.webmanifest">

<link rel="stylesheet" href="./css/registerStyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<title>Sea food Supply Chain</title>
</head>

<body>
	<% if(request.getParameter("notreg") != null) {
		out.println("<script>alert('Wrong Data Entered!')</script>");
	}
	%>

	<a href="./index.jsp" class="title">Sea Food Supply Chain Using Blockchain</a>

	<div class="wrapper">
		<form action="AddRegister" method="post">
			<h1 class="titleLogo">Register</h1>

			<div class="rolesDiv">
				<span class="material-symbols-outlined icons bolt">bolt</span>
				<select class="roles" id="selectItem" name="role" required>
					<option value="" selected>Select Role</option>
					<option value="Distributer">Distributer</option>
					<option value="User">User</option>
				</select>
			</div>

			<div class="inp-section">
				<div class="input-box">
					<input type="text" name="username" placeholder="User Name (Full Name)" required>
					<span class="material-symbols-outlined icons">person</span>
				</div>
				<div class="input-box">
					<input type="text" name="email"
						pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"
						title="Please enter in abc@example.com format."
						placeholder="Email eg. myemail@gmail.com" required> <span
						class="material-symbols-outlined icons">mail</span>
				</div>
			</div>
			<div class="inp-section">
				<div class="input-box">
					<input type="text" name="address" placeholder="Address" required>
					<span class="material-symbols-outlined icons">location_on</span>
				</div>
				<div class="input-box">
					<input type="number" pattern="[7-9][0-9]{9}" name="mob_no" placeholder="Mobile Number" required>
					<span class="material-symbols-outlined icons">call</span>
				</div>
			</div>
			<div class="inp-section">
				<div class="input-box">
					<input type="password" id="p1" onkeyup="check()" name="password"
						placeholder="Password"
						pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
						title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
						required> <span class="material-symbols-outlined icons">key</span>
					<span class="material-symbols-outlined visibleBtn v1"
						onclick="visibilityFunc1(this)">visibility_off</span>
				</div>
				<div class="input-box" id="passSec">
					<input type="password" id="p2" onkeyup="check()" name="cnfPassword"
						placeholder="Confirm Password" required> <span
						class="material-symbols-outlined icons">vpn_key</span>
					<span class="material-symbols-outlined visibleBtn" onclick="visibilityFunc2(this)">visibility_off</span>
				</div>
			</div>

			<div class="submitDiv">
				<input type="submit" id="submitBtn" class="submitBtn" value="Sign Up">
			</div>

			<div class="regester-link">
				<p>
					Already have an account? <a href="./index.jsp">Log in</a> .
				</p>
			</div>
		</form>
	</div>

	<script src="./js/script.js"></script>

</body>

</html>