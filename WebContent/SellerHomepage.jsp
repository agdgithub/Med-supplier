<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" href="css/Homepage.css">
</head>
<body>
<div class="main">
	<div class="navbar">
<!--		<a href="Homepage.jsp">HOME</a>
		<a href="Buy.jsp">BUY</a>
		<a href="Orders.jsp">ORDERS</a>-->
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
    <h1 class="welcome-heading">Welcome <span class="guid"><%= guid %></span></h1>

    <%
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select sname,sid,address,phno from seller where sid=?";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","Akshay@2002");
		ps=conn.prepareStatement(query);
		ps.setString(1,guid);
		rs=ps.executeQuery();
		if(rs.next())
		{
		%>
		<div class="filler2"></div>
			<div class="card">
  				<img src="images/vendor.png" class="Avatar" width=225 height=225>
  				<div class="container">
    				<h4><b><%=rs.getString("sname") %></b></h4>
   					<p><b>ID: </b><%=rs.getString("sid") %> </p>
   					<p><b>Address: </b><%=rs.getString("address") %></p>
   					<p><b>Phone: </b><%=rs.getString("phno") %></p>
  				</div>
			</div>
		<%
		}
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
</div>
</body>
</html>
