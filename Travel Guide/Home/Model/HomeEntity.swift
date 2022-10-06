//
//  HomeEntity.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 4.10.2022.
//

import Foundation
import UIKit
struct NewsCellViewModel {
    var name: String
    var desc: String
    var imageURL: String?
    var details: String?
}

// MARK: - News
struct News: Decodable {
    let status: String?
    let totalResults: Int?
    let results: [NewsInfo]?
    let nextPage: Int?
}

// MARK: - NewsInfo
struct NewsInfo: Decodable{
    let title: String?
    let link: String?
    let keywords: [String]?
    let creator: [String]?
    let video_url: String?
    let description: String?
    let content: String?
    let pubDate: String?
    var image_url: String?
    let source_id: String?
    let country: [String]?
    let category: [String]?
    let language: String?
}
