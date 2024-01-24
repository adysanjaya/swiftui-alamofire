//
//  RestListProductModel.swift
//  swiftui-alamofire
//
//  Created by Kioser PC on 24/01/24.
//

import Foundation

struct RestListProductModel<T: Codable>: Codable {
  let products: [T]
  let total: Int
  let skip: Int
  let limit: Int
}
