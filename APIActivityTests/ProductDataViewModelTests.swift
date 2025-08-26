//
//  ProductDataViewModelTests.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 25/08/25.
//

import XCTest
import SwiftData
@testable import APIActivity

final class ProductDataViewModelTests : XCTestCase{
    
    func test_refreshFavorites() async throws {
        
        // Given
        let service = MockSwiftDataService(shouldFail: false)
        let viewModel = ProductDataViewModel(service: service)
        
        //When
        viewModel.setFavorite(service.products[0])
        viewModel.refreshFavorites()
        let favorites = viewModel.favorites
        //Then
        
        XCTAssertTrue(!favorites.isEmpty)
        //       XCTAssertFalse(viewModel.favorites.isEmpty)
        
    }
    
    func test_refreshCart() async throws {
        
        // Given
        let service = MockSwiftDataService(shouldFail: false)
        let viewModel = ProductDataViewModel(service: service)
        
        //When
        viewModel.setCart(service.products[0])
        viewModel.refreshCart()
        let cart = viewModel.cart
        //Then
        
        XCTAssertTrue(!cart.isEmpty)
        
    }
    func test_refreshOrdered() async throws {
        
        // Given
        let service = MockSwiftDataService(shouldFail: false)
        let viewModel = ProductDataViewModel(service: service)
        
        //When
        viewModel.setOrdered(service.products)
        viewModel.refreshOrdered()
        let ordered = viewModel.ordered
        //Then
        
        XCTAssertTrue(!ordered.isEmpty)
        
    }
    
    func test_SetFavorite() {
        //Given
        let service = MockSwiftDataService(shouldFail: false)
        let viewModel = ProductDataViewModel(service: service)
        
        //When
        viewModel.setFavorite(service.products.first!)
        
        //Then
        XCTAssertTrue(viewModel.favorites.contains(where: { $0.self == service.products.first }))
        
    }
    
    func test_SetCart() {
        //Given
        let service = MockSwiftDataService(shouldFail: false)
        let viewModel = ProductDataViewModel(service: service)
        
        //When
        viewModel.setCart(service.products.first!)
        
        //Then
        XCTAssertTrue(viewModel.cart.contains(where: { $0.self == service.products.first }))
        
    }
    
    func test_SetOrdered() {
        //Given
        let service = MockSwiftDataService(shouldFail: false)
        let viewModel = ProductDataViewModel(service: service)
        
        //When
        viewModel.setOrdered(service.products)
        
        //Then
        XCTAssertTrue(viewModel.ordered.contains(where: { $0.self == service.products.first }))
        
    }
    
    func test_totalPrice() {
        let service = MockSwiftDataService(shouldFail: false)
        let viewModel = ProductDataViewModel(service: service)
        
        viewModel.cart.append(contentsOf: service.products)
        
        XCTAssertEqual(viewModel.totalPrice(), 30)
    }
    
    
    
    
}
