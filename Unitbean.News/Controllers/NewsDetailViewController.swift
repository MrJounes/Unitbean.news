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
}
