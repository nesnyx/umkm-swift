import Fluent
import Vapor

struct CustomerDTO: Content {
    var id: UUID?
    var name: String
    var email: String?
    var phone: String?

    func toModel() -> Customer {
        let model: Customer = Customer()
        model.id = self.id
        model.name = self.name
        model.email = self.email
        model.phone = self.phone
        return model
    }
}
