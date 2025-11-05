import Fluent
import Vapor


struct PorudctController : RouteCollection {
    func boot(routes : any RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: self.index)
    }


    @Sendable
    func index(req:Request) async throws -> [ProductDTO] {
        try await Product.query(on : req.db).all().map{$0.toDTO()}
    }
}