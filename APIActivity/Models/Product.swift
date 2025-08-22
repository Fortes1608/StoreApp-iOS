//
//  Product.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 13/08/25.
//

import Foundation
import SwiftData

@Model
class Product: Identifiable {
    var idAPI: Int
    var titleAPI: String
    var descriptionAPI: String
    var categoryAPI: String
    var priceAPI: Double
    var ratingAPI: Double
    var thumbnailAPI: String
    var isFavorite: Bool
    var quantity: Int
    var isCart: Bool
    var isOrdered: Bool
    var date: Date
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idAPI = try container.decode(Int.self, forKey: .idAPI)
        self.titleAPI = try container.decode(String.self, forKey: .titleAPI)
        self.descriptionAPI = try container.decode(String.self, forKey: .descriptionAPI)
        self.categoryAPI = try container.decode(String.self, forKey: .categoryAPI)
        self.priceAPI = try container.decode(Double.self, forKey: .priceAPI)
        self.ratingAPI = try container.decode(Double.self, forKey: .ratingAPI)
        self.thumbnailAPI = try container.decode(String.self, forKey: .thumbnailAPI)
        self.isFavorite = false
        self.quantity = 1
        self.isCart = false
        self.isOrdered = false
        self.date = Date()
    }
    
    init (idAPI: Int, titleAPI: String, descriptionAPI: String, categoryAPI: String, priceAPI: Double, ratingAPI: Double, thumbnailAPI: String) {
        self.idAPI = idAPI
        self.titleAPI = titleAPI
        self.descriptionAPI = descriptionAPI
        self.categoryAPI = categoryAPI
        self.priceAPI = priceAPI
        self.ratingAPI = ratingAPI
        self.thumbnailAPI = thumbnailAPI
        self.isFavorite = false
        self.quantity = 1
        self.isCart = false
        self.isOrdered = false
        self.date = Date()
    }
    
    init (from dto: ProductDTO) {
        self.idAPI = dto.id
        self.titleAPI = dto.title
        self.descriptionAPI = dto.description
        self.categoryAPI = dto.category
        self.priceAPI = dto.price
        self.ratingAPI = dto.rating
        self.thumbnailAPI = dto.thumbnail
        self.isFavorite = false
        self.quantity = 1
        self.isCart = false
        self.isOrdered = false
        self.date = Date()
    }
    
    init (from product: Product) {
        self.idAPI = product.idAPI
        self.titleAPI = product.titleAPI
        self.descriptionAPI = product.descriptionAPI
        self.categoryAPI = product.categoryAPI
        self.priceAPI = product.priceAPI
        self.ratingAPI = product.ratingAPI
        self.thumbnailAPI = product.thumbnailAPI
        self.isFavorite = product.isFavorite
        self.quantity = product.quantity
        self.isCart = product.isCart
        self.isOrdered = product.isOrdered
        self.date = Date()
    }
    
    init () {
        self.idAPI = 1
        self.titleAPI = ""
        self.descriptionAPI = ""
        self.categoryAPI = ""
        self.priceAPI = 0
        self.ratingAPI = 0
        self.thumbnailAPI = ""
        self.isFavorite = false
        self.quantity = 1
        self.isCart = false
        self.isOrdered = false
        self.date = Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case idAPI = "id"
        case titleAPI = "title"
        case descriptionAPI = "description"
        case categoryAPI = "category"
        case priceAPI = "price"
        case ratingAPI = "rating"
        case thumbnailAPI = "thumbnail"
    }
}

extension Product {
    func fromDTO(_ dto: ProductDTO) -> Product {
        return Product(
            idAPI: dto.id,
            titleAPI: dto.title,
            descriptionAPI: dto.description,
            categoryAPI: dto.category,
            priceAPI: dto.price,
            ratingAPI: dto.rating,
            thumbnailAPI: dto.thumbnail
        )
    }
    func toDTO() -> ProductDTO {
        ProductDTO(
            id: idAPI,
            title: titleAPI,
            description: descriptionAPI,
            category: categoryAPI,
            price: priceAPI,
            rating: ratingAPI,
            thumbnail: thumbnailAPI
        )
    }
}
