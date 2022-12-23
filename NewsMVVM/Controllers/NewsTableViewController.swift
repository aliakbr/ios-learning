//
//  NewsTableViewController.swift
//  NewsMVVM
//
//  Created by Ali Akbar on 23/12/22.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    private var articleListViewModel : ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        populateNews()
    }
    
    private func populateNews() {
        let resource = Resource<ArticleRespose>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=bf31140fd4e345129855d66a7a521d53")!
        )
        
        URLRequest.load(resource: resource).subscribe(onNext: { articleResponse in
            let articles = articleResponse.articles
            self.articleListViewModel = ArticleListViewModel(articles)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        .disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articleListViewModel = articleListViewModel else {
            return 0
        }
        
        return articleListViewModel.articleViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let cellData = self.articleListViewModel?.ArticleAt(indexPath.row)
        
        cellData?.title.asDriver(onErrorJustReturn: "no title found").drive(onNext: { titleText in
            cell.titleLabel.text = titleText
        }).disposed(by: disposeBag)
        
        cellData?.description.asDriver(onErrorJustReturn: "no description found").drive(onNext: { descriptionText in
            cell.descriptionLabel.text = descriptionText
        }).disposed(by: disposeBag)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
