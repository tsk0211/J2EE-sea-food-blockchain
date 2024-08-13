<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
        <link rel="stylesheet" href="./css/adminAddProduct.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
    <%
   	String id= "0", qty= "0", ttl= "0", address= "abcd", mobile= "XXX-XXX-XXXX";
   	String[] arr= new String[2];
   	String pn= "", cn= "", exp= "", pr= "";
    
   	try {
    	if (request.getParameter("id") != null) {
    		id= request.getParameter("id");
    		arr= id.split(",");
    		System.out.println("\n" + arr[0] + "\t\t" + arr[1] + "\t\t ");
    	}
    	
    	String sql= "SELECT * FROM dist_orders WHERE timestamp = '" + arr[1] + "' and distEmail = '" + arr[0] + "';";
    	
    	Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
    	Statement stmt= (Statement) conn.createStatement();
    	
    	ResultSet rs= (ResultSet) stmt.executeQuery(sql);
    	    	
    	if (rs.next()) {
	    	pn= rs.getString(rs.findColumn("productName"));
	    	cn= rs.getString(rs.findColumn("companyName"));
	    	qty= rs.getString(rs.findColumn("quantity"));
	    	ttl= rs.getString(rs.findColumn("totalAmt"));
    	}
    	
    	String sqlIns= "SELECT * FROM product_table WHERE productName= '" + pn + "' and companyName = '" + cn + "';";
    	
    	Connection con= (Connection) DB_Conn.conn(Values.DB_Name);
    	Statement st= (Statement) con.createStatement();
    	
    	ResultSet rt= (ResultSet) st.executeQuery(sqlIns);
    	
    	if (rt.next()) {
	    	exp= rt.getString(rt.findColumn("exp"));
	    	pr= rt.getString(rt.findColumn("price"));
    	}
    	
    	String sqlSet= "SELECT * FROM disttable WHERE emailId = '" + arr[0] + "';";
    	
    	Connection c= (Connection) DB_Conn.conn(Values.DB_Name);
    	Statement s= (Statement) c.createStatement();
    	
    	ResultSet r= (ResultSet) s.executeQuery(sqlSet);
    	
    	if (r.next()) {
    		address= r.getString(r.findColumn("distAddress"));
    		mobile= r.getString(r.findColumn("distMobile"));
    	}
    	
    	System.out.println(pn + "\n" + cn + "\n" + qty + "\t" + ttl + "\n" + exp + "\n" + pr);
    	
    } catch (Exception e0) {
    	e0.printStackTrace();
    	out.println("<script>alert('Not logged in properly. Login again')</script>");
    	Thread.sleep(2000);
    	response.sendRedirect("index.jsp?logout");
    }
   	
   	
   	HttpSession s= request.getSession();
   	
   	s.setAttribute("time", arr[1]);
   	s.setAttribute("email", arr[0]);
   	
   	
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
            <section class="mainDiv">
                <div class="contentDiv">
                    <h2>Bill Info</h2>
                    <form action="OrderProduct" class="productForm" method="post">
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="productName">Product Name </label>
                                <input type="text" id="productName" value="<%=pn%>" name="productName" required readonly>
                            </div>
                            <div class="productItem">
                                <label for="companyName">Company Name </label>
                                <input type="text" id="companyName" value="<%=cn%>" name="companyName" required readonly>
                            </div>
                            <div class="productItem">
                                <label for="addressId">Shipping Address </label>
                                <input type="text" id="addressId" value="<%=address%>" name="address" required readonly>
                            </div>
                        </div>
                        
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="price">Price </label>
                                <input type="number" id="price" name="price" value="<%=pr%>" required readonly min="0" step="0.01">
                            </div>
                            <div class="productItem">
                                <label for="expDate">Expiry Date </label>
                                <input type="date" id="expDate" value="<%=exp%>" name="expDate" readonly required>
                            </div>
                            <div class="productItem">
                                <label for="mobileId">Mobile Number </label>
                                <input type="text" id="mobileId" value="<%=mobile%>" name="mobile" required readonly>
                            </div>
                        </div>
                        
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="quantity">Quantity </label>
                                <input type="number" id="quantity" name="quantity" value="<%=qty%>" readonly required min="1">
                            </div>

                            <div class="productItem">
                                <label for="quantity">Total Amount Of Order </label>
                                <input type="number" id="totalAmt" value="<%=ttl%>" name="totalAmt" readonly required min="1">
                            </div>

                            <input type="submit" value="Pay Bill" class="submit-btn">
                        </div>
                        
                    </form>
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