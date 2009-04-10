<%@ page import="com.mattstine.wendysstore.domain.CustomizationType; com.mattstine.wendysstore.domain.Customization" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Show Customization</title>
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

    });
  </g:javascript>
</head>
<body>
<div class="body">
  <h1>Show Customization</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name">Customization ID:</td>

        <td valign="top" class="value">${fieldValue(bean: customizationInstance, field: 'id')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Label:</td>

        <td valign="top" class="value">${fieldValue(bean: customizationInstance, field: 'label')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Type:</td>

        <td valign="top" class="value">${customizationInstance?.type?.labelText}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Required:</td>

        <td valign="top" class="value"><g:if test="${customizationInstance.required}">Yes</g:if><g:else>No</g:else></td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Chargeable:</td>

        <td valign="top" class="value"><g:if test="${customizationInstance.chargeable}">Yes</g:if><g:else>No</g:else></td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Price:</td>

        <td valign="top" class="value">${fieldValue(bean: customizationInstance, field: 'price')}</td>

      </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <g:form>
      <input type="hidden" name="id" value="${customizationInstance?.id}"/>
      <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
      <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
    </g:form>
  </div>
  <g:if test="${customizationInstance.type == CustomizationType.CHOICESET}">
    <g:render template="choices" model="${[customizationInstance:customizationInstance, customizationChoiceInstance:customizationChoiceInstance]}"/>
  </g:if>
</div>
</body>
</html>
