<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Order Management</title>
  <meta name="layout" content="main"/>
  <g:javascript>
    function shipOrder(orderId) {
      new Ajax.Request('/orders/shipOrder/' + orderId);
    }
  </g:javascript>
</head>
<body>
<div class="prepend-1 span-18 append-1">
  <h2>Order Management</h2>

  <p>
    <g:link action="list">[Show All Orders]</g:link> <g:link action="listUnshippedOrders">[Show Pending Orders]</g:link> <g:link action="listShippedOrders">[Show Shipped Orders]</g:link>
  </p>

  <table>
    <thead>
    <tr>
      <g:sortableColumn property="id" title="Id"/>
      <g:sortableColumn property="dateCreated" title="Date"/>
      <th>Txn ID</th>
      <th>Payment Status</th>
      <th>Customer</th>
      <th>Delivery Method</th>
      <th>Total</th>
      <th>Shipped?</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${orders}" var="order">
      <tr>
        <td><g:link action="show" id="${order.id}">${fieldValue(bean: order, field: 'id')}</g:link></td>
        <td><g:formatDate format="MM/dd/yyyy h:mm a" date="${order.dateCreated}"/></td>
        <td>${order?.payment?.transactionId}</td>
        <td>${order?.payment?.status}</td>
        <td>${order.user.lastName}, ${order.user.firstName}</td>
        <td>${order.deliveryMethod}</td>
        <td>${order.totalCharge}</td>
        <td><g:checkBox name="shipped" value="${order.shipped}" onClick="${remoteFunction(action:'shipOrder', id:order.id)}"/></td>
      </tr>
    </g:each>
    </tbody>
  </table>
</div>
</body>
</html>