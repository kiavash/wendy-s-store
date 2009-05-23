<%@ page import="com.mattstine.wendysstore.domain.Product" %>
<html>
<head>
  <title>A Whimsical Collection of Personalized Stationery and Invitations</title>
  <meta name="layout" content="main"/>
</head>
<body>
<div class="prepend-1 span-18 append-1">
  <h2>Welcome<g:isLoggedIn>, <g:loggedInUserInfo field="firstName"/></g:isLoggedIn>!</h2>
  <p>Welcome to Duck Duck Goose Designs, a whimsical collection of personalized stationery and invitiations! Here you will find a whimsical assortment of stationery products that are perfect for any age, gender or occasion. Finally, high quality stationery that is super affordable! Whether you're shopping for a gift or even for yourself, you'll be certain to find that special something to make you smile. Be sure to keep checking back as new designs are always being added!</p>
  <p>Thank you for visiting and Happy Shopping!</p>

  <div class="prepend-2 span-16 append-2">
    <img src="${resource(dir: "images", file: "block.jpg")}" usemap="#map"/>
    <map name="map">
      <!-- #$-:Image map file created by GIMP Image Map plug-in -->
      <!-- #$-:GIMP Image Map plug-in by Maurits Rijk -->
      <!-- #$-:Please do not edit lines starting with "#$" -->
      <!-- #$VERSION:2.3 -->
      <!-- #$AUTHOR:mstine -->
      <area shape="circle" coords="473,185,77" href="http://duckduckgoosedesigns.blogspot.com/"/>
      <area shape="circle" coords="474,382,77" href="http://www.duckduckgoosedesigns.com/blogButton/index"/>
      <area shape="rect" coords="83,121,339,460" href="${createLink(controller:"shopping", action:"category", id:"7")}"/>
    </map>
  </div>


  <g:if test="${featuredProducts}">
    <h2>Featured Products:</h2>
    <g:render template="/productThumbs" model="${[products:featuredProducts]}"/>
  </g:if>
</div>

</body>
</html>