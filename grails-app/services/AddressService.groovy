import com.mattstine.wendysstore.domain.Address

class AddressService {

  boolean transactional = true

  def saveAddressAsNewDefault(def user, def address) {
    resetDefaultOnAllAddresses(user)
    user.addToShippingAddresses(address)
    user.save()
  }

  def updateAddressAsNewDefault(def address) {
    def user = address.user
    resetDefaultOnAllAddresses(user)
    address.refresh()
    address.defaultAddress = true
    address.save()
  }

  def resetDefaultOnAllAddresses(def user) {
    Address.executeUpdate("update Address a set a.defaultAddress = false where a.user = ?",[user])
  }
}
