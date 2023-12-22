//
//  RoomData.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 22.12.2023.
//

import Foundation

struct RoomData: Decodable {
    let rooms: [Room]
}

struct Room: Codable {
    let id: Int
    let name: String
    let price: Int
    let price_per: String
    let peculiarities: [String]
    let image_urls: [String]
}
