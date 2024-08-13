package com.distribute;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.general.DB_Conn;
import com.values.Values;
import com.blockchain.Transaction;

@WebServlet("/OrderProduct")
public class OrderProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public OrderProduct() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email= (String) request.getSession().getAttribute("loginEmail") ;
		String expdate= "", desc= "", mfd= "", pr= "";
		int id= 0;
		
		String productName = request.getParameter("productName");
		String companyname = request.getParameter("companyName");
		String distAddress = request.getParameter("address");
		String amount = request.getParameter("totalAmt");
		String mobile = request.getParameter("mobile");
		String qty = request.getParameter("quantity");
		
		String distReqId= (String) request.getSession().getAttribute("distReqId");
		
		String sql= "SELECT * FROM product_table WHERE productName = '" + productName + "' and companyName = '" + companyname + "';";
		
		try {
			Connection con= (Connection) DB_Conn.conn(Values.DB_Name);
			Statement st= (Statement) con.createStatement();
			ResultSet rs= (ResultSet) st.executeQuery(sql);
			
			if (rs.next()) {
				id = rs.getInt(rs.findColumn("productId"));
				expdate = rs.getString(rs.findColumn("exp"));
				desc = rs.getString(rs.findColumn("Description"));
				mfd= rs.getString(rs.findColumn("mfd"));
				pr= rs.getString(rs.findColumn("price"));
			}
		} catch (Exception e0) {
			e0.printStackTrace();
		}
		
		String timestamp= new SimpleDateFormat("yyyy-MM-dd hh.mm.ss").format(new Date());
		
		Transaction tr= new Transaction(Values.admin_email, email, mobile, productName, companyname,
				timestamp, qty, amount, distAddress, id);
		
		String sqlInsert= "INSERT INTO `supplychaindb`.`transaction_table` (`src`, `dst`, `productName`, " +
				"`companyName`, `mobile`, `timestamp`, `address`, `quantity`, `amount`, `product_id`) VALUES ( '" +
				tr.source + "', '" +  tr.destination + "', '" + tr.typeOfFish + "', '" + tr.company + "', '" +
				tr.destMobile + "', '" + tr.dateTime + "', '" + tr.deliveryAddr + "', '" + tr.qty + "', '" +
				tr.finalAmount  + "', " + tr.productCode + " );";
		
		String exd= (String) expdate;
		
		String prodSql= "INSERT INTO `supplychaindb`.`dist_product_table` (`distEmail`, `productName`, `companyName`," +
						"`quantity`, `expdate`, `mfgdate`, `price`, `timestamp`, `description`) VALUES ('" +
						email + "', '" + productName + "', '" + companyname + "', '" + qty + "', '" + exd + "', '" +
						mfd + "', '" + pr + "', '" + timestamp + "', '" + desc + "')";
		
		String sl= "UPDATE `supplychaindb`.`product_dist_req` SET `status` = 'Shipped' WHERE `id` = '" + distReqId + "';";
		
		
		HttpSession s= request.getSession();
		
		s.setAttribute("sql", prodSql);
		s.setAttribute("orderSql", sqlInsert);
		s.setAttribute("sl", sl);
		s.setAttribute("transaction", tr);
		
		RequestDispatcher rd= request.getRequestDispatcher("./PaymentPage.jsp");
		rd.forward(request, response);
	}

}