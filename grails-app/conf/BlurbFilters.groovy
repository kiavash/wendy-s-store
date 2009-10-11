/**
 * Created by IntelliJ IDEA.
 * User: mstine
 * Date: Oct 11, 2009
 * Time: 1:29:41 PM
 * To change this template use File | Settings | File Templates.
 */

public class BlurbFilters {

  def authenticateService

  def filters = {

    authorizedCheck(controller: 'blurb') {

      before = {
        if (authenticateService.ifAllGranted('ROLE_ADMIN')) {
          return true
        } else {
          redirect controller: 'login'
          return false
        }
      }

    }

  }

  

}