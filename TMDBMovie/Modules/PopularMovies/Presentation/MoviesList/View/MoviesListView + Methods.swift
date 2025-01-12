//
//  MoviesListView + Methods.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import UIKit
import Foundation

extension MoviesListViewRoot {
    
//MARK: - UI Setup
    
    func addTableView() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupPageNavigation() {
        self.pageTitle = NSLocalizedString("TMDB Movies", comment: "")
    }
    
    func setupUI() {
        setupPageNavigation()
        addTableView()
    }
    
    func presentAlert(for error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
}
