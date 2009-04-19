<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Shopping Cart</title>
  <meta name="layout" content="main"/>
</head>
<body>
<div class="prepend-2 span-16 append-2 last">
  <h2>Shopping Cart</h2>
  <g:if test="${flash.message}">
    <div class="errors">${flash.message}</div>
  </g:if>
  <g:if test="${numberOfItems == 0}">
    Your shopping cart is currently empty!
  </g:if>
  <g:else>
    <table>
      <thead>
      <tr>
        <th class="cartItemColumn">Item</th>
        <th>Quantity</th>
        <th class="rightJustify">Price</th>
        <th>&nbsp;</th>
      </tr>
      </thead>
      <tbody>
      <sc:each>
        <g:set value="${com.metasieve.shoppingcart.Shoppable.findByShoppingItem(it['item'])}" var="orderItem"/>
        <g:set value="${it['qty']}" var="quantity"/>
        <tr>
          <td class="cartItemColumn">
            <strong>${orderItem.product.name}</strong><br/>${orderItem.price.description} (<g:formatNumber format="\$0.00" number="${orderItem.price.price}"/>)<br/><br/>

            <strong>Options:</strong><br/><br/>
            <ul style="list-style-type: none">
              <g:each in="${orderItem.customizationItems}" var="customizationItem">
                <li style="padding-bottom: 5px"><g:renderCartCustomizationItem customizationItem="${customizationItem}"/></li>
              </g:each>
            </ul>
          </td>
          <td class="cartOtherColumn">
            <g:form controller="shopping" action="updateQuantity">
              <g:hiddenField name="id" value="${item.id}"/>
              <g:textField name="quantity" value="${quantity}" size="3"/>
              <g:submitButton name="updateQuantityButton" value="Update"/>
            </g:form>
          </td>
          <td class="cartOtherColumn rightJustify">
            <g:formatNumber format="\$0.00" number="${orderItem.totalPrice * quantity}"/>
          </td>
          <td class="cartOtherColumn rightJustify">
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
    <g:form controller="shopping" action="prepareOrder">
      <p><g:submitButton value="Checkout" name="checkoutButton"/></p>
    </g:form>
  </g:else>
</div>
</body>
</html>