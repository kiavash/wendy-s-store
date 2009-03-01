import com.mattstine.wendysstore.domain.Product
import com.mattstine.wendysstore.domain.ProductCategory
import com.mattstine.wendysstore.domain.Role
import com.mattstine.wendysstore.domain.User

class BootStrap {

     def authenticateService

     def init = { servletContext ->

       switch(grails.util.GrailsUtil.environment) {

         case "development":
           //inits for development
//           def c1 = new com.mattstine.wendysstore.domain.ProductCategory(name:"Birth Announcements").save()
//           def c2 = new com.mattstine.wendysstore.domain.ProductCategory(name:"Birthday Invitations").save()
//           def c3 = new com.mattstine.wendysstore.domain.ProductCategory(name:"Note Cards").save()

           def c4 = new ProductCategory(name:"Invitations")

           def c5 = new ProductCategory(name:"Girls")
           def c6 = new ProductCategory(name:"Boys")

           c4.addToSubCategories(c5)
           c5.parentCategory = c4
           c4.addToSubCategories(c6)
           c6.parentCategory = c4

           c4.save()
           c5.save()
           c6.save()

           def p = new Product(name:"Polka Dot Birthday", price:1.75)
           p.description = """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nec dolor non eros auctor
 porttitor. Sed pulvinar vulputate dolor. Donec dapibus. In scelerisque pede sit amet quam lobortis ultrices. Phasellus
 rhoncus vestibulum tortor. Nullam vitae urna vitae libero ullamcorper accumsan. Phasellus pretium viverra lectus. Nulla
 quis nisl. Vivamus porta justo vel velit. Nulla at felis sit amet neque consectetur accumsan. Donec tortor lectus,
 laoreet et, faucibus sit amet, tincidunt ut, nisl. Fusce eget nisl. Mauris ornare diam ut magna. Ut diam felis,
 eleifend sed, convallis ac, rutrum at, justo."""
           p.category = c5
           p.save()

           p = new Product(name:"Sailboat Birthday", price:1.75)
           p.description = """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nec dolor non eros auctor
 porttitor. Sed pulvinar vulputate dolor. Donec dapibus. In scelerisque pede sit amet quam lobortis ultrices. Phasellus
 rhoncus vestibulum tortor. Nullam vitae urna vitae libero ullamcorper accumsan. Phasellus pretium viverra lectus. Nulla
 quis nisl. Vivamus porta justo vel velit. Nulla at felis sit amet neque consectetur accumsan. Donec tortor lectus,
 laoreet et, faucibus sit amet, tincidunt ut, nisl. Fusce eget nisl. Mauris ornare diam ut magna. Ut diam felis,
 eleifend sed, convallis ac, rutrum at, justo."""
           p.category = c5
           p.save()

           p = new Product(name:"Whimsical Girl Birthday", price:1.75)
           p.description = """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nec dolor non eros auctor
 porttitor. Sed pulvinar vulputate dolor. Donec dapibus. In scelerisque pede sit amet quam lobortis ultrices. Phasellus
 rhoncus vestibulum tortor. Nullam vitae urna vitae libero ullamcorper accumsan. Phasellus pretium viverra lectus. Nulla
 quis nisl. Vivamus porta justo vel velit. Nulla at felis sit amet neque consectetur accumsan. Donec tortor lectus,
 laoreet et, faucibus sit amet, tincidunt ut, nisl. Fusce eget nisl. Mauris ornare diam ut magna. Ut diam felis,
 eleifend sed, convallis ac, rutrum at, justo."""
           p.category = c6
           p.save()

           def roleAdmin = new Role(authority:"ROLE_ADMIN", description:"Administrator Role").save()

           def md5Pass = authenticateService.encodePassword("password")
           new User(username:"mstine",
                    userRealName:"Matt Stine",
                    passwd:md5Pass,
                    enabled:true,
                    email:"matt@mattstine.com",
                    description:"Me").addToAuthorities(roleAdmin).save()


         break

         case "production":
           //inits for production
         break

       }

     }
     def destroy = {
     }
} 