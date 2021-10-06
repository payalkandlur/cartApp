//
//  NetworkService.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import Foundation

class NetworkService {
    
    static let sharedInstance = NetworkService()
        
    //MARK: GET
    /// This is the GET call through URL Session
    ///
    /// - Parameters:
    ///     - withBaseURL: the base url of the API call
    ///     - params: params to be passed in the call in form of dictionary
    ///     - completion: callback with Data and Server Object
    func get(withBaseURL: String,
             params : [String : String]? = nil,
             completion: @escaping (_ result:Data?,_ error:ServerError?) -> Void) {
        
        if var components = URLComponents(string: withBaseURL) {
            if let paramDict = params {
                let keys = paramDict.map{String($0.key) }
                for key in keys {
                    components.queryItems = [URLQueryItem(name: key, value: paramDict[key])]
                }
            }
            
            if let url2 = components.url {
                let request  = URLRequest(url: url2)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    DispatchQueue.main.async {
                        if error == nil {
                            completion(data, nil)
                        } else {
                            if let err = error as NSError? {
                                let error = ServerError(err: err)
                                completion(nil, error)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
}
