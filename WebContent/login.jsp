<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>e_Lib Manager</title>

<script>
	function validateForm() {
		let x = document.forms["form1"]["username"].value;
		let y = document.forms["form1"]["password"].value;
		if (x == "" || y == "") {
			alert("UserName and Password must be filled out");
			return false;
		}
	}
</script>

</head>


<body>
	<%-- include file="userHome.jsp" --%>
	<%
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		
		String uname = request.getParameter("username");
		String pwd = request.getParameter("password");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "root");
			PreparedStatement stmt = con.prepareStatement("select * from user where user_name=? and password=? and status=1");

			stmt.setString(1, uname);
			stmt.setString(2, pwd);
			ResultSet rst = stmt.executeQuery();

			if (rst.next()) {

		//out.println("Valid user,Loged in succesfully");
		//out.println("User name is: " + rst.getString("user_name"));
		//out.println("User type: " + rst.getInt("user_type"));

		session.setAttribute("um", uname);
		session.setAttribute("ut", rst.getInt("user_type"));
		
		response.sendRedirect("userHome.jsp");
		

			} else {
		out.println("Invalid Crententials. Try again");
			}

		} catch (Exception e) {
		out.println(e.toString());
		}

	} else

	{
	%>
	<form name="form1" action="login.jsp" method="post"
		onSubmit="return validateForm()">
		<div>
			<label>User Name : <input type="text" name="username"
				required />
		</div>
		<br>

		<div>
			<label>Password : <input type="password" name="password"
				required />
		</div>
		<br> <input type="submit" value="Login" /> <input type="reset"
			value="Cancel" />


	</form>

	<%
	}
	%>





</body>
</html>