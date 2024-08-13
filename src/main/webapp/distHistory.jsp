<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.values.Values" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
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

        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
        <div class="container">
        
        <%
        String email= (String) request.getSession().getAttribute("loginEmail");
        if (email == null) {
        	response.sendRedirect("./index.jsp?logout");
        }
        %>

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
            <section class="mainDiv">
                <h3 class="tableTitle">Orders History</h3>
                
                <div class="tableDiv">
	                <table class="mainTable">
	                    <thead class="tableHead">
	                      <tr>
	                      	<th>Sr No</th>
	                      	<th>Distributer Email</th>
	                        <th>Product Name</th>
	                        <th>Company Name</th>
	                        <th>Quantity</th>
	                        <th>Order Date</th>
	                        <th>Status</th>
	                      </tr>
	                    </thead>
	
	                    <tbody class="tableBody">
	                    
	                    <%
	                    String sql= "SELECT * FROM  user_orders WHERE distEmail = '" + email + "' AND status != 'Shipped' ;";
	                    Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
	                    Statement st= (Statement) conn.createStatement();
	                    String status;
	                    
	                    ResultSet rs= (ResultSet) st.executeQuery(sql);
	                    int i= 0;
	                    
	                    while (rs.next()) {
	                    	i++;
	                    	%>
	                      <tr>
	                      	<td><%=i %></td>
	                      	<td><%=rs.getString(rs.findColumn("distEmail")) %></td>
	                        <td><%=rs.getString(rs.findColumn("productName")) %></td>
	                        <td><%=rs.getString(rs.findColumn("companyName")) %></td>
	                        <td><%=rs.getString(rs.findColumn("quantity")) %></td>
	                        <td><%=rs.getString(rs.findColumn("timestamp")) %></td>
                            <td>
                                <%
                                status= (String) rs.getString(rs.findColumn("status"));
                                System.out.println("Status :-> " + status);
                                
                                if (status.equals("Accepted")) {
                                	%>Accepted<%
                                } else {
                                	out.println("<span>Requested</span>");
                                }
                                %>
                            </td>
                          </tr>
	                    	<%
	                    }
	                    %>
	                    
	                    <%
                        String sql2= "SELECT * FROM  product_dist_req WHERE distEmail = '" + email + "' AND status != 'Shipped' ;";
                        System.out.println(sql);
                        Connection conn2= (Connection) DB_Conn.conn(Values.DB_Name);
                        Statement st2= (Statement) conn2.createStatement();
                        
                        ResultSet rs2= (ResultSet) st.executeQuery(sql2);                        
                        while (rs2.next()) {
                            i++;
                            %>
                          <tr>
                            <td><%=i %></td>
                            <td><%=rs2.getString(rs2.findColumn("distEmail")) %></td>
                            <td><%=rs2.getString(rs2.findColumn("productName")) %></td>
                            <td><%=rs2.getString(rs2.findColumn("companyName")) %></td>
                            <td><%=rs2.getString(rs2.findColumn("quantity")) %></td>
                            <td><%=rs2.getString(rs2.findColumn("timestamp")) %></td>
                            <td><%
                                status= (String) rs2.getString(rs2.findColumn("status"));
                                System.out.println("Status :-> " + status);
                                
                                if (status.equals("Accepted")) {
                                    %>Accepted<%
                                } else {
                                    out.println("<span>Requested</span>");
                                }
                                %></td>
                          </tr>
                            <%
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
                        <div><p class="cTitle">E-mail </p><p class="cTitle">Mobile </p> </div>
                        <div><p class="cValue"> abc@gmail.com</p><p class="cValue"> +91 965 652 2511</p></div>
                    </div>
                </div>
            </footer>

            <script src="./js/home.js"></script>
        </div>

    </body>

</html>