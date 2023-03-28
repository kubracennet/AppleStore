//
//  Store.swift
//  AppleStore
//
//  Created by Kübra Cennet Yavaşoğlu on 28.03.2023.
//

import StoreKit
import Foundation
import SwiftUI


//Fetch Products
//Puchase Product
//Update UI / Fetch Product State

class ViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var purchasedIds: [String] = []
    
    func fetchProducts() {
        async {
            do {
                let products = try await
                Product.request(with: ["com.apple.watch"])
                DispatchQueue.main.async {
                    self.products = products
                }
                if let product = products.first {
                    await isPurchased(product: product)
                }
            }
            catch {
                print(error)
        }
    }
 }
    func isPurchased(product: Product) async {
        guard let state = await product.currentEntitlement else {
            return
        }
        switch state {
        case.verified(let transaction):
            DispatchQueue.main.async {
                self.purchasedIds.append(transaction.productID)
            }
        case.unverified(_):
            break
            
        }
    }
    
    func purchase(product: Product) {
        async {
            guard let product = products.first else { return }
            do {
                let result = try await product.purchase()
                switch result {
                    
                case .success(let verification):
                    switch verification {
                    case.verified(let transaction):
                        print(transaction.productID)
                    case.unverified(_):
                        break

                    }
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            }
            catch {
                print(error)
                
            }
            
        }
        
    }
}
