<%@ page import="com.mattstine.wendysstore.domain.Product" %>
<html>
    <head>
        <title>Personalized Stationery, Invitations, and Gifts</title>
		<meta name="layout" content="main" />
    </head>
    <body>
        <div class="span-20 last">
          <h2>Welcome!</h2>
          <p>Welcome to Duck Duck Goose Designs, a whimsical collection of personalized stationery and invitiations! Here you will find a whimsical assortment of stationery products that are perfect for any age, gender or occasion. Finally, high quality stationery that is super affordable! Whether you're shopping for a gift or even for yourself, you'll be certain to find that special something to make you smile. Be sure to keep checking back as new designs are always being added!</p>
          <p>Thank you for visiting and Happy Shopping!</p>

          <g:if test="${featuredProducts}">
          <h2>Featured Products:</h2>
          <g:render template="/productThumbs" model="${[products:featuredProducts]}"/>
            </g:if>
        </div>
    
    </body>
</html>