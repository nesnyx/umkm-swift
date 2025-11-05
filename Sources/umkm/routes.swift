import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    let api = app.grouped("api")

    // GET
    api.get("hello", ":name") { req async throws -> String in
    let name = req.parameters.get("name")!
    return "Hello, \(name)!"            
    }


    try app.register(collection: TodoController())
}
