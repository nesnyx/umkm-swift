import Fluent

struct CreateTransaction : AsyncMigration {
    func prepare(on database: any Database) async throws{
        try await database.schema("transactions")
            .id()
            .field("amount", .int, .required)
            .field("customerId", .uuid, .required)
            .field("productId", .uuid, .required)
            .create()
    }

    func revert(on database: any Database) async throws{
        try await database.schema("transactions").delete()
    }
}