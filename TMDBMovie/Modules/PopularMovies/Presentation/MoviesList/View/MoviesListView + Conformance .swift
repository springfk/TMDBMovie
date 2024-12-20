//
//  MoviesListView + Conformance .swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import UIKit
import Foundation

extension MoviesListViewRoot: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListViewCell", for: indexPath) as! MoviesListViewCell
        let MoviesVM = viewModel.items[indexPath.row]
        cell.bind(viewModel: MoviesVM)
        cell.backgroundColor = Colors.backgroundColor
        cell.selectionStyle = .none
        let margin = cell.layoutMargins.left
        cell.separatorInset = .init(top: 0, left: margin + 64, bottom: 0, right: 0)
         return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(atIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row + 1 == viewModel.items.count else {
            return
        }
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            viewModel.search(query: searchText, loadingMore: true) {[weak self] _,_  in
                self?.tableView.reloadData()
            }
        } else {
            viewModel.loadMoreItemIfNeeded {[weak tableView, weak self] _ , error in
                guard error == nil else {
                    self?.presentAlert(for:error!)
                    return
                }
                tableView?.reloadData()
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension MoviesListViewRoot: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText, loadingMore: false) {[weak self] _,_  in
            self?.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.search(query: "", loadingMore: false, completion: {[weak self] _,_  in self?.tableView.reloadData() }) // resets to allMovies
    }
}
