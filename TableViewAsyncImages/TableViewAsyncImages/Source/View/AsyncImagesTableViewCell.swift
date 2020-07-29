//
//  AsyncImagesTableViewCell.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/13.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import UIKit

final class AsyncImagesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        return separator
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(articleImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(separatorView)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            articleImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
            articleImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            articleImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8.0),
            descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
            descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2.0),
            separatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
            separatorView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
