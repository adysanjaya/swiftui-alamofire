//
//  RestProductModel.swift
//  swiftui-alamofire
//
//  Created by Kioser PC on 24/01/24.
//

import Foundation

struct RestProductModel: Codable, Equatable {
  let id: Int
  let title: String
  let description: String
  let price: Int32
  let discount: Double
  let rating: Double
  let stock: Int
  let brand: String
  let category: String
  let thumbnail: String
  let images: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case price
    case discount = "discountPercentage" //contoh jika nama model berbeda dengan nama json
    case rating
    case stock
    case brand
    case category
    case thumbnail
    case images
  }
}
