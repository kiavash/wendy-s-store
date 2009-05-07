<p>${address.user.firstName} ${address.user.lastName}<br/>
${address.addressLineOne}<br/>
<g:if test="${(address.addressLineTwo != null && '' != address.addressLineTwo)}">${address.addressLineTwo}<br/></g:if>
${address.city}, ${address.state.longName} ${address.zipCode}<br/>
(${address.areaCode}) ${address.phonePrefix}-${address.phoneSuffix}</p>