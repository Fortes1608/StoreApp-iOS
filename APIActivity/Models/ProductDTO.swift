//
//  ProductDTO.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 20/08/25.
//

struct ProductResponse: Decodable {
    var products: [ProductDTO]
}

struct ProductDTO: Decodable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var rating: Double
    var thumbnail: String

}

extension ProductDTO {
    func fromDTO(_ dto: ProductDTO) -> Product {
        Product(
            idAPI: dto.id,
            titleAPI: dto.title,
            descriptionAPI: dto.description,
            categoryAPI: dto.category,
            priceAPI: dto.price,
            ratingAPI: dto.rating,
            thumbnailAPI: dto.thumbnail
        )
    }

}
