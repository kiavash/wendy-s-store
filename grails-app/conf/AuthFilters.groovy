/**
 * Created by IntelliJ IDEA.
 * User: mstine
 * Date: Oct 11, 2009
 * Time: 1:29:41 PM
 * To change this template use File | Settings | File Templates.
 */

public class AuthFilters {

  def authenticateService

  def filters = {

    blurbCheck(controller: 'blurb') {

      before = {
        if (authenticateService.ifAllGranted('ROLE_ADMIN')) {
          return true
        } else {
          redirect controller: 'login'
          return false
        }
      }

    }

    settingsCheck(controller: 'setting') {
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