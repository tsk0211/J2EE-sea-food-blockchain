<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="./css/adminAddProduct.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <title>Sea Food Using Blockchain</title>
    </head>

    <body>
    	
    	<%
    	if (request.getParameter("succ") != null) {
    		out.println("<script>swal('Product Added','Product added successfully !!','success')</script>");
    	}
    	if (request.getParameter("fail") != null) {
    		out.println("<script>swal('Something gone wrong','Order Not Placed !!','warning')</script>");
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
                <div class="contentDiv">
                    <h2>Product Form</h2>
                    <form action="AddProduct" class="productForm" method="post">
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="productName">Product Name </label>
                                <input type="text" id="productName" name="productName" required>
                            </div>
                            <div class="productItem">
                                <label for="companyName">Company Name </label>
                                <input type="text" id="companyName" name="companyName" required>
                            </div>
                            <div class="productItem">
                                <label for="description">Description </label>
                                <textarea id="description" name="description" required></textarea>
                            </div>
                        </div>
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="mfgDate">Manufacturing Date </label>
                                <input type="date" id="mfgdate" name="mfgDate" required>
                            </div>
                            <div class="productItem">
                                <label for="price">Price </label>
                                <input type="number" id="price" name="price" required min="0" step="0.01">
                            </div>
                            <div class="productItem">
                                <label for="expDate">Expiry Date </label>
                                <input type="date" id="expDate" name="expDate" required>
                            </div>
                        </div>
                        <div class="partDiv">
                            <div class="productItem">
                                <label for="quantity">Quantity </label>
                                <input type="number" id="quantity" name="quantity" required min="1">
                            </div>

                            <input type="submit" value="Add Product" class="submit-btn">
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