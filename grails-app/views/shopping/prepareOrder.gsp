<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Order Summary</title>
  <meta name="layout" content="main"/>
  <g:javascript library="radiogroup"/>
  <g:javascript>
    document.observe('dom:loaded', function() {
      $('shippingAddress').disable();

      $('shippingAddress').observe('change', function() {
        if ($F('shippingAddress') != '') {
          new Ajax.Updater('shippingAddressView','<g:createLink action="showShippingAddress"/>', {
            parameters: { id: $F('shippingAddress')},
            onComplete: function(transport) {
                if (!$('shippingAddressView').visible()) {
                  $('shippingAddressView').blindDown();
                }
            }
          });          
        } else {
          $('shippingAddressView').blindUp();
        }
      });

      $('prepareOrderForm').select('input[type="radio"]').each(function(element) {
        element.observe('change', function() {

          var deliveryMethod = $RF('prepareOrderForm', 'deliveryMethod');
          if (deliveryMethod == 1) {
            $('shippingAddress').disable();
            $('shippingAddress').selectedIndex = 0;
            $('shippingAddressView').blindUp();  
          } else {
            $('shippingAddress').enable();
          }

        });
      });
    });
  </g:javascript>
</head>
<body>
<div class="prepend-2 span-16 append-2">
  <h2>Order Summary</h2>
  <g:if test="${flash.message}">
    <div class="errors">${flash.message}</div>
  </g:if>

  <table>
    <thead>
    <tr>
      <th>Item</th>
      <th>Quantity</th>
      <th style="text-align: right">Price</th>
    </tr>
    </thead>
    <tbody>
    <sc:each>
      <g:set value="${com.metasieve.shoppingcart.Shoppable.findByShoppingItem(it['item'])}" var="orderItem"/>
      <g:set value="${it['qty']}" var="quantity"/>
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
          ${quantity}
        </td>
        <td style="text-align: right; vertical-align: top; padding-top: 10px">
          <g:formatNumber format="\$0.00" number="${orderItem.totalPrice * quantity}"/>
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
  <g:form name="prepareOrderForm" controller="shopping" action="checkout">
    <fieldset>

      <p><label for="deliveryMethod">Delivery Method</label><br/>
        <g:radioGroup name="deliveryMethod" labels="['Local Pickup','Ship']" values="[1,2]" value="1">
          ${it.radio} ${it.label}<br/>
        </g:radioGroup></p>

      <p><label for="shippingAddress">Shipping Address</label><br/>
        <g:select name="shippingAddress" from="${person.shippingAddresses}" optionKey="id" optionValue="name" noSelection="['':'Select a value...']"/> (<g:link controller="register" action="addShippingAddress" params="${[userId:person.id]}">Add Shipping Address</g:link>)</p>

      <div id="shippingAddressView" style="display:none"></div>

      <p><g:submitButton value="Checkout" name="checkoutButton"/></p>
    </fieldset>
  </g:form>
</div>
</body>
</html>