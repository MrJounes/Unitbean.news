//
//  NewsfeedTableViewController.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 19.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {
    
    struct Constsants {
        static let numberOfNews: Int = 4
    }
    
    let dateConversionService = DateConversionService.shared
    let newsFetcher = NewsFetcher.shared
    var newsResponse: NewsResponse? = nil
    var articleResponse: [Article]? = nil
    
    var recordsArray: [Article] = Array()
    var limit = Constsants.numberOfNews
    var totalEnetries = 20
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseID)
        
        newsFetcher.getNews { (newsResponse) in
            guard let newsResponse = newsResponse else { return }
            self.newsResponse = newsResponse
            self.articleResponse = newsResponse.articles
            self.table.reloadData()
            
            var index = 0
            while index < self.limit {
                guard let article = self.articleResponse?[index] else { return }
                self.recordsArray.append(article)
                index = index + 1
            }
            print(self.recordsArray.count)
            self.table.reloadData()
        }
        
        self.addLoadMoreButton()
    }
    
    func addLoadMoreButton() {
        
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.tableView.frame.width, height: 40)))
        button.setTitle("Загрузить еще", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(moreButtonClicked(_:)), for: .touchUpInside)
        self.tableView.tableFooterView = button
    }
    
    @objc func moreButtonClicked(_ sender: UIButton) {
        if recordsArray.count < totalEnetries && recordsArray.count < totalEnetries + Constsants.numberOfNews{
            var index = recordsArray.count
            limit = index + Constsants.numberOfNews
            while index < limit {
                guard let article = articleResponse?[index] else { return }
                recordsArray.append(article)
                index = index + 1
            }
            self.table.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 323
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailXIB", sender: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseID, for: indexPath) as! NewsfeedCell
        let article = newsResponse?.articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailXIB" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! NewsDetailViewController
                detailVC.configure(with: detailVC, newsResponse: newsResponse, indexPath: indexPath)
            }
        }
    }

}
