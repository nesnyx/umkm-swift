import Fluent

struct CreateProduct: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("products")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("price", .int, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("products").delete()
    }
}
