

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Current Products</title>
    </head>
    <body>
        
        <div class="body">
            <h1>Current Products:</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="datatable">
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Product ID" />

                            <g:sortableColumn property="name" title="Name" />

                   	        %{--<g:sortableColumn property="price" title="Price" />--}%
                        
                            <g:sortableColumn property="featured" title="Featured" />

                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productInstanceList}" status="i" var="productInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productInstance.id}">${fieldValue(bean:productInstance, field:'id')}</g:link></td>

                            <td>${fieldValue(bean:productInstance, field:'name')}</td>

                            %{--<td><g:formatNumber number="${productInstance.price}" format="\$0.00"/></td>--}%
                        
                            <td>${fieldValue(bean:productInstance, field:'featured')}</td>

                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${productInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
