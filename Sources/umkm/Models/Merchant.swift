import Fluent

import struct Foundation.UUID

final class Merchant: Model, @unchecked Sendable {
    static let schema: String = "merchants"

    init() {}

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "merchantId")
    var merchantId: String

    init(id: UUID? = nil, name: String, merchantId: String) {
        self.id = id
        self.name = name
        self.merchantId = merchantId
    }

    func toDTO() -> MerchantDTO {
        .init(
            id: self.id,
            name: self.name,
            merchantId: self.merchantId)
    }
}
