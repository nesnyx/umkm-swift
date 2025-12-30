import Fluent

struct CreateMerchant: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("merchants")
            .id().field("name", .string, .required).field("merchantId", .string, .required).create()

    }

    func revert(on database: any Database) async throws {
        try await database.schema("merchants").delete()
    }
}
