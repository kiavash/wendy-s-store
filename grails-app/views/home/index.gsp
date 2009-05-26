<%@ page import="com.mattstine.wendysstore.domain.Product" %>
<html>
<head>
  <title>A Whimsical Collection of Personalized Stationery and Invitations</title>
  <meta name="layout" content="main"/>
</head>
<body>
<div class="prepend-1 span-18 append-1">
  <h2>Welcome<g:isLoggedIn>, <g:loggedInUserInfo field="firstName"/></g:isLoggedIn>!</h2>
  <p>Welcome to Duck Duck Goose Designs!  We’re so excited you’re here!  Duck Duck Goose Designs offers a fun, whimsical collection of personalized stationery, invitations, and gifts.  Everything you see on our site is my own original design,  created with a wide variety of tools ranging from colored pencils to graphics programs.  We hope you love what you see!
Almost every design on our site can be adapted to fit almost any product.  So if you’re throwing a party and ordering one of our adorable invitations, let us know if you’d like coordinating stickers and thank you notes.   Love a tshirt design and want it on a round sticker?  Just tell me…I’ll be glad to help.  All products are customizable too (choose your font, font color, message etc.).  The possibilities are endless!
We have so many new designs coming soon as well as some new products.  So bookmark us on your favorites and check back often.  You’ll be glad you did!</p>


  <div class="prepend-2 span-16 append-2">
    <p:image src="block.jpg" usemap="#map"/>
    <map name="map">
      <!-- #$-:Image map file created by GIMP Image Map plug-in -->
      <!-- #$-:GIMP Image Map plug-in by Maurits Rijk -->
      <!-- #$-:Please do not edit lines starting with "#$" -->
      <!-- #$VERSION:2.3 -->
      <!-- #$AUTHOR:mstine  -->
      <area shape="circle" coords="473,185,77" href="http://duckduckgoosedesigns.blogspot.com/"/>
      <area shape="circle" coords="474,382,77" href="${createLink(controller:"page", action:"show", id:"3")}"/>
      <area shape="rect" coords="81,117,337,456" href="${createLink(controller:"shopping", action:"category", id:"7")}"/>
    </map>
  </div>


  <g:if test="${featuredProducts}">
    <h2>Featured Products:</h2>
    <g:render template="/productThumbs" model="${[products:featuredProducts]}"/>
  </g:if>
</div>

</body>
</html>