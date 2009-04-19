
<%@ page import="com.mattstine.wendysstore.domain.Page" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Page List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Page</g:link></span>
        </div>
        <div class="body">
            <h1>Page List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="sidebarLinkTitle" title="Sidebar Link Title" />
                        
                   	        <g:sortableColumn property="pageTitle" title="Page Title" />
                        
                   	        <g:sortableColumn property="pageContent" title="Page Content" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pageInstanceList}" status="i" var="pageInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${pageInstance.id}">${fieldValue(bean:pageInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:pageInstance, field:'sidebarLinkTitle')}</td>
                        
                            <td>${fieldValue(bean:pageInstance, field:'pageTitle')}</td>
                        
                            <td>${fieldValue(bean:pageInstance, field:'pageContent')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${pageInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
