//
//  NewsfeedCell.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 19.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedCell: UITableViewCell {
    
    static let reuseID = "NewsfeedCell"
    
    @IBOutlet weak var newsImageView: WebImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var countShapeLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with article: Article?) {
        if article?.author == nil || article?.author == "" {
            self.newsAuthorLabel.text = "Дикань Игорь"
        } else {
            self.newsAuthorLabel.text = article?.author
        }
        self.newsTitleLabel.text = article?.title
        self.newsDateLabel.text = DateConversionService.shared.getDate(dateString: article?.publishedAt)
        self.countShapeLabel.text = String(Int.random(in: 1...20))
        self.newsImageView.set(urlString: article?.urlToImage ?? "https://болгарка.укр/app_default/media/eshop/no_photo.jpg")
    }
}
