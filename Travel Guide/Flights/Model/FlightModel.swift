//
//  HotelViewModel.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 2.10.2022.
//

import Foundation
import UIKit

protocol FlightModelProtocol: AnyObject {
    func didDataFetch(_ isSuccess: Bool)
}

class FlightModel {
    
    weak var delegate : FlightModelProtocol?
    var posts: flights?
    
    func fetchData() {
        guard let url = URL.init(string: "https://travelpayouts-travelpayouts-flight-data-v1.p.rapidapi.com/v1/prices/calendar?origin=IST&currency=USD") else {
            delegate?.didDataFetch(false)
            return
        }
        
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("8f3cc095c4173ff19bb50ea271aafca2", forHTTPHeaderField: "X-Access-Token")
        request.setValue("be3b16b6d2msh663215e019b743ap105d75jsn1a036d32bfdb", forHTTPHeaderField: "X-RapidAPI-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil
            else {
                self.delegate?.didDataFetch(false)
                return
            }
            guard let data = data else {
                self.delegate?.didDataFetch(false)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                self.posts = try jsonDecoder.decode(flights.self, from: data)
                self.delegate?.didDataFetch(true)
            } catch {
                print(error)
                self.delegate?.didDataFetch(false)
            }
        }
        task.resume()
    }
}
