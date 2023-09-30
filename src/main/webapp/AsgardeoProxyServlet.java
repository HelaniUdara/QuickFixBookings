import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AsgardeoProxyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String apiUrl = "https://api.asgardeo.io/t/orghsx24/oauth2/token";
        String parameters = "code=" + request.getParameter("code") +
                            "&grant_type=authorization_code" +
                            "&client_id=JqXUOH30f3XZUgvmz5AIZH0N5OIa" +
                            "&client_secret=ZA7kuuaWIjkV8h8CGgBkM1Aij4sV8hkg7iQWwp6Pe6Ea" +
                            "&redirect_uri=http://localhost:8080/QuickFixBookings/oauth2client.jsp";

        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);

        try (OutputStream output = connection.getOutputStream()) {
            byte[] input = parameters.getBytes("utf-8");
            output.write(input, 0, input.length);
        }

        try (InputStream responseStream = connection.getInputStream()) {
            byte[] responseBytes = responseStream.readAllBytes();
            response.getOutputStream().write(responseBytes);
        }
    }
}
