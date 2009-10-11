<%@ page import="com.mattstine.wendysstore.controllers.CheckoutCommand; com.mattstine.wendysstore.domain.CouponCodeType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Order Summary</title>
  <meta name="layout" content="main"/>
  <g:javascript library="radiogroup"/>
  <g:javascript>
    function updateShippingAddressView() {
      new Ajax.Updater('shippingAddressView','<g:createLink action="showShippingAddress"/>', {
            parameters: { id: $F('shippingAddress')},
            onComplete: function(transport) {
                if (!$('shippingAddressView').visible()) {
                  $('shippingAddressView').blindDown();
                }
            }
      });
    }

    document.observe('dom:loaded', function() {
      $('shippingAddress').disable();

      $('shippingAddress').observe('change', function() {
        if ($F('shippingAddress') != '') {
          updateShippingAddressView();
        } else {
          $('shippingAddressView').blindUp();
        }
      });

      $('prepareOrderForm').select('input[type="radio"]').each(function(element) {
        element.observe('change', function() {

          var deliveryMethod = $RF('prepareOrderForm', 'deliveryMethod');
          if (deliveryMethod == '${CheckoutCommand.LOCAL_PICKUP}') {
            $('shippingAddress').disable();
            $('shippingAddressView').blindUp();
          } else {
            if ($('shippingAddress').selectedIndex != 0) {
              updateShippingAddressView();
            }
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
  <g:if test="${order.couponCode == null}">
    <g:form name="applyCouponCodeForm" action="processOrder">
      <fieldset>
        <p><label for="couponCode">Apply Coupon Code</label><br/>
          <g:textField name="couponCode"/></p>

        <p><g:submitButton name="applyCouponCode" value="Apply"/></p>
      </fieldset>
    </g:form>
  </g:if>
  <g:else>
    <fieldset>
      Coupon Code Applied: <strong>${order.couponCode.code}</strong><br/>
      <g:if test="${order.couponCode.type == CouponCodeType.DOLLARS_OFF}">
        <g:formatNumber format="\$0.00" number="${order.couponCode.amount}"/> off your order.
      </g:if>
      <g:else>
        <g:formatNumber format="0%" number="${order.couponCode.amount / 100}"/> off your order.
      </g:else>
    </fieldset>
  </g:else>

  <g:form name="prepareOrderForm" controller="shopping" action="processOrder">
    <fieldset>
    <p><g:blurb name="deliveryInstructions"/></p>

      <p><label for="deliveryMethod">Delivery Method</label><br/>
    <g:radioGroup name="deliveryMethod" labels="[CheckoutCommand.LOCAL_PICKUP,CheckoutCommand.SHIP]" values="[CheckoutCommand.LOCAL_PICKUP,CheckoutCommand.SHIP]" value="${CheckoutCommand.LOCAL_PICKUP}">
      ${it.radio} ${it.label}<br/>
    </g:radioGroup></p>

    <p><label for="shippingAddress">Shipping Address</label><br/>
      <select id="shippingAddress" name="shippingAddress">
        <option value="">Select a value...</option>
        <g:each in="${person.shippingAddresses}" var="shippingAddress">
          <option value="${shippingAddress.id}" <g:if test="${shippingAddress.defaultAddress}">selected</g:if>>${shippingAddress.name}</option>
        </g:each>
      </select> (<g:link action="processOrder" event="addShippingAddress" params="${[userId:person.id]}">Add Shipping Address</g:link>)</p>

    <div id="shippingAddressView" style="display:none"></div>

    <g:hasErrors bean="${cmd}">
      <div class="error">
        <g:renderErrors bean="${cmd}" as="list"/>
      </div>
    </g:hasErrors>  

    <p><g:submitButton value="Checkout" name="checkout"/><br/><!-- PayPal Logo --><table border="0" cellpadding="10" cellspacing="0" align="center"><tr><td align="center"></td></tr>
    <tr><td align="center"><a href="#" onclick="javascript:window.open('https://www.sandbox.paypal.com/us/cgi-bin/webscr?cmd=xpt/Marketing/popup/OLCWhatIsPayPal-outside', 'olcwhatispaypal', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=400, height=350');"><img src="https://www.sandbox.paypal.com/en_US/i/bnr/horizontal_solution_PPeCheck.gif" border="0" alt="Solution Graphics"></a></td></tr></table><!-- PayPal Logo --></p>
    </fieldset>
  </g:form>
</div>
</body>
</html>