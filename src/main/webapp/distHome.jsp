<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.values.*" %>
<%@page import="com.general.*" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="apple-touch-icon" sizes="180x180" href="./images/icon/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="./images/icon/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="./images/icon/favicon-16x16.png">
        <link rel="manifest" href="./images/icon/site.webmanifest">

        <link rel="stylesheet" href="./css/home.css">
        <link rel="stylesheet" href="./css/adminHomePage.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
        <!-- Add the info section -->
        <%
        String email= "";
        String name= "", address= "", mob_no= "", emailId= "", ini= "";
        
        if (request.getSession().getAttribute("loginEmail") != null) {
        	email= (String) request.getSession().getAttribute("loginEmail");
        } else {
    		out.println("<script>swal('User needs to be logged in....', 'Log in again', 'warning')." +
    		            "then(() => { window.location.href = './index.jsp'; });</script>");
    	}
        
        if (request.getParameter("msg") != null) {
        	if (request.getParameter("msg").equals("fail")) {
        		out.println("<script>swal('Payment Failed!', 'Block Not Added!', 'error');</script>");
        	} else if (request.getParameter("msg").equals("succ")) {
        		out.println("<script>swal('Payment Successful !', 'Transaction Successful Block Added Successful !', 'success');</script>");
        	}
        }
        
        if (!(email.equals(""))) {
        	try {
        		Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
                Statement stmt= (Statement) conn.createStatement();
                String sql= "SELECT * FROM distTable WHERE emailId= '" + email + "';";
                
                ResultSet rs= (ResultSet) stmt.executeQuery(sql);
                
                if (rs.next()) {
                	name= (String) rs.getString(rs.findColumn("distName"));
                	address= rs.getString(rs.findColumn("distAddress"));
                	mob_no= rs.getString(rs.findColumn("distMobile"));
                	emailId= rs.getString(rs.findColumn("emailId"));
                	ini= "" + name.charAt(0);
                	
                	System.out.println("Data :-> " + name + " - " + emailId + " - " + address + " - " + mob_no);
                } else {
                	out.println("<script>swal('Regestration Failed !', 'Email not regestration !', 'warning');</script>");
                	response.sendRedirect("./index.jsp?notreg");
                }
                
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        	
        }
        
        
        %>
    
        <div class="container">

            <!-- Navbar -->
            <header class="header">
                <div class="navbar">
                    <a href="./distHome.jsp" class="title">Sea Food Blockchain</a>
                    <ul class="navList">
                    	<li class="navItem"><a href="./distHome.jsp" class="navLink">Home</a></li>
						<li class="navItem"><a href="./distOrderProducts.jsp" class="navLink">Order Product</a></li>
						<li class="navItem"><a href="./distQrUpload.jsp" class="navLink">Confirm Order</a></li>
						<li class="navItem"><a href="./distUserOrders.jsp" class="navLink">User Orders </a></li>
						<li class="navItem"><a href="./distHistory.jsp" class="navLink">Orders History</a></li>
						<li class="navItem"><a href="./distPayBillHistory.jsp" class="navLink">Payment History</a></li>
						<li class="navItem"><a href="./index.jsp?logout" class="navLink">Logout</a></li>
                    </ul>
                </div>

                <div class="toggle_btn">
                    <span class="material-symbols-outlined menuIcon">menu</span>
                </div>

                <div class="dropdown_menu">
                    <ul>
                        <li><a href="./distHome.jsp"> Home </a></li>
						<li><a href="./distOrderProducts.jsp">Order Product</a></li>
                        <li><a href="./distQrUpload.jsp">Confirm Order</a></li>
						<li><a href="./distUserOrders.jsp">User Orders</a></li>
						<li><a href="./distHistory.jsp">Orders History</a></li>
						<li><a href="./distPayBillHistory.jsp">Payment History</a></li>
                        <li><a href="./index.jsp?logout"> Logout </a></li>
                    </ul>
                </div>
            </header>
            
            <!-- Main Part -->
            <form class="mainDiv" action="UpdateAdmin" method="get">
                <div class="contentDiv">
                    <div class="upperDiv">
                        <div class="imgDiv">
                            <div class="textLogo"><%=ini%></div>
                        </div>
                        <div class="infoDiv">
                            <input type="text" id="nameTag" value= "<%=name %>" disabled required>
                            <input type="text" id="mob_no" value= "<%=mob_no %>" disabled required>
                        </div>
                    </div>
                    <div class="infoDiv2">
                        <input type="email" id="email" value="<%=email %>" disabled required>
                        <input type="text" id="address" value="<%=address %>" disabled required>
                    </div>
                </div>

                <div class="btnsDiv">
                    <div onclick="editCheck()" class="btn editBtn">Edit</div>
                    <input type="submit" class="btn saveBtn" value="Update">
                </div>
            </form>

            <footer class="footDiv">
                <div class="imageDiv">
                    <img src="./images/icon/abc.png" alt="Block Image" class="footerImg">
                </div>
                
                <div class="footerTitle">From Ocean to Plate, Trust Our Blockchain State !</div>
                
                <div class="footerContact">
                    <h3 class="contactTitle">Contact</h3>
                    <div class="contactDiv">
                        <div><p class="cTitle">E-mail </p><p class="cTitle">Mobile </p> </div>
                        <div><p class="cValue"> abc@gmail.com</p><p class="cValue"> +91 965 652 2511</p></div>
                    </div>
                </div>
            </footer>

            <script src="./js/home.js"></script>
            <script src="./js/admin.js"></script>
        </div>

    </body>

</html>