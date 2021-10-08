//
//  ProductsModel.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import Foundation
import Realm
import RealmSwift

// MARK: - AllProducts
struct AllProducts: Codable {
    let products: [Product]
}

// MARK: - Product
enum ProductKeys: String, CodingKey {
    case name, price, image_url, rating
}

@objcMembers class Product: Object, Codable {
    dynamic var name, price: String?
    dynamic var image_url: String?
    dynamic var rating: Int?
    
    required override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: ProductKeys.self)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        price = try? container.decodeIfPresent(String.self, forKey: .price)
        image_url = try? container.decodeIfPresent(String.self, forKey: .image_url)
        rating = try? container.decodeIfPresent(Int.self, forKey: .rating)
    }
}
