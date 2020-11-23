//
//  NewsFetcher.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 23.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

class NewsFetcher {
    
    private init() {}
    static let shared = NewsFetcher()
    
    let networkDataFetcher = NetworkDataFetcher.shared
    
    func getNews(complition: @escaping (NewsResponse?) -> Void) {
        
        let urlString = "http://newsapi.org/v2/top-headlines?country=ru&apiKey=3bf2bcbc726d444ca580f2e0fa6c30be"

        networkDataFetcher.fetchArticles(urlString: urlString) { (newsResponse) in
            guard let newsResponse = newsResponse else { return }
            complition(newsResponse)

        }
    }

}
