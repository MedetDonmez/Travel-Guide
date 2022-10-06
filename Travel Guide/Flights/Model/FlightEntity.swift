//
//  ImagesEntity.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 29.09.2022.
//

import Foundation
import UIKit

struct FlightCellViewModel {
    var name: String
    var desc: String
    var detail: String?
    var imageURL : String?
}

struct flights: Decodable {
    var data: [String:flightInfo]
}

struct flightInfo: Decodable {
    var origin: String
    var destination: String
    var price: Int
    var airline: String
    var flight_number: Int
    var departure_at: String
    var return_at: String
    var transfers: Int
    var expires_at: String
}

