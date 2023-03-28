//
//  ContentView.swift
//  AppleStore
//
//  Created by Kübra Cennet Yavaşoğlu on 28.03.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .resizable()
                .aspectRatio(nil, contentMode: .fit)
                .frame(width: 70, height: 70)
            
            Text("Apple Store")
                .bold()
                .font(.system(size: 32))
            
            Image("watch")
                .resizable()
                .aspectRatio(nil, contentMode: .fit)
            
            if let product = viewModel.products.first {
                Text(product.displayName)
                Text(product.description)
                Button(action: {
                    if viewModel.purchase.isEmpty {
                        viewModel.purchase()
                    }
                       
                }) {
                    
                    Text("Buy Now (\(product.displayPrice)")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 220, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                    
                }
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
