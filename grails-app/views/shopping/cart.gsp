<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Shopping Cart</title>
  <meta name="layout" content="main"/>
</head>
<body>
<div class="span-20 last">
  <h2>Shopping Cart</h2>
  <g:if test="${numberOfItems == 0}">
    Your shopping cart is currently empty!
  </g:if>
  <g:else>
  <table>
    <thead>
    <tr>
      <th>Item</th>
      <th>Quantity</th>
      <th style="text-align: right">Price</th>
      <th>&nbsp;</th>
    </tr>
    </thead>
    <tbody>
    <sc:each>
      <g:set value="${com.metasieve.shoppingcart.Shoppable.findByShoppingItem(it['item'])}" var="orderItem"/>
      <g:set value="${it['qty']}" var="quantity"/>
      <tr>
        <td>
          ${orderItem.product.name}<br/>${orderItem.price.description}
        </td>
        <td>
          <g:form controller="shopping" action="updateQuantity">
            <g:hiddenField name="id" value="${item.id}"/>
            <g:textField name="quantity" value="${quantity}"/>
            <g:submitButton name="updateQuantityButton" value="Update"/>
          </g:form>
        </td>
        <td style="text-align: right">
          <g:formatNumber format="\$0.00" number="${orderItem.price.price * quantity}"/>
        </td>
        <td>
          <g:form controller="shopping" action="deleteItemFromCart">
            <g:hiddenField name="id" value="${item.id}"/>
            <g:submitButton name="deleteItemFromCartButton" value="Delete"/>
          </g:form>
        </td>
      </tr>
    </sc:each>
    <tr>
      <td>&nbsp;</td>
      <td style="text-align: right"><strong>Cart Total:</strong></td>
      <td style="text-align: right"><g:formatNumber format="\$0.00" number="${totalCharge}"/></td>
      <td>&nbsp;</td>
    </tr>
    </tbody>
  </table>
  <g:form controller="shopping" action="checkout">
    <g:submitButton value="Checkout" name="checkoutButton"/>
  </g:form>
  </g:else>
</div>
</body>
</html>