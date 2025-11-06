import Fluent

struct CreateCustomer: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("customer").id().field("name", .string, .required).field(
            "email", .string
        ).field("phone", .string, .required).create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("customer").delete()
    }
}
