//
//  NetworkManager.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    func fetchRequest<T: Codable>(urlString: String, completionHandler: @escaping (T?, Error?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    static var shared = NetworkManager()
    
    init() {}

    func fetchRequest<T: Codable>(urlString: String, completionHandler: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, NSError(domain: "InvalidURL", code: 400, userInfo: nil))
            return
        }

        AF.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // Decoding the response into the desired model
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(decodedResponse, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
