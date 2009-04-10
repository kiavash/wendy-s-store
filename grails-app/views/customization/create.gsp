
<%@ page import="com.mattstine.wendysstore.domain.Customization" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create Customization</title>
        <g:javascript library="prototype"/>
        <g:javascript>
          document.observe('dom:loaded', function() {

          if ($('chargeable').checked) {
              $('price').enable();
          } else {
              $('price').disable();
          }

          $('chargeable').observe('change', function() {
             if ($('chargeable').checked) {
                 $('price').enable();
             } else {
                 $('price').disable();
                 $('price').clear();
             }
          });

          if ($F('type') == 'CHECKBOX') {
              $('required').disable();
          }

          $('type').observe('change', function() {
             if ($F('type') == 'CHECKBOX') {
                 $('required').disable();
                 $('required').checked = false;
             } else {
                 $('required').enable();
             }
          });

          });
        </g:javascript>
    </head>
    <body>
        <div class="body">
            <h1>Create Customization</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${customizationInstance}">
            <div class="errors">
                <g:renderErrors bean="${customizationInstance}" as="list" />
            </div>
            </g:hasErrors>
          <g:form action="save" method="post">
            <div class="dialog">
              <table>
                <tbody>

                <tr class="prop">
                  <td valign="top" class="name">
                    <label for="label">Label:</label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean: customizationInstance, field: 'label', 'errors')}">
                    <input type="text" id="label" name="label" value="${fieldValue(bean: customizationInstance, field: 'label')}"/>
                  </td>
                </tr>

                <tr class="prop">
                  <td valign="top" class="name">
                    <label for="type">Type:</label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean: customizationInstance, field: 'type', 'errors')}">
                    <g:select from="${com.mattstine.wendysstore.domain.CustomizationType?.values()}" value="${customizationInstance?.type}" name="type" optionValue="labelText"/>
                  </td>
                </tr>

                <tr class="prop">
                  <td valign="top" class="name">
                    <label for="required">Required:</label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean: customizationInstance, field: 'required', 'errors')}">
                    <g:checkBox id="required" name="required" value="${customizationInstance?.required}"></g:checkBox>
                  </td>
                </tr>

                <tr class="prop">
                  <td valign="top" class="name">
                    <label for="chargeable">Chargeable:</label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean: customizationInstance, field: 'chargeable', 'errors')}">
                    <g:checkBox id="chargeable" name="chargeable" value="${customizationInstance?.chargeable}"></g:checkBox>
                  </td>
                </tr>

                <tr class="prop">
                  <td valign="top" class="name">
                    <label for="price">Price:</label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean: customizationInstance, field: 'price', 'errors')}">
                    <input type="text" id="price" name="price" value="${fieldValue(bean: customizationInstance, field: 'price')}"/>
                  </td>
                </tr>

                </tbody>
              </table>
            </div>
            <div class="buttons">
              <span class="button"><input class="save" type="submit" value="Create"/></span>
            </div>
          </g:form>
        </div>
    </body>
</html>
