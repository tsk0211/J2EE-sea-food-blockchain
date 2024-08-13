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

    <link rel="stylesheet" href="./css/style.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <title>Seafood Supply Chain</title>
</head>
<body>
	<% if(request.getParameter("logout")!=null) {
		request.getSession().invalidate();
		request.getSession(true);
		Thread.sleep(2000);
		out.println("<script>swal('Logout Done', 'Logout Successfully !', 'success')</script>");
		}
	
		if (request.getParameter("Done") != null) {
			out.println("<script>swal('Regestration Done !', 'Congratulations....Profile Added Successfully ...!', 'success');</script>");
		} else if(request.getParameter("notreg") != null) {
			out.println("<script>swal('Regestraion Problem', 'Not Registration done...!', 'warning');</script>");
		} else if (request.getParameter("invalid") != null) {
			out.println("<script>swal('Invalid Credentials', 'Invalid Login Credential...!', 'error')</script>");
		} else if (request.getParameter("succ") != null) {
			out.println("<script>swal('Congratulations', 'Register Successfully...!', 'success')</script>");
		}
	%>


    <a href="./index.jsp" class="title">Sea Food Supply Chain Using Blockchain</a>

    <div class="wrapper">
        <form action="AddLogin" method="post">
            <h1 class="titleLogo">Login</h1>
            <div class="rolesDiv">
                <span class="material-symbols-outlined bolt">bolt</span>
                <select name="role" class="roles" id="selectItem" name="role" required>
                    <option value="" selected>Select Role</option>
                    <option value="Admin">Admin</option>
                    <option value="Distributer">Distributer</option>
                    <option value="User">User</option>
                </select>
            </div>

            <div class="input-box">
                <input type="text" name="email" pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" placeholder="Email  eg. myemail@gmail.com" required>
                <span class="material-symbols-outlined icons">person</span>
            </div>
            <div class="input-box">
            	<span id="visibilityBtn" onclick="visibilityFunc(this)" class="material-symbols-outlined visibilityIcon">visibility_off</span>
                <input type="password" id="pw1" name="password" placeholder="Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
						title="Must contain at least one number and one uppercase and lowercase letter, 
						and at least 8 or more characters" required>
				<span class="material-symbols-outlined icons">password</span>
            </div>

            <div class="submitDiv">
                <input type="submit" class="submitBtn" value="Login">
            </div>

            <div class="regester-link">
                <p>Already Have a account, <a href="./register.jsp">Create New Account</a> .</p>
            </div>
        </form>
    </div>
    
    <script src="./js/script1.js"></script>
</body>
</html>