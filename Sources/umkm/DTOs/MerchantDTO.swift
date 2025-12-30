import Fluent
import Vapor
struct MerchantDTO: Content {
    var id : UUID?
    var name : String
    var merchantId : String

    func toModel() -> Merchant {
        let model : Merchant = Merchant()
        model.id = self.id
        model.name = self.name
        model.merchantId = self.merchantId
        return model
    }
}
