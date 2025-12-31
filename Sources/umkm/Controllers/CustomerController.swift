import Fluent
import Vapor

struct CustomerController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let customers: any RoutesBuilder = routes.grouped("customers")
        customers.get(use: self.index)
        customers.post(use: self.create)
    }

    @Sendable
    func index(req: Request) async throws -> [CustomerDTO] {
        try await Customer.query(on: req.db).all().map { $0.toDTO() }
    }
    @Sendable
    func create(req: Request) async throws -> CustomerDTO {
        let customer: Customer = try req.content.decode(CustomerDTO.self).toModel()
        try await customer.save(on: req.db)
        return customer.toDTO()
    }

    @Sendable
    func update(req: Request) async throws -> CustomerDTO {
        guard
            let customer: Customer = try await Customer.find(
                req.parameters.get("customerID"), on: req.db)
        else {
            throw Abort(.notFound)
        }
        let updatedCustomer: CustomerDTO = try req.content.decode(CustomerDTO.self)
        customer.name = updatedCustomer.name
        customer.email = updatedCustomer.email
        customer.phone = updatedCustomer.phone
        try await customer.save(on: req.db)
        return customer.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard
            let customer: Customer = try await Customer.find(
                req.parameters.get("customerID"), on: req.db)
        else {
            throw Abort(.notFound)

        }
        try await customer.delete(on: req.db)
        return .noContent
    }
}
