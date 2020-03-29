//
//  NotificationsVC.swift
//  D2020
//
//  Created by Macbook on 3/3/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class SearchController: BaseController {
    
    @IBOutlet weak var resultTbl: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLbl: UILabel!
    
    var searchHistory: [String] {
        get {
            let data = UserDefaults.standard.array(forKey: "SEARCH_HISTORY")
            if let data = data {
                let history = data as? [String] ?? []
                return history
            } else { return [] }
        } set {
            UserDefaults.standard.set(newValue, forKey: "SEARCH_HISTORY")
        }
    }
    var foundResult: Bool = false
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        setup()
    }
    func setup() {
        searchBar.delegate = self
        resultTbl.delegate = self
        resultTbl.dataSource = self
        titleLbl.text = "history.lan".localized
        searchBar.textColor = .textColor
        searchBar.placeholder = "search.lan".localized
    }
}
extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if foundResult {
            return getStoreCell(indexPath: indexPath)
        } else {
            return getSearchCell(indexPath: indexPath)
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !foundResult {
            return 52
        } else {
            return 110
            
        }
    }
    func getSearchCell(indexPath: IndexPath) -> UITableViewCell {
        var cell = resultTbl.cell(type: SearchCell.self, indexPath, register: false)
        var history = searchHistory
        history.reverse()
        cell.model = history[indexPath.row]
        return cell
    }
    func getStoreCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTbl.cell(type: AfterSelectingCell.self, indexPath)
        cell.imageSelected.image = #imageLiteral(resourceName: "jonathan-borba-u7fi6JmYbX8-unsplash")
        cell.titleSelected.text = "store"
        cell.kmSelected.text = "10 km"
        cell.ratingView.rating = 5
        cell.premiumLogo.isHidden = true
        cell.saveButton.setImage(UIImage(named: "save_act"), for: .normal)
        return cell
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension SearchController {
    func reloadHistory() {
        if let search = searchBar.text {
            var history = self.searchHistory
            if history.count > 2 {
                history.removeLast()
            }
            history.append(search)
            self.searchHistory = history
            self.resultTbl.reloadData()
        }
    }
    func searchResult() {
        foundResult = true
        reloadHistory()

    }
}
