
//
//  MovieDetailSceneRoot.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403.
//  Copyright © 2024 TMDBMovie. All rights reserved.
//
import UIKit
import Foundation

extension MovieDetailSceneRoot {
    
    //MARK: - UI Setup
    func addUIElementToDetailView() {
        
        view.addSubview(movieImageView)
        view.addSubview(stackView)
        view.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            movieImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            movieImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            
            stackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            bookmarkButton.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            bookmarkButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 44),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func setupPageNavigation() {
        self.pageTitle = "Movie's Detail"
    }
    
    func setupUI() {
        setupPageNavigation()
        addUIElementToDetailView()
    }
    
    func updateContent() {
        
        movieNameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        descriptionLabel.text = viewModel.description ?? "No details available"
        updateBookmarkButton()
        viewModel.loadImage {[weak movieImageView] image in
            movieImageView?.image = image
        }
    }
    
    
    // MARK: - Actions
    
    @objc func setBookMark() {
        //handle saving in hashMAp
        var isBookmarked = viewModel.isBookmarked
        isBookmarked.toggle()
        viewModel.bookmark(isBookmarked)
        updateBookmarkButton()
    }
    
    func updateBookmarkButton() {
        let isBookmarked = viewModel.isBookmarked
        if isBookmarked {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
}

