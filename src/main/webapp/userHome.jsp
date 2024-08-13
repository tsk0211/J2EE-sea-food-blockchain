<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.values.Values" %>
<%@ page import="com.general.DB_Conn" %>

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

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
        <div class="container">
        	<%
        	String loginEmail= (String) request.getSession().getAttribute("loginEmail");
        	if (loginEmail == null) {
        		out.println("<script>alert('User needs to be logged in....')</script>");
        		response.sendRedirect("./index.jsp");
        		}
        	
            String name= "", address= "", mob_no= "", emailId= "", ini= "";
            System.out.println("This works ....");
            
            if (true) {
            	try {
            		Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
                    Statement stmt= (Statement) conn.createStatement();
                    String sql= "SELECT * FROM userTable WHERE emailId= '" + loginEmail + "';";
                    
                    ResultSet rs= (ResultSet) stmt.executeQuery(sql);
                    
                    while (rs.next()) {
                    	name= (String) rs.getString(rs.findColumn("userName"));
                    	address= rs.getString(rs.findColumn("userAddress"));
                    	mob_no= rs.getString(rs.findColumn("userMobile"));
                    	emailId= rs.getString(rs.findColumn("emailId"));
                    	ini= "" + name.charAt(0);
                    	
                    	System.out.println("Data :-> " + name + " - " + emailId + " - " + address + " - " + mob_no);
                    }
                    
            	} catch (Exception e) {
            		e.printStackTrace();
            	}
            	
            }
            
            
            %>

            <!-- Navbar -->
            <header class="header">
                <div class="navbar">
                    <a href="./userHome.jsp" class="title">Sea Food Blockchain</a>
                    <ul class="navList">
                    	<li class="navItem"><a href="./userHome.jsp" class="navLink">Home</a></li>
						<li class="navItem"><a href="./userOrder.jsp" class="navLink">Order</a></li>
						<li class="navItem"><a href="./userQrUpload.jsp" class="navLink">QR Code Verify</a></li>
						<li class="navItem"><a href="./userHistory.jsp" class="navLink">Transaction History</a></li>
						<li class="navItem"><a href="./index.jsp?logout" class="navLink">Logout</a></li>
                    </ul>
                </div>

                <div class="toggle_btn">
                    <span class="material-symbols-outlined menuIcon">menu</span>
                </div>

                <div class="dropdown_menu">
                    <ul>
                        <li><a href="./userHome.jsp">Home</a></li>
                        <li><a href="./userOrder.jsp">Order</a></li>
                        <li><a href="./userQrUpload.jsp">QR Code Verify</a></li>
                        <li><a href="./userHistory.jsp"> Transaction History </a></li>
                        <li><a href="./index.jsp?logout"> Logout </a></li>
                    </ul>
                </div>
            </header>

            <!-- Main Part -->
            <section class="mainDiv">
            <form class="mainDiv" action="UpdateAdmin" method="get">
                <div class="contentDiv">
                    <div class="upperDiv">
                        <div class="imgDiv">
                            <div class="textLogo"><%=ini%></div>
                        </div>
                        <div class="infoDiv">
                            <input type="text" id="nameTag" value= "<%=name%>" disabled required>
                            <input type="text" id="mob_no" value= "<%=mob_no%>" disabled required>
                        </div>
                    </div>
                    <div class="infoDiv2">
                        <input type="email" id="email" value="<%=loginEmail%>" disabled required>
                        <input type="text" id="address" value="<%=address%>" disabled required>
                    </div>
                </div>

                <div class="btnsDiv">
                    <div onclick="editCheck()" class="btn editBtn">Edit</div>
                    <input type="submit" class="btn saveBtn" value="Update">
                </div>
            </form>
                
            </section>

            <!-- Footer -->
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
        </div>

    </body>

</html>