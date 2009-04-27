
<%@ page import="com.mattstine.wendysstore.domain.CouponCode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>CouponCode List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New CouponCode</g:link></span>
        </div>
        <div class="body">
            <h1>CouponCode List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="code" title="Code" />

                            <th>Type</th>
                        
                   	        <g:sortableColumn property="amount" title="Amount" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${couponCodeInstanceList}" status="i" var="couponCodeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${couponCodeInstance.id}">${fieldValue(bean:couponCodeInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:couponCodeInstance, field:'code')}</td>

                            <td>${fieldValue(bean:couponCodeInstance, field: 'type.labelText')}</td>
                        
                            <td>${fieldValue(bean:couponCodeInstance, field:'amount')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${couponCodeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
