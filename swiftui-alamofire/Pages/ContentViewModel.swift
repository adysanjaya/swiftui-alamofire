//
//  ContentViewModel.swift
//  swiftui-alamofire
//
//  Created by Kioser PC on 24/01/24.
//

import Alamofire
import SwiftUI

class ContentViewModel: ObservableObject {
  let apiService = AFApiService.shared
  @Published var data: [RestProductModel] = []
  @Published var errorText = ""
  @Published var search = ""
  
  func restListProduct() {
    self.errorText = ""
    self.apiService.getListProduct { result in
      switch result {
      case .success(let response):
        self.data = response.products
      case .failure(let error):
        if error is RestErrorModel {
          self.errorText = (error as! RestErrorModel).message
        }
        else {
          self.errorText = error.localizedDescription
        }
      }
    }
  }
  
  func restSearchProduct() {
    self.errorText = ""
    let parameters: Parameters = [
      "q": self.search,
    ]
    self.apiService.searchListProduct(parameters: parameters) { result in
      switch result {
      case .success(let response):
        self.data = response.products
      case .failure(let error):
        if error is RestErrorModel {
          self.errorText = (error as! RestErrorModel).message
        }
        else {
          self.errorText = error.localizedDescription
        }
      }
    }
  }
}
