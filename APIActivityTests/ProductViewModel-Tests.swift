//
//  ProductViewModelTests.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 25/08/25.
//


import XCTest
@testable import APIActivity

@MainActor
final class ProductViewModelTests: XCTestCase {
    
    func test_loadProducts_success() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service)
        
        // When
        await viewModel.loadProducts()
        
        // Then
        XCTAssertNotNil(viewModel.product, "O produto deveria estar preenchido")
        XCTAssertFalse(viewModel.products.isEmpty, "A lista de produtos não deveria estar vazia")
        XCTAssertNil(viewModel.errorMessage, "Não deveria haver erro em caso de sucesso")
        XCTAssertTrue(viewModel.isLoaded, "Deveria marcar como carregado")
        XCTAssertFalse(viewModel.isLoading, "Não deveria estar mais carregando")
    }
    
    func test_loadProducts_failure() async throws {
        // Given
        let service = MockProductService(shouldFail: true)
        let viewModel = ProductViewModel(service: service)
        
        // When
        await viewModel.loadProducts()
        
        // Then
        XCTAssertNil(viewModel.product, "O produto deveria ser nil em caso de falha")
        XCTAssertTrue(viewModel.products.isEmpty, "A lista deveria estar vazia em caso de falha")
        XCTAssertNotNil(viewModel.errorMessage, "Deveria haver mensagem de erro em caso de falha")
        XCTAssertTrue(viewModel.isLoaded, "Mesmo em erro, deveria marcar como carregado")
        XCTAssertFalse(viewModel.isLoading, "Não deveria estar carregando")
    }
    
    func test_initialState() {
        let service = MockProductService()
        let viewModel = ProductViewModel(service: service)
        
        XCTAssertNil(viewModel.product, "Produto inicial deve ser nil")
        XCTAssertTrue(viewModel.products.isEmpty, "Lista inicial deve ser vazia")
        XCTAssertFalse(viewModel.isLoading, "Não deve iniciar carregando")
        XCTAssertNil(viewModel.errorMessage, "Não deve iniciar com erro")
        XCTAssertFalse(viewModel.isLoaded, "Não deve estar carregado inicialmente")
    }
}
