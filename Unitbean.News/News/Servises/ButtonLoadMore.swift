//
//  ButtonLoadMore.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 23.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation
import UIKit

class ButtonLoadMore {
    
    private init() {}
    static let shared = ButtonLoadMore()
    
    struct Constsants {
        static let numberOfNews: Int = 4
    }
    
    var recordsArray: [Article] = Array()
    var limit = Constsants.numberOfNews
    var totalEnetries = 20
    
    func addLoadMoreButton(tableView: UITableView) {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 40)))
        button.setTitle("Load more", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(moreButtonClicked(_:)), for: .touchUpInside)
        tableView.tableFooterView = button
    }

    @objc func moreButtonClicked(_ sender: UIButton) {

    }
}
