//
//  NewsDetailViewController.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 19.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var detailTitileLabel: UILabel!
    
    var detailTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitileLabel.text = detailTitle
    }
}
