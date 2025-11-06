import Fluent
import Vapor

struct ProductController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let products: any RoutesBuilder = routes.grouped("products")
        products.get(use: self.index)
        products.post(use: self.create)
        products.delete(use: self.delete) 
    }

    @Sendable
    func index(req: Request) async throws -> [ProductDTO] {
        try await Product.query(on: req.db).all().map { $0.toDTO() }
    }

    @Sendable
    func create(req: Request) async throws -> ProductDTO {
        let product: Product = try req.content.decode(ProductDTO.self).toModel()
        try await product.save(on: req.db)
        return product.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard
            let product: Product = try await Product.find(
                req.parameters.get("productID"), on: req.db)
        else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .noContent
    }
}
