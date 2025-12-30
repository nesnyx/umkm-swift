import Fluent
import Vapor

struct TransactionDTO : Content {
    var id : UUID?
    var amount : Int
    var customerId : UUID
    var productId : UUID

    func toModel() -> Transaction {
        let model : Transaction = Transaction()
        model.id = self.id
        model.amount = self.amount
        model.customerId = self.customerId
        model.productId = self.productId
        return model
    }
}