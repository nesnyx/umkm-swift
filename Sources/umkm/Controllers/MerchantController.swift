import Fluent
import Vapor

struct MerchantController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let merchants: any RoutesBuilder = routes.grouped("merchants")
        merchants.get(use: self.index)
        merchants.post(use: self.create)
        merchants.delete(use: self.delete)
        merchants.put(use: self.update)
    }

    @Sendable
    func index(req: Request) async throws -> [MerchantDTO] {
        try await Merchant.query(on: req.db).all().map { $0.toDTO() }
    }

    @Sendable
    func create(req: Request) async throws -> MerchantDTO {
        let merchant: Merchant = try req.content.decode(MerchantDTO.self).toModel()
        try await merchant.save(on: req.db)
        return merchant.toDTO()
    }
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard
            let merchant: Merchant = try await Merchant.find(
                req.parameters.get("merchantID"), on: req.db)
        else {
            throw Abort(.notFound)
        }
        try await merchant.delete(on: req.db)
        return .noContent
    }

    @Sendable
    func update(req : Request) async throws -> MerchantDTO{
        guard
        let merchant = try await Merchant.find(req.parameters.get("merchantID"), on: req.db)
        else {
            throw Abort(.notFound)
        }
        let updatedMerchant : MerchantDTO = try req.content.decode(MerchantDTO.self)
        merchant.name = updatedMerchant.name
        try await merchant.save(on: req.db)
        return merchant.toDTO()
    }
    

}
