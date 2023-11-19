<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.InputStream, java.io.IOException, java.util.Properties" %>
<%
//Retrieve the parameters from the URL
String code = request.getParameter("code");
String sessionState = request.getParameter("session_state");

// Initialize a Properties object
Properties properties = new Properties();

// Load the properties file
try {
    InputStream inputStream = application.getResourceAsStream("/WEB-INF/classes/application.properties");
    properties.load(inputStream);
} catch (IOException e) {
    e.printStackTrace();
}

String clientId = properties.getProperty("client_id");
//Set values in the session
session.setAttribute("client_id", clientId);
session.setAttribute("session_state", sessionState);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>QuickFixBookings</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<script type="text/javascript">
	
        function makeTokenRequest() {
            
            var code = encodeURIComponent('<%= code %>');
            var sessionState = encodeURIComponent('<%= sessionState %>');
            
            var url = '<%= properties.getProperty("tokenEndpoint") %>';
            var client_Id = '<%= properties.getProperty("client_id") %>';
           
            var client_secret = '<%= properties.getProperty("client_secret") %>';
           
            var redirect_uri =  '<%= properties.getProperty("baseurl") %>' + '/QuickFixBookings/oauth2client.jsp';
           
            var request = {
            	    "url": url,
            	    "method": "POST",
            	    "timeout": 0,
            	    "headers": {
            	        "Content-Type": "application/x-www-form-urlencoded"
            	    },
            	    "data": {
            	        "code": code,
            	        "grant_type": "authorization_code",
            	        "client_id": client_Id,
            	        "client_secret": client_secret,
            	        "redirect_uri": redirect_uri
            	    }
            	};
            
            /*
            var request = {
            	    "url": "https://api.asgardeo.io/t/orghsx24/oauth2/token",
            	    "method": "POST",
            	    "timeout": 0,
            	    "headers": {
            	        "Content-Type": "application/x-www-form-urlencoded"
            	    },
            	    "data": {
            	        "code": code,
            	        "grant_type": "authorization_code",
            	        "client_id": "JqXUOH30f3XZUgvmz5AIZH0N5OIa",
            	        "client_secret": "ZA7kuuaWIjkV8h8CGgBkM1Aij4sV8hkg7iQWwp6Pe6Ea",
            	        "redirect_uri": "http://localhost:8080/QuickFixBookings/oauth2client.jsp"
            	    }
            	};
*/
            $.ajax(request).done(function(response) {
                // Handle the response data here
                console.log(response.access_token);
                var access_token = response.access_token;
                var id_token = response.id_token;
                localStorage.setItem('access_token', access_token);
                localStorage.setItem('id_token', id_token);
             // Store tokens in session attributes
             	sessionStorage.setItem('access_token', access_token);
             	sessionStorage.setItem("id_token", id_token);
             
                window.location.href = "home.jsp";
            }).fail(function (jqXHR, textStatus, errorThrown) {
                console.error('Error:', textStatus, errorThrown);
                alert("Error: " + textStatus + "\nDetails: " + errorThrown);
                window.location.href = "index.jsp";
            });


        }

        makeTokenRequest();
        
    </script>



</body>
</html>