<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.values.*" %>
<%@ page import="com.general.DB_Conn" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>

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
    <link rel="stylesheet" href="./css/adminDistReq.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <title>Sea Food Using Blockchain</title>
</head>

<body>
    <div class="container">
    
	    <%
		if(request.getParameter("updated") != null) {
			out.println("<script>swal('Request Accepted', 'QR is Created Successfully...!', 'success');</script>");
		}
	    if(request.getParameter("nopro") != null) {
			out.println("<script>swal('Failed', 'No such Product Found...!', 'warning');</script>");	
		}
	    if(request.getParameter("noreq") != null) {
			out.println("<script>swal('Failed', 'No such request found...!', 'warning');</script>");	
		}
	    
	    if(request.getParameter("stock") != null) {
			out.println("<script>swal('Failed', 'Out of stock', 'error');</script>");
		}
	   %>

	    <!-- Navbar -->
	    <header class="header">
                <div class="navbar">
                    <a href="./adminHome.jsp" class="title">Sea Food Blockchain</a>
                    <ul class="navList">
                        <li class="navItem"><a href="./adminHome.jsp" class="navLink"> Home </a></li>
                        <li class="navItem"><a href="./adminAddProduct.jsp" class="navLink"> Add Product </a></li>
                        <li class="navItem"><a href="./adminDistReq.jsp" class="navLink">Distributer Requests</a></li>
                        <li class="navItem"><a href="./adminUpdateProducts.jsp" class="navLink">Product Info</a></li>
                        <li class="navItem"><a href="./adminHistory.jsp" class="navLink">Active Orders</a></li>
                        <li class="navItem"><a href="./adminPayBillHistory.jsp" class="navLink">Transaction History</a></li>
                        <li class="navItem"><a href="./index.jsp?logout" class="navLink"> Logout </a></li>
                    </ul>
                </div>

                <div class="toggle_btn">
                    <span class="material-symbols-outlined menuIcon">menu</span>
                </div>

                <div class="dropdown_menu">
                    <ul>
                        <li><a href="./adminHome.jsp"> Home </a></li>
                        <li><a href="./addminAddProduct.jsp"> Add Product </a></li>
                        <li><a href="./adminDistReq.jsp"> Distributer Requests </a></li>
                        <li><a href="./adminUpdateProducts.jsp"> Product Info </a></li>
                        <li><a href="./adminHistory.jsp"> Active Orders </a></li>
                        <li><a href="./adminPayBillHistory.jsp"> Transaction History </a></li>
                        <li><a href="./index.jsp?logout"> Logout </a></li>
                    </ul>
               </div>
         </header>


        <!-- Main Part -->
        <section class="mainDiv">
            <h2 class="titleTag">Product Information</h2>
            
            <div class="tableDiv">
	            <table class="contentTable">
	            	<thead class="tableHead">
		                <tr>
		                	<th>Sr No</th>
		                    <th>Distributer Name</th>
		                    <th>Distributer Email</th>
		                    <th>Quantity</th>
		                    <th>Product Name</th>
		                    <th>Company Name</th>
		                    <th>Date Time</th>
		                    <th>Status</th>
		                </tr>
	                </thead>
	                <tbody class="tableBody">
	                <%
	                try {
	                	Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
	                	Statement stmt= (Statement) conn.createStatement();
	                	
	                	String sql= "SELECT * FROM product_dist_req WHERE status= 'UNSET';";
	                	
	                	ResultSet rs= (ResultSet) stmt.executeQuery(sql);
		                int i= 0;
		                
		                while (rs.next()) {
		                	i++;
	                	%>
	                	<tr>
	                	
		                	<td><%=i %></td>
		                	<td><%= rs.getString(rs.findColumn("distName")) %></td>
		                	<td><%= rs.getString(rs.findColumn("distEmail")) %></td>
		                	<td><%= rs.getString(rs.findColumn("quantity")) %></td>
		                	<td><%= rs.getString(rs.findColumn("productName")) %></td>
		                	<td><%= rs.getString(rs.findColumn("companyName")) %></td>
		                	<td><%= rs.getString(rs.findColumn("timestamp")) %></td>
		                	
		                	<td>
		                        <div class="choiceBox">
		                            <a href="Accept?id=<%=rs.getString(rs.findColumn("productName"))%>,<%=rs.getString(rs.findColumn("id"))%>,<%=rs.getString(rs.findColumn("distEmail"))%>" class="choice">Accept</a>
		                            <div class="divider"></div>
		                            <a href="DistReject?id=<%=rs.getInt(rs.findColumn("id")) %>" class="choice reject">Reject</a>
		                        </div>
		                    </td>
		                	
	                	</tr>
	                	<%
	                }
	                } catch (Exception e0) {
	                	System.out.println(e0.getMessage());
	                	e0.printStackTrace();
	                }
	                %>
	              </tbody>
	            </table>
	        </div>

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
                    <div>
                        <p class="cTitle">E-mail </p>
                        <p class="cTitle">Mobile </p>
                    </div>
                    <div>
                        <p class="cValue"> abc@gmail.com</p>
                        <p class="cValue"> +91 965 652 2511</p>
                    </div>
                </div>
            </div>
        </footer>

        <script src="./js/home.js"></script>
    </div>

</body>

</html>