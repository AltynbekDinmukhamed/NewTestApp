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
    
    //MARK: -Fetching data for NumberViewController-
    func fetchRoomData(completion: @escaping(RoomData?) -> Void) {
        let urlString = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            do {
                let roomData = try JSONDecoder().decode(RoomData.self, from: data)
                print(roomData)
                completion(roomData)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    //MARK: -Fetching data for Book Daat-
    func fetchBookInfo(completion: @escaping(BookData?) -> Void) {
        let urlString = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(BookData.self, from: data)
                completion(json)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
