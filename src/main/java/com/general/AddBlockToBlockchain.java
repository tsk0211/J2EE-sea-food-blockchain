package com.general;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.Statement;
import com.values.Values;
import com.blockchain.AddBlockClass;
import com.blockchain.Transaction;


@WebServlet("/AddBlock")
public class AddBlockToBlockchain extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	public AddBlockToBlockchain() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		String s= (String) request.getSession().getAttribute("orderSql");
		String sql= (String) request.getSession().getAttribute("sql");
		String sl= (String) request.getSession().getAttribute("sl");
		Transaction tr= (Transaction) request.getSession().getAttribute("transaction");
				
		System.out.println("\n-----\n\torderSql : \t" + s + "\n\n-----");
		System.out.println("\nTransaction : \t" + tr.toString());
		System.out.println("SL : \t" + sl + "\n\n-----");
		
		int i= 0, o= 0;
		try {
			Connection con= (Connection) DB_Conn.conn(Values.DB_Name);
			Statement st= (Statement) con.createStatement();
			
			i= st.executeUpdate(s);
			
			Statement nst= (Statement) con.createStatement();
			
			o= nst.executeUpdate(sql);
			
			Statement stn= (Statement) con.createStatement();
			stn.executeUpdate(sl);
			
			if ((i != 0) && (o != 0)) {
				if (AddBlockClass.addBlockToBlockChain(tr)) {
					response.sendRedirect("./distHome.jsp?msg=succ");
				} else {
					response.sendRedirect("./distHome.jsp?msg=fail");
				}
			}			
		} catch (Exception e0) {
			e0.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
