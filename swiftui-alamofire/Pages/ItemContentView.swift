//
//  ItemContentView.swift
//  swiftui-alamofire
//
//  Created by Kioser PC on 24/01/24.
//

import SwiftUI

struct ItemContentView: View {
  var item: RestProductModel

  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        AsyncImage(url: URL(string: item.images[0])) { image in
          image.resizable()
        } placeholder: {
          Color(.gray)
        }
        
        .frame(width: 60, height: 60)
        .clipShape(Circle())

        VStack(alignment: .leading, spacing: 0) {
          Text(item.title)
            .font(.system(size: 15,weight: .medium))
            .foregroundColor(Color.black)
          
          Spacer()

          Text(item.description)
            .font(.system(size: 12,weight: .regular))
            .foregroundColor(Color.black)
        }
//        .padding(.top, 10)
        
        Spacer()
      }
      .padding()
      Color(.gray)
        .frame(width: 200, height: 1)
    }
  }
}

struct ItemContentView_Previews: PreviewProvider {
  static var previews: some View {
    let sample = RestProductModel(id: 1,
                                  title: "iPhone 9",
                                  description: "An apple mobile which is nothing like apple",
                                  price: 549,
                                  discount: 12.96,
                                  rating: 4.69,
                                  stock: 94,
                                  brand: "Apple",
                                  category: "smartphones",
                                  thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
                                  images: ["https://cdn.dummyjson.com/product-images/1/1.jpg", "https://cdn.dummyjson.com/product-images/1/2.jpg"])

    ItemContentView(item: sample)
  }
}
