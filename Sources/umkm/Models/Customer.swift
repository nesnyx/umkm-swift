import Fluent

import struct Foundation.UUID

final class Customer: Model, @unchecked Sendable {
    static let schema : String = "customers"
    init() {}
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String

    @OptionalField(key: "email")
    var email: String?
    @OptionalField(key: "phone")
    var phone: String?
    
    init(id : UUID? = nil , name : String, email : String?, phone : String?){
        self.id = id 
        self.name = name
        self.email = email
        self.phone = phone
    }

    func toDTO() -> CustomerDTO {
        .init(
            id: self.id,
            name: self.name,
            email: self.email,
            phone: self.phone
        )
    }

}
