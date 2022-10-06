//
//  HotelViewModel.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 2.10.2022.
//

import Foundation

protocol HomeModelProtocol: AnyObject {
    func didDataFetch(_ isSuccess: Bool)
}

class HomeModel {
    
    weak var delegate : HomeModelProtocol?
    var posts: News?

    func fetchData() {
        
        guard let url = URL.init(string: "https://newsdata.io/api/1/news?apikey=pub_119564c265aa84f67edc5be6e3cb769eba4c4&language=en&category=environment") else {
            delegate?.didDataFetch(false)
            return
        }
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
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
                self.posts = try jsonDecoder.decode(News.self, from: data)
                self.delegate?.didDataFetch(true)
            } catch {
                print(error)
                self.delegate?.didDataFetch(false)
            }
        }
        task.resume()
    }
}
