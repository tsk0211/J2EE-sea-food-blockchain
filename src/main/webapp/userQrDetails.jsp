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

        <link rel="apple-touch-icon" sizes="180x180" href="./icon/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="./icon/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="./icon/favicon-16x16.png">
        <link rel="manifest" href="./icon/site.webmanifest">

        <link rel="stylesheet" href="./css/home.css">
        <link rel="stylesheet" href="./css/adminAddProduct.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
    
	    <%
	   	String id= "0", timest= "0", qty= "0", ttl= "0";
	   	String[] arr= new String[2];
	   	String pn= "", cn= "", exp= "", pr= "";
	    try {
	    	if (request.getParameter("id") != null) {
	    		id= request.getParameter("id");
	    		arr= id.split(",");
	    	}
	    	
	    	String sql= "SELECT * FROM user_orders WHERE timestamp = '" + arr[1] + "' and userEmail = '" + arr[0] + "';";
	    	
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
	    	
	    } catch (Exception e0) {
	    	e0.printStackTrace();
	    	out.println("<script>alert('Not logged in properly. Login again')</script>");
	    	Thread.sleep(2000);
	    	response.sendRedirect("");
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
                <div class="contentDiv">
                    <h2>Bill Info</h2>
                    <form action="Payment" class="productForm" method="post">
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="productName">Product Name </label>
                                <input type="text" id="productName" value="<%=pn%>" name="productName" required readonly>
                            </div>
                            <div class="productItem">
                                <label for="companyName">Company Name </label>
                                <input type="text" id="companyName" value="<%=cn%>" name="companyName" required readonly>
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
                        </div>
                        
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="quantity">Quantity </label>
                                <input type="number" id="quantity" name="quantity" value="<%=qty%>" readonly required min="1">
                            </div>

                            <div class="productItem">
                                <label for="quantity">Total Amount Of Order </label>
                                <input type="number" id="quantity" value="<%=ttl%>" name="totalAmt" readonly required min="1">
                            </div>

                            <input type="submit" value="Pay Bill" class="submit-btn">
                        </div>
                        
                    </form>
                </div>
                
            </section>

            <!-- Footer -->
            <footer class="footDiv">
                <div class="imageDiv">
                    <img src="./icon/abc.png" alt="Block Image" class="footerImg">
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