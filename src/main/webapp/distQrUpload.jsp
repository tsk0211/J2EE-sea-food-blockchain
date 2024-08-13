<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.values.Values" %>

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
        <link rel="stylesheet" href="./css/QR.css">
        
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
    <%
    if (request.getParameter("unable") != null) {
    	out.println("<script>swal('Failed to Scan', 'QR code not valid !', 'error');</script>");
    }
    if (request.getParameter("notuser") != null) {
    	out.println("<script>swal('ID Not Valid','QR code does not have same ids !', 'warning')." +
    		"then((t) => { window.loaction.href= './distHome.jsp';});</script>");
    }
    if (request.getParameter("notvalid") != null) {
    	out.println("<script>swal('Invalid QR Code','QR code is not valid and represents something else !', 'error')." +
    		"then((t) => { window.loaction.href= './distHome.jsp';});</script>");
    }
    if (request.getParameter("dup_qr") != null) {
        out.println("<script>swal('Again Scanned QR','Order is Before Accepted Successfully !', 'error')." +
            "then((t) => { window.loaction.href= './distHome.jsp';});</script>");
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
            <section class="mainDiv">
                <form action="DistQrCode" method="post" enctype="multipart/form-data">
                    <div id="dropArea" ondrop="dropHandler(event)" ondragover="dragOverHandler(event)">
                        <img id="uploadedImage" class="imgClose" src="#" alt="Uploaded Image">
                        
                        <p>Drag and drop your file here</p>
                        <p>or</p>
                        <input type="file" id="fileInput" name="qrcodefile" onchange="fileInputChangeHandler(event)" required>
                    </div>

                    <input class="sbt-btn" type="submit" value="Upload Qr Code">
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
            <script src="./js/QR.js"></script>
        </div>

    </body>

</html>