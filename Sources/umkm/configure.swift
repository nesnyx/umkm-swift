import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

public func configure(_ app: Application) async throws {
    app.http.server.configuration.port = 3000
    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)
    app.migrations.add(CreateCustomer())
    app.migrations.add(CreateProduct())
    app.views.use(.leaf)
    Task {
        try await app.autoMigrate()
    }
    // register routes
    try routes(app)
}
