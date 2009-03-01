security {

  // see DefaultSecurityConfig.groovy for all settable/overridable properties

  active = true

  loginUserDomainClass = "com.mattstine.wendysstore.domain.User"
  authorityDomainClass = "com.mattstine.wendysstore.domain.Role"

  useRequestMapDomainClass = false

  useControllerAnnotations = true
}
