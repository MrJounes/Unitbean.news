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
        
//        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.tableView.frame.width, height: 40)))
//        button.setTitle("Загрузить еще", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .white
//        button.addTarget(self, action: #selector(moreButtonClicked(_:)), for: .touchUpInside)
//        self.tableView.tableFooterView = button
        
    }
    
    @objc func moreButtonClicked(_ sender: UIButton) {
        print("More button clicked, fetch more data!")
        
    }
    
    private func getDate(dateString: String?) -> String {
        guard let dateString = dateString else { return "1970-01-01"}
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = Locale(identifier: "ru_RU")
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "dd MMMM 'в' HH:mm"
        return formatter.string(from: date!)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse?.articles.count ?? 1
        //return 3
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
        cell.newsDateLabel.text = self.getDate(dateString: article?.publishedAt)
        cell.countShapeLabel.text = String(Int.random(in: 1...20))
        cell.newsImageView.set(urlString: article?.urlToImage ?? "https://болгарка.укр/app_default/media/eshop/no_photo.jpg")
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
                if article?.author == nil || article?.author == "" {
                    detailVC.detailAuthor = "Дикань Игорь"
                } else {
                    detailVC.detailAuthor = article?.author as! String
                }
                detailVC.detailDate = self.getDate(dateString: article?.publishedAt ?? "1970-01-01")
                detailVC.detailText = article?.description ?? "Детальное описание"
                detailVC.detailImage = article?.urlToImage ?? "https://болгарка.укр/app_default/media/eshop/no_photo.jpg"
            }
        }
    }

}
