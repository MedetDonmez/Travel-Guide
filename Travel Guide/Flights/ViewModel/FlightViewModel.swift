//
//  ImagesViewModel.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import Foundation
import Kingfisher
import UIKit

protocol FlightViewModelProtocol: AnyObject {
    
    func didCellItemFetch(_ items: [FlightCellViewModel])
}

class FlightViewModel {
    
    weak var viewDelegate: FlightViewModelProtocol?
    let model = FlightModel()
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }
}

private extension FlightViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ posts: flights) -> [FlightCellViewModel] {
        var items : [FlightCellViewModel] = []
        var item : FlightCellViewModel?
        
        for key in posts.data {
            let images = ["https://italyadaegitim.com/wp-content/uploads/2020/11/kolezyum-roma-1-1.jpg",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREUehJPJ8mLsmnmFAtvxwqglwvwsR_jFgqhg&usqp=CAU",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi8vOpv5Z8wm_ejp5dbx3pa2e1ke4X6wifbg&usqp=CAU",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSn2IIlccVervlD7BVEd5VyNs712JNNsPzMNA&usqp=CAU",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS6MqSLZ_00s6v_gk5lSqK3bF0f_eIjPAmkA&usqp=CAU","https://images.unsplash.com/photo-1472214103451-9374bd1c798e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGxhY2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60","https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGxhY2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"]
            let number = Int.random(in: 0...6)
            item = FlightCellViewModel(name: "\(key.value.origin)-\(key.value.destination)", desc: "$\(String(key.value.price))", detail:"price =$\(String(key.value.price))\nairline: \(key.value.airline)\ndeparture at: \(key.value.departure_at)\nreturn at: \(key.value.return_at)\nexpires at: \(key.value.expires_at)", imageURL: images[number])
            items.append(item!)
        }
        return items
    }
}


extension FlightViewModel: FlightModelProtocol {
    
    func didDataFetch(_ isSuccess: Bool) {
        if isSuccess {
            print("amazing")
            let posts = model.posts
            let cellModels = makeViewBasedModel(posts!)
            viewDelegate?.didCellItemFetch(cellModels)
            
        } else {
            print("Can't fetch data.")
        }
    }
}
