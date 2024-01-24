//
//  ContentView.swift
//  swiftui-alamofire
//
//  Created by Kioser PC on 24/01/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel: ContentViewModel
  
  init() {
    _viewModel = StateObject(wrappedValue: ContentViewModel())
  }
  
  var body: some View {
    VStack {
      HStack {
        Image(systemName: "house")
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(Color.white)
        
        Spacer()
        
        Text("ALAMOFIRE")
          .font(.system(size: 15,weight: .bold))
          .foregroundColor(Color.white)
        
        Spacer()
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 16)
      .background(.blue)
      
      HStack {
        Image(systemName: "magnifyingglass")
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(.black)
        
        TextField("Cari Product...", text: $viewModel.search)
          .onChange(of: viewModel.search) { newValue in
            if newValue.isEmpty{
              viewModel.restListProduct()
            }
            else{
              viewModel.restSearchProduct()
            }
          }
          .font(.system(size: 15,weight: .regular))
          .padding(10)
        
        Spacer()
      }
      .padding(.leading, 10)
      .background(.white)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(.gray, lineWidth: 2)
      )
      .cornerRadius(8)
      .padding(10)
      
      ScrollView {
        LazyVStack(spacing: 10) {
          ForEach(viewModel.data, id: \.id) { data in
            VStack {
              ItemContentView(item: data)
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 1)
            .shadow(radius: 2)
          }
          
          _VSpacer(minHeight: 30)
        }
        .cornerRadius(10)
      }
      
      if !viewModel.errorText.isEmpty {
        VStack {
          
          Text(viewModel.errorText)
            .font(.system(size: 15,weight: .semibold))
            .foregroundColor(.black)
            .multilineTextAlignment(TextAlignment.center)
            .padding(.top, 10)
        }
        .padding(.vertical, 20)
      }
    }
    .onAppear {
      viewModel.restListProduct()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
