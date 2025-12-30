import Vapor 
import Fluent


struct TransactionController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let transactions: any RoutesBuilder = routes.grouped("transactions")
        transactions.get(use: self.index)
        transactions.post(use: self.create)
        transactions.delete(use: self.delete) 
    }

    @Sendable
    func index(req: Request) async throws -> [TransactionDTO] {
        try await Transaction.query(on: req.db).all().map { $0.toDTO() }
    }

    @Sendable
    func create(req: Request) async throws -> TransactionDTO {
        let transaction: Transaction = try req.content.decode(TransactionDTO.self).toModel()
        try await transaction.save(on: req.db)
        return transaction.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard
            let transaction: Transaction = try await Transaction.find(
                req.parameters.get("transactionID"), on: req.db)
        else {
            throw Abort(.notFound)
        }
        try await transaction.delete(on: req.db)
        return .noContent
    }
}