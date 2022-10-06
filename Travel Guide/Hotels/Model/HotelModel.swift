//
//  HotelViewModel.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 2.10.2022.
//

import Foundation

protocol HotelModelProtocol: AnyObject {
    func didDataFetch(_ isSuccess: Bool)
}

class HotelModel {
    weak var delegate : HotelModelProtocol?
    var posts: Hotels?
    
    func fetchData() {
        guard let url = URL.init(string: "https://hotels4.p.rapidapi.com/properties/list?destinationId=1506246&pageNumber=1&pageSize=25&checkIn=2022-11-01&checkOut=2022-11-20&adults1=1&sortOrder=PRICE&locale=en_US&currency=USD") else {
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
                self.posts = try jsonDecoder.decode(Hotels.self, from: data)
                self.delegate?.didDataFetch(true)
            } catch {
                print(error)
                self.delegate?.didDataFetch(false)
            }
        }
        task.resume()
    }
}
