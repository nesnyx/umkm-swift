import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

public func configure(_ app: Application) async throws {

    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateTodo())

    app.views.use(.leaf)
    Task {
        try await app.autoMigrate()
    }
    // register routes
    try routes(app)
}
