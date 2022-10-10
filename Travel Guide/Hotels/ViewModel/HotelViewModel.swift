//
//  HotelViewModel.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 2.10.2022.
//

import Foundation
import UIKit

protocol HotelViewModelProtocol: AnyObject {
    func didCellItemFetch(_ items: [HotelCellViewModel])
}

class HotelViewModel {
    
    weak var viewDelegate: HotelViewModelProtocol?
    let model = HotelModel()
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }
}

// MARK: -
private extension HotelViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ posts: Hotels) -> [HotelCellViewModel] {
        var items : [HotelCellViewModel] = []
        for key in posts.data!.body!.searchResults!.results! {
            items.append(HotelCellViewModel(name: key.name!, desc: key.address!.streetAddress!, imageURL: key.optimizedThumbUrls?.srpDesktop, details: "nightly price: \(key.ratePlan!.price!.current!)\n\(key.landmarks![0].distance!) to \(key.landmarks![0].label!)\n\(key.landmarks![1].distance!) to \(key.landmarks![1].label!)"))
        }
        return items
    }
}

// MARK: - HotelModelProtocol
extension HotelViewModel: HotelModelProtocol {
    
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
