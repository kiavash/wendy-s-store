<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>View Contact Us Messages</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
</head>
<body>
<div class="prepend-1 span-18 append-1">
  <h2>View Contact Us Messages</h2>

  <table>
    <thead>
      <tr>
        <g:sortableColumn property="dateCreated" title="Date Sent"/>
        <g:sortableColumn property="name" title="Name"/>
        <g:sortableColumn property="email" title="Email"/>
        <g:sortableColumn property="message" title="Message"/>
      </tr>
    </thead>
    <tbody>
      <g:each var="message" in="${messages}">
        <tr>
          <td><g:formatDate format="MM/dd/yyyy h:mm a" date="${message.dateCreated}"/></td>
          <td>${message.name}</td>
          <td>${message.email}</td>
          <td>${message.message}</td>
        </tr>
      </g:each>
    </tbody>
  </table>
</div>
</body>
</html>