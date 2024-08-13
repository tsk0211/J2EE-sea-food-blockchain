<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
        <link rel="stylesheet" href="./css/adminUpdate.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
    	<%
    	String distEmail= (String) request.getSession().getAttribute("loginEmail");
    	
    	if (request.getParameter("msg") != null) {
	    	if (request.getParameter("msg").equals("fail")) {
	    		out.println("<script>swal('Something gone wrong','Order Not Placed !!','warning')</script>");
	    	}
	    	if (request.getParameter("msg").equals("succ")) {
	    		out.println("<script>swal('Success','Order Placed Successfully!!','success')</script>");
	    	}
    	}
    	%>
    
    
    
        <div class="container">

            <!-- Navbar -->
            <header class="header">
                <div class="navbar">
                    <a href="./userHome.jsp%>" class="title">Sea Food Blockchain</a>
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
                <h3 class="tableTitle">Product List</h3>
                
                <div class="tableDiv">
	                <table class="mainTable">
	                    <thead class="tableHead">
	                      <tr>
	                      	<th>Sr No</th>
	                        <th>Product Name</th>
	                        <th>Company Name</th>
                            <th>Description</th>
                            <th>Expiry Date</th>
	                        <th>Price</th>
	                        <th>Actions</th>
	                      </tr>
	                    </thead>
	
	                    <tbody class="tableBody">
	                    
	                    <%
	                    
	                    String sql= "SELECT * FROM product_table;";
	                    
	                    Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
	                    Statement stmt= (Statement) conn.createStatement();
	                    
	                    ResultSet rs= (ResultSet) stmt.executeQuery(sql);
	                    
	                    int pn, cn, qty, pr, exp, i= 0;
	                    
	                    pn= rs.findColumn("productName");
	                    cn= rs.findColumn("companyName");
	                    pr= rs.findColumn("price");
	                    
	                    while (rs.next()) {
	                    	i++;
	                    %>
	                    
	                      <tr>
	                      	<td><%=i%></td>
	                      	<td><%=rs.getString(pn)%></td>
	                        <td><%=rs.getString(cn)%></td>
	                        <td><%=rs.getString(rs.findColumn("description")) %></td>
	                        <td><%=rs.getString(rs.findColumn("exp")) %></td>
	                        <td> ₹ <%=rs.getString(pr)%></td>
	                        <td>
	                            <div class="buttonsDiv">
	                                <a href="./userOrderProduct.jsp?id=<%=rs.getString(pn)%>,<%=rs.getString(cn)%>,<%=rs.getString(pr)%>" class="buttons">Order</a>
	                            </div>
	                        </td>
	                      </tr>
	                      
	                      <% } %>
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
                        <div><p class="cTitle">E-mail </p><p class="cTitle">Mobile </p> </div>
                        <div><p class="cValue"> abc@gmail.com</p><p class="cValue"> +91 965 652 2511</p></div>
                    </div>
                </div>
            </footer>

            <script src="./js/home.js"></script>
        </div>

    </body>

</html>