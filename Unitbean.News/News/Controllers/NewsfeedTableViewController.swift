//
//  NewsfeedTableViewController.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 19.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {
    
    let dateConversionService = DateConversionService.shared
    let newsFetcher = NewsFetcher.shared
    var newsResponse: NewsResponse? = nil
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseID)
        
        newsFetcher.getNews { (newsResponse) in
            guard let newsResponse = newsResponse else { return }
            self.newsResponse = newsResponse
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
        return newsResponse?.articles.count ?? 0
        //return 3
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
