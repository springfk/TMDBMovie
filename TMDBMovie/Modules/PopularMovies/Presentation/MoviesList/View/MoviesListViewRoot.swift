//
//  MoviesListViewRoot.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import UIKit
import Foundation


class MoviesListViewRoot: ViewController.Base.Root {
    
    var viewModel: MoviesListViewModelProtocol
    var filteredMovies: [NowPlayingMovieEntity] = [] // Assuming `Movie` is your data model for movies
    var isSearching = false
    
    //MARK: - init
    init(viewModel: MoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search movies..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.sectionHeaderHeight = 0
        table.sectionFooterHeight = 0
        table.alwaysBounceVertical = false
        table.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        table.register(MoviesListViewCell.self, forCellReuseIdentifier: "MoviesListViewCell")
        table.separatorStyle = .none
        table.layer.cornerRadius = 8
        table.clipsToBounds = true
        
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        debugPrint("Page Got Deinited")
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = Colors.backgroundColor
//        tableView.backgroundColor = Colors.backgroundColor
//        setupUI()
//        viewModel.loadInitialItems {[weak self] didLoad, error in
//            self?.showLoading(true)
//            if let error = error {
//                self?.presentAlert(for: error)
//                return
//            }
//            self?.tableView.reloadData()
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.backgroundColor
        tableView.backgroundColor = Colors.backgroundColor
        setupUI()
        showLoading(true)

        viewModel.loadInitialItems { [weak self] didLoad, error in
            DispatchQueue.main.async {
                self?.showLoading(false)
                if let error = error {
                    self?.presentAlert(for: error)
                    return
                }

                if didLoad {
                    self?.tableView.reloadData()
                }
            }
        }
    }

}
