//
//  HotelViewModel.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 2.10.2022.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: AnyObject {
    
    func didCellItemFetch(_ items: [NewsCellViewModel])
}

class HomeViewModel {

    weak var viewDelegate: HomeViewModelProtocol?
    let model = HomeModel()
    init() {
        model.delegate = self
    }
    func didViewLoad() {
        model.fetchData()
    }
}

// MARK: -
private extension HomeViewModel {
    
    @discardableResult
    //creating new item list using posts
    func makeViewBasedModel(_ posts: News) -> [NewsCellViewModel] {
        var items : [NewsCellViewModel] = []
        
        //mapping posts to items , I have assigned base image for no-image news.
        for key in posts.results {
            items.append(NewsCellViewModel(name: key.category[0], desc:key.title, imageURL: key.image_url ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Mercator-projection.jpg/1200px-Mercator-projection.jpg", details:"date :\(String(describing: key.pubDate))\n\( key.description ?? "For more details visit website.")"))
        }
        return items
    }
}

// MARK: - 
extension HomeViewModel: HomeModelProtocol {
    
    func didDataFetch(_ isSuccess: Bool) {
        if isSuccess {
            let posts = model.posts
            let cellModels = makeViewBasedModel(posts!)
            viewDelegate?.didCellItemFetch(cellModels)
            
        } else {
            print("Can't fetch data.")
        }
    }
}


