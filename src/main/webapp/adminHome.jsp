<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="com.values.*" %>

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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
    
    	<% 
    		if (request.getParameter("succ") != null) {
    			out.println("<script>swal('Login Success', 'Logged in Successfully !', 'success')</script>");
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
            <form class="mainDiv" action="UpdateAdmin" method="get">
                <div class="contentDiv">
                    <div class="upperDiv">
                        <div class="imgDiv">
                            <div class="textLogo">A</div>
                        </div>
                        <div class="infoDiv">
                            <input type="text" id="nameTag" value="Admin" disabled required>
                            <input type="text" id="mob_no" value="......" disabled required>
                        </div>
                    </div>
                    <div class="infoDiv2">
                        <input type="email" id="email" value="admin@gmail.com" disabled required>
                        <input type="text" id="address" value="--||--" disabled required>
                    </div>
                </div>

                <div class="btnsDiv">
                    <div onclick="editCheck()" class="btn editBtn">Edit</div>
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