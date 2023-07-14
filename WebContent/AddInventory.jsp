<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" href="css/Buy.css">
<style>
.row {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.column {
  padding: 10px;
  box-sizing: border-box;
}
</style>
</head>
<body>
<div class="main">
	<div class="navbar">
		<a href="SellerHomepage.jsp">HOME</a>
		<a href="AddProduct.html">ADD</a>
		<a href="AddInventory.jsp">INVENTORY</a>
		<a href="SellerOrders.jsp">ORDERS</a>
		<div class="logout-btn">
			<a href="Logout.jsp">Logout</a>
		</div>
	</div>
    <div class="header"></div>
</div>

<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String guid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select p.pid,i.quantity,p.pname,p.manufacturer,p.mfg,p.exp,p.price from product p,inventory i where p.pid=i.pid and i.sid=?";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","Akshay@2002");
		ps=conn.prepareStatement(query);
		ps.setString(1,guid);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
		<div class="row">
		<%
		while(rs.next())
		{
		%>
			<div class="column">
 				<div class="card">
    				<form action="UpdateInventory.jsp" method="post">
    					<img src="images/pills.png" width=180 height=200>
  						<h1><%=rs.getString("pname") %></h1>
  						<p><b>ID: </b><%=rs.getString("pid") %></p>
						<p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
						<p><b>Mfg Date: </b><%=rs.getDate("mfg") %></p>
						<p><b>Exp Date: </b><%=rs.getDate("exp") %></p>
						<p><b>Stock: </b><%=rs.getInt("quantity") %></p>
						<p><b>Price: </b><%=rs.getInt("price") %></p>
						<p><input type="text" name="restock" placeholder="quantity" onkeypress="return event.charCode >= 48 && event.charCode <= 57" required></p>
						<input type="hidden" name="pid" value="<%=rs.getString("pid") %>" >
						<p></p>
  						<button>ReStock</button>
  					</form>
  				</div>
  			</div>
  		<%
  		}
		%>
		</div>
	<%
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
	    try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
	%>
</body>
</html>


