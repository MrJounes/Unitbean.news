//
//  NewsDetailViewController.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 19.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var detailAuthorLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailTitileLabel: UILabel!
    @IBOutlet weak var detailImageView: WebImageView!
    @IBOutlet weak var detailTextLabel: UILabel!
    
    
    var detailTitle = ""
    var detailAuthor = ""
    var detailDate = ""
    var detailText = ""
    var detailImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitileLabel.text = detailTitle
        detailAuthorLabel.text = detailAuthor
        detailDateLabel.text = detailDate
        detailTextLabel.text = detailText
        detailImageView.set(urlString: detailImage)
    }
    
    func configure(with detailVC: NewsDetailViewController, newsResponse: NewsResponse?, indexPath: IndexPath) {
        
        let article = newsResponse?.articles[indexPath.row]
        detailVC.detailTitle = article?.title ?? "Заголовок"
        if article?.author == nil || article?.author == "" {
            detailVC.detailAuthor = "Дикань Игорь"
        } else {
            detailVC.detailAuthor = article?.author as! String
        }
        detailVC.detailDate = DateConversionService.shared.getDate(dateString: article?.publishedAt ?? "1970-01-01")
        detailVC.detailText = article?.description ?? "Детальное описание"
        detailVC.detailImage = article?.urlToImage ?? "https://болгарка.укр/app_default/media/eshop/no_photo.jpg"
    }
}
