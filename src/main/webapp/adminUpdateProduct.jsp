<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
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

            
            <% 
            String id= "1";
            if (request.getParameter("id") != null) {
            	id= request.getParameter("id");
            }
            
            int pn, cn, qty, pr, exp;
            
            String sql= "SELECT * FROM product_table WHERE productId= '" + id + "';";
            Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
            Statement stmt= (Statement) conn.createStatement();
            
            ResultSet rs= (ResultSet) stmt.executeQuery(sql);
            
            
            rs.next();
            
            pn= rs.findColumn("productName");
            cn= rs.findColumn("companyName");
            qty= rs.findColumn("quantity");
            pr= rs.findColumn("price");
            exp= rs.findColumn("exp");
            
            String name= rs.getString(pn);
            String cname= rs.getString(cn);
            String quantity= rs.getString(qty);
            String price= rs.getString(pr);
            String exd= rs.getString(exp);
            String mfd= rs.getString(rs.findColumn("mfd"));
            String desc= rs.getString(rs.findColumn("description"));
            
            %>

            <!-- Main Part -->
            <section class="mainDiv">
                <div class="contentDiv">
                    <h2>Product Form</h2>
                    <form action="UpdateProduct?id<%=id%>" class="productForm" method="post">
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="productName">Product Name </label>
                                <input type="text" id="productName" value="<%=name%>" name="productName" required>
                            </div>
                            <div class="productItem">
                                <label for="companyName">Company Name </label>
                                <input type="text" id="companyName" value="<%=cname%>" name="companyName" required>
                            </div>
                            <div class="productItem">
                                <label for="description">Description </label>
                                <textarea id="description" name="description" required><%=desc%></textarea>
                            </div>
                        </div>
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="mfgDate">Manufacturing Date </label>
                                <input type="date" id="mfgDate" name="mfgDate" value="<%=mfd%>" required>
                            </div>
                            <div class="productItem">
                                <label for="price">Price </label>
                                <input type="number" id="price" name="price" value="<%=price%>" required min="0" step="0.01">
                            </div>
                            <div class="productItem">
                                <label for="expDate">Expiry Date </label>
                                <input type="date" id="expDate" name="expDate" value="<%=exd%>" required>
                            </div>
                        </div>
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="quantity">Quantity </label>
                                <input type="number" id="quantity" name="quantity" value="<%=quantity%>" required min="1">
                            </div>

                            <input type="submit" value="Add Product" class="submit-btn">
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