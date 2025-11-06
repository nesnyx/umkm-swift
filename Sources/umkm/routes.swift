import Fluent
import Vapor

func routes(_ app: Application) throws {

    let api: any RoutesBuilder = app.grouped("api")
    api.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    api.get("hello") { req async -> String in
        "Hello, world!"
    }

    api.get("hello", ":name") { req async throws -> String in
        let name = req.parameters.get("name")!
        return "Hello, \(name)!"
    }
    try api.register(collection: ProductController())
}
