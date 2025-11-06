import Fluent
import Vapor


struct ProductDTO : Content {
    var id : UUID?
    var name : String
    var price : Int
    var description : String
    
    func toModel() -> Product {
        let model : Product = Product()
        model.id = self.id
        model.name = self.name
        model.price = self.price
        model.description = self.description
        return model
    }
}