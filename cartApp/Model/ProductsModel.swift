//
//  ProductsModel.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import Foundation

// MARK: - AllProducts
struct AllProducts: Codable {
    let products: [Product]
}

// MARK: - Product
enum ProductKeys: String, CodingKey {
    case name, price, image_url, rating
}

struct Product: Codable {
    let name, price: String?
    let image_url: String?
    let rating: Int?
}

extension Product {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductKeys.self)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        price = try? container.decodeIfPresent(String.self, forKey: .price)
        image_url = try? container.decodeIfPresent(String.self, forKey: .image_url)
        rating = try? container.decodeIfPresent(Int.self, forKey: .rating)
    }
}

