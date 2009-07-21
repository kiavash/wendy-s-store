<%--
  Created by IntelliJ IDEA.
  User: mstine
  Date: Jul 20, 2009
  Time: 9:59:57 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Message from Contact Us Form on DuckDuckGooseDesigns.com</title></head>
  <body>
    <p><strong>Name:</strong> ${message.name}</p>
    <p><strong>Email:</strong> ${message.email}</p>
    <p><strong>Message:</strong><br/><br/>
      <pre>
        ${message.message}
      </pre>
    </p>
  </body>
</html>