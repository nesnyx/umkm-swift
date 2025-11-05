import Fluent
import struct Foundation.UUID

final class Product : Model. @unchecked Sendable {
    static let schema = "products"
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "description")
    var description: String

    
    @Field(key: "price")
    var price: Int

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
    func toDTO() -> TodoDTO {
        .init(
            id: self.id,
            title: self.$title.value
        )
    }
}