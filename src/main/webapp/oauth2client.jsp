<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
//Retrieve the parameters from the URL
String code = request.getParameter("code");
String sessionState = request.getParameter("session_state");
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
            
            var request = {
                "url" : "http://localhost:8080/QuickFixBookings/AsgardeoProxyServlet.java", 
                "method" : "POST",
                "timeout" : 0,
                "headers" : {
                    "Content-Type" : "application/x-www-form-urlencoded"
                },
                "data" : {
                    "code" : code
                }
            };

            $.ajax(request).done(function(response) {
                // Handle the response data here
                console.log(response.access_token);
                var access_token = response.access_token;
                var id_token = response.id_token;
                localStorage.setItem('access_token', access_token);
                localStorage.setItem('id_token', id_token);
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