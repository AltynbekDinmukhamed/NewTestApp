//
//  NetworkService.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 16.12.2023.
//

import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    
    //MARK: -LifeCycle-
    private init() {}
    
    //MARK: -getting Hotel datas-
    func fetchHotelData(completion: @escaping (Hotel?) -> Void) {
        let urlString = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }

            do {
                let hotel = try JSONDecoder().decode(Hotel.self, from: data)
                completion(hotel)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
