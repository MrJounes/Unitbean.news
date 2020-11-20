//
//  NewsfeedTableViewController.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 19.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {

    let networkDataFetcher = NetworkDataFetcher()
    var newsResponse: NewsResponse? = nil
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseID)
        
        let urlString = "http://newsapi.org/v2/top-headlines?country=ru&apiKey=3bf2bcbc726d444ca580f2e0fa6c30be"

        networkDataFetcher.fetchArticles(urlString: urlString) { (newsResponse) in
            guard let newsResponse = newsResponse else { return }
            self.newsResponse = newsResponse
            self.table.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse?.articles.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseID, for: indexPath) as! NewsfeedCell
        let article = newsResponse?.articles[indexPath.row]
        //print(article?.author)
        if article?.author == nil || article?.author == "" {
            cell.newsAuthorLabel.text = "Дикань Игорь"
        } else {
            cell.newsAuthorLabel.text = article?.author
        }
        cell.newsTitleLabel.text = article?.title
        cell.newsDateLabel.text = article?.publishedAt
        cell.countShapeLabel.text = String(Int.random(in: 1...20))
        return cell
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailXIB" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! NewsDetailViewController
                let article = newsResponse?.articles[indexPath.row]
                detailVC.detailTitle = article?.title ?? "Заголовок"
                detailVC.detailAuthor = article?.author ?? "Дикань Игорь"
                detailVC.detailDate = article?.publishedAt ?? "1970-01-01"
                detailVC.detailText = article?.description ?? "Детальное описание"
            }
        }
    }

}