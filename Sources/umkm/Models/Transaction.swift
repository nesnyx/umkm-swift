import Fluent

import struct Foundation.UUID


final class Transaction: Model, @unchecked Sendable {
    static let schema: String = "transactions"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "amount")
    var amount: Int

    @Field(key: "customerId")
    var customerId: UUID

    @Field(key: "productId")
    var productId: UUID

    init() {}

    init(id: UUID? = nil, amount: Int, customerId: UUID, productId: UUID) {
        self.id = id
        self.amount = amount
        self.customerId = customerId
        self.productId = productId
    }

    func toDTO() -> TransactionDTO {
        .init(
            id: self.id,
            amount: self.amount,
            customerId: self.customerId,
            productId: self.productId
        )
    }
}