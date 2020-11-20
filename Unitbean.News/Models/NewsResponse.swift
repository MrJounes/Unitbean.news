//
//  NewsResponse.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 19.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

struct NewsResponse: Decodable {
    var status: String
    var articles: [Article]
}

struct Article: Decodable {
    var author: String?
    var title: String
    var description: String
    var urlToImage: String
    var publishedAt: String
}
