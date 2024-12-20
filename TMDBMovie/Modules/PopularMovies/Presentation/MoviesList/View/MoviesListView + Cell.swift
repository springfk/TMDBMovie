//
//  MoviesListView + Cell.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import Foundation
import UIKit


class MoviesListViewCell : UITableViewCell {
    var indexPath: IndexPath?
    
    var viewModel: MoviesListItemViewModel?
    
    deinit {
        viewModel = nil
    }
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var backView: RoundRectView = {
        let view = RoundRectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 8
        view.backgroundColor = Colors.surfaceColor
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.heightAnchor.constraint(equalToConstant: 80).isActive = true
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
        image.layer.cornerRadius = 40
        return image
    }()
    
    
    lazy var movieTitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.textColor
        label.font = Fonts.robotoBold(size: 18).font
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.textColor
        label.font = Fonts.robotoLight(size: 15).font
        label.textAlignment = .left
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        stackView.addArrangedSubview(movieTitleLabel)
        stackView.addArrangedSubview(dateLabel)
        
        backView.addSubview(iconImageView)
        backView.addSubview(stackView)
        contentView.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            iconImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            
            movieTitleLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = UIImage(named: "placeHolder")
        movieTitleLabel.text = ""
        dateLabel.text = ""
    }
    
    func bind(viewModel vm: MoviesListItemViewModel) {
        viewModel = nil
        viewModel = vm
        movieTitleLabel.text = vm.name
        dateLabel.text = vm.date
        vm.getIconImage(completion: {[weak self] image in
            self?.iconImageView.image = image ?? UIImage(named: "placeHolder")
        })
    }
}
