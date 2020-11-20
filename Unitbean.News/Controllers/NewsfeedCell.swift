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
}
