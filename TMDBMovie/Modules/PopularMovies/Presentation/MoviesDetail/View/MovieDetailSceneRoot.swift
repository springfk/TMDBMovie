
//
//  MovieDetailSceneRoot.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403.
//  Copyright © 2024 TMDBMovie. All rights reserved.
//
import UIKit
import Foundation


class MovieDetailSceneRoot: ViewController.Base.Root {
    
    var viewModel: MovieDetailViewModelProtocol
    
    //MARK: - init
    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("Page Got Deinited")
    }
    
    // MARK: - UI Components
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.robotoBlack(size: 20).font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.robotoLight(size: 18).font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.robotoLight(size: 15).font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        button.addTarget(self, action: #selector(setBookMark), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, dateLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        setupUI()
        updateContent()
        
    }
}
