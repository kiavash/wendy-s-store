import com.mattstine.wendysstore.domain.Product
import com.mattstine.wendysstore.domain.ProductCategory

class ShoppingService {

  boolean transactional = true

  def saveProductSortOrder(def productIds) {
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

  def saveCategorySortOrder(def categoryIds) {
    def categoriesToSort = ProductCategory.findAllByIdInList(categoryIds)

    def categoryMap = [:]
    def sortIndexList = []

    categoriesToSort.each {
      categoryMap[it.id] = it
      sortIndexList << it.sortIndex
    }

    sortIndexList.sort()
    sortIndexList = sortIndexList.reverse()

    categoryIds.each {
      categoryMap[it].sortIndex = sortIndexList.pop()
    }

    categoriesToSort.each {
      it.save()
    }
  }
}
