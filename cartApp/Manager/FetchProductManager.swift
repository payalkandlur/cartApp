//
//  FetchProductManager.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import Foundation

class FetchProductManager {
    
    let productStore =  FetchProductStore()
    
    /// This function will make the get request for the user details.
    ///
    /// - Parameters:
    ///        - callback: A callback  with the parameters `result` having the data and `error` which is a ServerError object.
    func getProducts(callback:@escaping (_ result:AllProducts?, _ error:ServerError?) -> Void) {
        productStore.getProducts() {
            (result, error) in
            if error == nil {
                callback(result,nil)
            } else {
                callback(nil, error)
            }
        }
    }
    
}
