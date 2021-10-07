//
//  FetchProductStore.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import Foundation

class FetchProductStore {
    
    let networkService = NetworkService()
        
        /// This function will make the get request for the user details.
        ///
        /// - Parameters:
        ///        - callback: A callback  with the parameters `result` having the data and `error` which is a ServerError object.
        func getProducts(callback:@escaping (_ result: AllProducts?, _ error:ServerError?) -> Void) {
            networkService.get(withBaseURL: NetworkConstants.productsAPI) {
                (result, error) in
                let decoder = JSONDecoder()
                if error == nil {
                    if let resultData = result, let decodedData = try? decoder.decode(AllProducts.self, from: resultData) {
                        callback(decodedData, nil)
                    } else {
                        callback(nil, CommonUtils.sharedInstance.defaultError())
                    }
                } else {
                    callback(nil, CommonUtils.sharedInstance.defaultError())
                }
            }
        }
    
}
