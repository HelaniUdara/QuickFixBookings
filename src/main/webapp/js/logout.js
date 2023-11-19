function logout(apiUrl, clientId, postLogoutRedirectUri, state) {
	
  $.ajax({
    type: "POST",
    url: apiUrl,
    data: {
      client_id: clientId,
      post_logout_redirect_uri: postLogoutRedirectUri,
      state: state
    },
    success: function(data) {
      // Handle the success response
      console.log(data);

      // Redirect the user to the index.jsp page
      window.location.href = "http://localhost:8080/QuickFixBookings/index.jsp";
    },
    error: function(jqXHR, textStatus, errorThrown) {
      // Handle the error response
      console.error("Error:", textStatus, errorThrown);
    }
  });
}

/*
<script type="text/javascript">
  function generateRandomState() {
    // Generate a random UUID (example using a simple algorithm)
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = (Math.random() * 16) | 0,
        v = c == 'x' ? r : (r & 0x3) | 0x8;
      return v.toString(16);
    });
  }

  function performLogout() {
    var apiUrl = '<%= properties.getProperty("logoutEndpoint") %>';
    var clientId = '<%= properties.getProperty("client_id") %>';
    var postLogoutRedirectUri = '<%= post_logout_redirect_uri %>';
    var state = generateRandomState();

    
    $.ajax({
        type: "POST",
        url: apiUrl,
        data: {
          client_id: clientId,
          post_logout_redirect_uri: postLogoutRedirectUri,
          state: state
        },
        success: function(data) {
          // Handle the success response
          console.log(data);

          // Redirect the user to the index.jsp page
          window.location.href = "http://localhost:8080/QuickFixBookings/index.jsp";
        },
        error: function(jqXHR, textStatus, errorThrown) {
          // Handle the error response
          console.error("Error:", textStatus, errorThrown);
        }
      });
    // Call the logout function with the required parameters
   // logout(apiUrl, clientId, postLogoutRedirectUri, state);
  }
</script>
*/
