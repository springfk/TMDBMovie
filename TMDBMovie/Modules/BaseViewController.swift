//
//  BaseViewController.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import Foundation
import UIKit

struct ViewController {
    struct Base{}
}

protocol DataLoadedProtocol: AnyObject {
    associatedtype ModelType
    func updateData(model: ModelType)
}

extension ViewController.Base {
    
    class Root: UIViewController {
        
        
        var pageTitle: String? {
            didSet {
                title = pageTitle
            }
        }
        
        var showBackButton : Bool = true
        
        private lazy var activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            return indicator
        }()
        
        private lazy var viewSpacer: UIView = {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isHidden = true
            
            return view
        }()
        private lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fillProportionally
            stackView.spacing = 16
            stackView.isHidden = true
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                
            ])
            setupNavigation()
        }
        
        private func setupNavigation() {
            if showBackButton {
                if self.navigationController?.viewControllers.count ?? 0 > 1 {
                    let backButton = UIBarButtonItem(image: Icons.back, style: .plain, target: self, action: #selector(backButtonTapped))
                    backButton.tintColor = .darkGray
                    navigationItem.leftBarButtonItem = backButton
                } else if self.navigationController?.viewControllers.count ?? 0 == 1 {
                    ///can Set dismiss action but in our app no need to set it because the list is main view
                    ///
                    ///this part handle some view that has no navigation view controller to goes back to previous
                    //                    let backButton = UIBarButtonItem(image: Icons.close, style: .plain, target: self, action: #selector(dismissButtonTapped))
                    //                    navigationItem.leftBarButtonItem = backButton
                    
                } else {
                    let backButton = UIBarButtonItem(image: Icons.back, style: .plain, target: self, action: #selector(backButtonTapped))
                    navigationItem.leftBarButtonItem = backButton
                    
                }
            }
        }
        
        public func showLoading(_ isLoading: Bool) {
            if isLoading {
                if activityIndicator.superview == nil {
                    view.addSubview(activityIndicator)
                    NSLayoutConstraint.activate([
                        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                    ])
                }
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
        
        @objc func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
        
        
        @objc func dismissButtonTapped() {
            navigationController?.dismiss(animated: true)
        }
        
    }
}
