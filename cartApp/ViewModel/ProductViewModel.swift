//
//  ProductViewModel.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import Foundation

class ProductViewModel {
    let productManager = FetchProductManager()
    
    var isGetListSuccess: Dynamic<Bool> = Dynamic(false)
    var productList: [Product]?
    var filteredList: [Product]?
    var errorMessage = ""
    
    //MARK: Get the user details
    /// This function will get the products from the backend.
    func getProducts() {
        productManager.getProducts { [weak self]
            (result, error)  in
            if error == nil {
                if let data = result?.products {
                    self?.productList = data
                }
                self?.isGetListSuccess.value = true
            } else {
                self?.errorMessage = error?.errorMessage ?? ErrorConstants.defaultError
                self?.isGetListSuccess.value = false
            }
        }
    }
    
    
    func sortGreater() {
        self.filteredList = productList?.filter({Int($0.price!)! > 1000})
    }
    func sortLesser() {
        self.filteredList = productList?.filter({Int($0.price!)! < 1000})
    }
}

