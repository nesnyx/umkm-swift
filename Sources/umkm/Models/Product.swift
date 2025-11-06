import Fluent

import struct Foundation.UUID

final class Product: Model, @unchecked Sendable {
    static let schema: String = "products"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "description")
    var description: String

    @Field(key: "price")
    var price: Int
    init() {}
    init(id: UUID? = nil, name: String, description: String, price: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
    }

    func toDTO() -> ProductDTO {
        .init(
            id: self.id,
            name: self.name,
            price: self.price,
            description: self.description,
        )
    }
}
