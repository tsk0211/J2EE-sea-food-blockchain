<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="./css/adminUpdate.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
    <%
    if (request.getParameter("succ") != null) {
            out.println("<script>swal('Order Placed', 'Order Placed to Admin', 'success');</script>");
    }
    if (request.getParameter("invalid") != null) {
        out.println("<script>swal('Order Not Placed', 'Problem Ordering Failed !', 'warning');</script>");
    }
    %>
        <div class="container">

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
                <h3 class="tableTitle">Product List</h3>
                
                <div class="tableDiv">
	                <table class="mainTable">
	                    <thead class="tableHead">
	                      <tr>
	                        <th>Sr. No.</th>
	                        <th>Product Name</th>
	                        <th>Company Name</th>
	                        <th>Quantity</th>
	                        <th>Price</th>
	                        <th>Expiry Date</th>
	                        <th>Actions</th>
	                      </tr>
	                    </thead>
	
	                    <tbody class="tableBody">
	                    
	                    <%
	                    String sql= "SELECT * FROM product_table;";
	                    Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
	                    Statement stmt= (Statement) conn.createStatement();
	                    
	                    ResultSet rs= (ResultSet) stmt.executeQuery(sql);
	                    
	                    int pn, cn, qty, pr, exp;
	                    
	                    pn= rs.findColumn("productName");
	                    cn= rs.findColumn("companyName");
	                    qty= rs.findColumn("quantity");
	                    pr= rs.findColumn("price");
	                    exp= rs.findColumn("exp");
	                    int id= rs.findColumn("productId"), op= 0;
	                    
	                    while (rs.next()) {
	                    	op++;
	                    %>
	                    
	                      <tr>
	                        <td><%=op%></td>
	                      	<td><%=rs.getString(pn)%></td>
	                        <td><%=rs.getString(cn)%></td>
	                        <td><%=rs.getString(qty) %></td>
	                        <td> ₹ <%=rs.getString(pr) %></td>
	                        <td><%=rs.getString(exp) %></td>
	                        <td>
	                            <div class="buttonsDiv">
	                                <a href="./adminUpdateProduct.jsp?id=<%=rs.getInt(id)%>"  class="buttons">Edit</a>
	                                <a href="AdminDeleteProduct?id=<%=rs.getInt(id)%>" class="buttons">Delete</a>
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