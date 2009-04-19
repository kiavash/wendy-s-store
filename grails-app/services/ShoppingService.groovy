import com.mattstine.wendysstore.domain.Product

class ShoppingService {

  boolean transactional = true

  def saveSortOrder(def productIds) {
    def productsToSort = Product.findAllByIdInList(productIds)

    def productMap = [:]
    def sortIndexList = []

    productsToSort.each {
      productMap[it.id] = it
      sortIndexList << it.sortIndex
    }

    sortIndexList.sort()
    sortIndexList = sortIndexList.reverse()

    productIds.each {
      productMap[it].sortIndex = sortIndexList.pop()
    }

    productsToSort.each {
      it.save()
    }
  }
}
