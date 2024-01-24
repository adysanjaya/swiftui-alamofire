//
//  AFApiService.swift
//  swiftui-alamofire
//
//  Created by Kioser PC on 24/01/24.
//

import Alamofire
import Foundation
import SwiftyJSON

class AFApiService {
  static let shared = AFApiService()
  private let baseURL = "https://dummyjson.com"
  private func makeRequest<T: Codable>(
    endpoint: String,
    method: HTTPMethod,
    parameters: Parameters? = nil,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    let url = baseURL + endpoint
    
    //Jika ingin menambahkan authorization
    let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    let token = UserDefaults.standard.string(forKey: "userToken") ?? ""
    var headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    if isLoggedIn {
      headers["api-token"] = token
    }
    //Jika ingin menambahkan authorization
    
    print("💙 ==> ALAMOFIRE URL: \(method.rawValue) - \(url)")
    print("💙 ==> ALAMOFIRE HEADER: \(headers)")
    if let parameters = parameters {
      print("💜 ==> ALAMOFIRE PARAMS: \(parameters)")
    }
    
    AF.request(url, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.queryString : URLEncoding.httpBody, headers: headers, interceptor: nil, requestModifier: nil)
      .validate()
      .responseDecodable(of: T.self) { response in
        switch response.result {
        case .success(let value):
          //===> DEBUGING PURPOSE
          if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
            print("💚 <== ALAMOFIRE RESPONSE: \(rawResponse)")
          }
          // <=== DEBUGING PURPOSE
          
          completion(.success(value))
        case .failure(let error):
          if let data = response.data {
            do {
              if let rawErrorResponse = String(data: data, encoding: .utf8) {
                print("❤️ <== ALAMOFIRE ERROR: \(rawErrorResponse)")
              }
              let errorModel = try JSONDecoder().decode(RestErrorModel.self, from: data)
              completion(.failure(errorModel))
            } catch let DecodingError.dataCorrupted(context) {
              print("❤️ <== ALAMOFIRE ERROR: \(context)")
              completion(.failure(error))
            } catch let DecodingError.keyNotFound(key, context) {
              print("❤️ <== ALAMOFIRE ERROR: Key '\(key)' not found:", context.debugDescription)
              print("❤️ <== ALAMOFIRE ERROR: CodingPath:", context.codingPath)
              completion(.failure(error))
            } catch let DecodingError.valueNotFound(value, context) {
              print("❤️ <== ALAMOFIRE ERROR: Value '\(value)' not found:", context.debugDescription)
              print("❤️ <== ALAMOFIRE ERROR: CodingPath:", context.codingPath)
              completion(.failure(error))
            } catch let DecodingError.typeMismatch(type, context)  {
              print("❤️ <== ALAMOFIRE ERROR: Type '\(type)' mismatch:", context.debugDescription)
              print("❤️ <== ALAMOFIRE ERROR: codingPath:", context.codingPath)
              completion(.failure(error))
            } catch {
              print("❤️ <== ALAMOFIRE ERROR: \(error.localizedDescription)")
              completion(.failure(error))
            }
          } else {
            print("❤️ <== ALAMOFIRE ERROR: \(error.localizedDescription)")
            completion(.failure(error))
          }
        }
      }
  }
  
  // HOME
  func getListProduct(completion: @escaping (Result<RestListProductModel<RestProductModel>, Error>) -> Void) {
    makeRequest(endpoint: "/products", method: .get, completion: completion)
  }
  
  func searchListProduct(parameters: Parameters, completion: @escaping (Result<RestListProductModel<RestProductModel>, Error>) -> Void) {
    makeRequest(endpoint: "/products/search", method: .get, parameters: parameters, completion: completion)
  }
}

