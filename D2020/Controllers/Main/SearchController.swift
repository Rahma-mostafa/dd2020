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
    var result: [MyStores.Datum] = []
    
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
        if foundResult {
            return result.count
        } else {
            return searchHistory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if foundResult {
            return getStoreCell(indexPath: indexPath)
        } else {
            return getSearchCell(indexPath: indexPath)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if foundResult {
            return 110
        } else {
            return 52
            
        }
    }
    func getSearchCell(indexPath: IndexPath) -> UITableViewCell {
        var cell = resultTbl.cell(type: SearchCell.self, indexPath, register: false)
        var history = searchHistory
        history.reverse()
        cell.model = history[indexPath.row]
        cell.delegate = self
        return cell
    }
    func getStoreCell(indexPath: IndexPath) -> UITableViewCell {
        var cell = resultTbl.cell(type: AfterSelectingCell.self, indexPath)
        if case result[indexPath.row].isShop = true {
            cell.setStyle = .orange
            cell.categoryBtn.setTitle(result[indexPath.row].catName, for: .normal)
        } else {
            if result[indexPath.row].type == 1 {
                cell.setStyle = .red
            } else {
                cell.setStyle = .green
            }
            cell.categoryBtn.setTitle("\(result[indexPath.row].price ?? 0)", for: .normal)
        }
        cell.imageSelected.setImage(url: result[indexPath.row].image)
        cell.titleSelected.text = result[indexPath.row].name
        cell.kmSelected.text = result[indexPath.row].distance
        cell.ratingView.rating = Double(result[indexPath.row].rate ?? 0)
        cell.premiumLogo.isHidden = true
        cell.delegate = self
        cell.shop = result[indexPath.row]
        cell.setup()
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if foundResult {

        } else {
            var history = searchHistory
            history.reverse()
            searchBar.text = history[indexPath.row]
            searchResult()
        }
    }
   
}

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension SearchController: SearchCellDelegate {
    func didRemoveHistory(path: Int) {
        var history = self.searchHistory
        history.remove(at: path)
        self.searchHistory = history
        self.resultTbl.reloadData()
    }
    func reloadHistory() {
        if let search = searchBar.text {
            var history = self.searchHistory
            var canAppend = true
            for item in history {
                if search == item {
                    canAppend = false
                }
            }
            if canAppend {
                if history.count > 2 {
                    history.removeLast()
                }
                history.append(search)
                self.searchHistory = history
            }
            self.resultTbl.reloadData()
        }
    }
    func searchResult() {
        guard let text = searchBar.text else { return }
        ApiManager.instance.paramaters["text"] = text
        ApiManager.instance.connection(.search, type: .get) { (response) in
            let data = try? JSONDecoder().decode(SearchModel.self, from: response ?? Data())
            self.result.removeAll()
            data?.shops?.forEach({ (shop) in
                var shopItem = shop
                shopItem.isShop = true
                self.result.append(shopItem)
            })
            self.result.append(contentsOf: data?.ads ?? [])
            self.handleSearch()
        }
    }
    func handleSearch() {
        if result.count == 0 {
            foundResult = false
        } else {
            foundResult = true
        }
        reloadHistory()
    }
}

extension SearchController: StoreCellDelegate {
    func didSetFavorite(path: Int) {
        var method = ""
        if case result[path].isShop = true {
            method = api(.favorite, [result[path].id ?? 0])
        } else {
            method = api(.adsFavorite, [result[path].id ?? 0])
        }
        ApiManager.instance.connection(method, type: .post) {(response) in
            
        }
    }
}
