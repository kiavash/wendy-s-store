<%@ page import="com.mattstine.wendysstore.controllers.CheckoutCommand" %>
<html>
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8">
  <title>Order #${order.id}</title>
  <meta name="layout" content="main"/>
</head>
<body id="body">
<div class="prepend-2 span-16 append-2">
  <h2>Order #${order.id}</h2>
  <g:if test="${flash.message}">
    <div class="errors">${flash.message}</div>
  </g:if>
  <h3>Order Information:</h3>

  <table>
    <tbody>
      <tr>
        <td>Date:</td>
        <td><g:formatDate format="MM/dd/yyyy h:mm a" date="${order.dateCreated}"/></td>
      </tr>
      <tr class="even">
        <td>Txn ID:</td>
        <td>${order?.payment?.transactionId}</td>
      </tr>
      <tr>
        <td>Payment Status:</td>
        <td>${order?.payment?.status}</td>
      </tr>
      <tr class="even">
        <td>Customer:</td>
        <td>${order.user.lastName}, ${order.user.firstName}</td>
      </tr>
      <tr>
        <td>Customer Email:</td>
        <td><a href="mailto:${order.user.email}">${order.user.email}</a></td>
      </tr>
      <tr class="even">
        <td>Customer Phone:</td>
        <td>(${order.user.areaCode}) ${order.user.phonePrefix}-${order.user.phoneSuffix}</td>
      </tr>
    <tr>
        <td>Delivery Method:</td>
        <td>${order.deliveryMethod}</a></td>
      </tr>
    </tbody>
  </table>

  <g:if test="${order.deliveryMethod == CheckoutCommand.SHIP}">
  <h3>Shipping Address:</h3>

  <g:render template="/shippingAddress" model="[address:order.shippingAddress]"/>
  </g:if>  

  <h3>Order Details:</h3>
  <table>
    <thead>
    <tr>
      <th>Item</th>
      <th>Quantity</th>
      <th style="text-align: right">Price</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${order.orderItems}" var="orderItem">
      <tr>
        <td>
          <strong>${orderItem.product.name}</strong><br/>${orderItem.price.description} (<g:formatNumber format="\$0.00" number="${orderItem.price.price}"/>)<br/><br/>

          <strong>Options:</strong><br/><br/>
          <ul style="list-style-type: none">
            <g:each in="${orderItem.customizationItems}" var="customizationItem">
              <li style="padding-bottom: 5px"><g:renderCartCustomizationItem customizationItem="${customizationItem}"/></li>
            </g:each>
          </ul>
        </td>
        <td style="vertical-align:top">
          ${orderItem.quantity}
        </td>
        <td style="text-align: right; vertical-align: top; padding-top: 10px">
          <g:formatNumber format="\$0.00" number="${orderItem.totalPrice * orderItem.quantity}"/>
        </td>
      </tr>
    </g:each>
    <g:if test="${order.couponCode != null}">
      <tr>
        <td>&nbsp;</td>
        <td style="text-align: right"><strong>Subtotal:</strong></td>
        <td style="text-align: right"><g:formatNumber format="\$0.00" number="${order.subtotal}"/></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td style="text-align: right"><strong>Discount:</strong></td>
        <td style="text-align: right">-<g:formatNumber format="\$0.00" number="${order.getAmountOff(order.subtotal)}"/></td>
        <td>&nbsp;</td>
      </tr>
    </g:if>
    <tr>
      <td>&nbsp;</td>
      <td style="text-align: right"><strong>Order Total:</strong></td>
      <td style="text-align: right"><g:formatNumber format="\$0.00" number="${order.totalCharge}"/></td>
      <td>&nbsp;</td>
    </tr>
    </tbody>
  </table>
  </div>
</body>
</html>