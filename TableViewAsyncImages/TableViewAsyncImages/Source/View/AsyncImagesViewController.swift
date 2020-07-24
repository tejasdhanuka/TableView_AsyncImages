//
//  AsyncImagesViewController.swift
//  TableViewAsyncImages
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/24.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import UIKit

class AsyncImagesViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    private var viewModel = AsyncImagesViewModel()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        additionalSafeAreaInsets = .zero
        setupViewHierarchy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadJSON(onSuccess: {
            self.updateData()
        })
    }
    
    // MARK: - Setup
    
    private func setupViewHierarchy() {
        tableView = UITableView()
        refreshControl = UIRefreshControl()
        
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        setupTableView()
        setupRefreshControl()
        
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delaysContentTouches = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(AsyncImagesTableViewCell.self, forCellReuseIdentifier: Constants.asyncImagesTableViewCellIdentifier)
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    // MARK: - Custom functions
    
    private func updateData() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.viewModel.aboutCanada.title
            self.tableView.reloadData()
        }
    }
    
    @objc func reloadData() {
        self.viewModel.loadJSON {
            self.updateData()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: Tableview data source

extension AsyncImagesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.asyncImagesTableViewCellIdentifier) as? AsyncImagesTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.articleImageView.imageFromServerURL(urlString: viewModel.aboutCanada.rows?[indexPath.row].imageHref ?? "", PlaceHolderImage: UIImage(named: "apple") ?? UIImage())
        cell.titleLabel.text = viewModel.aboutCanada.rows?[indexPath.row].title
        cell.descriptionLabel.text = viewModel.aboutCanada.rows?[indexPath.row].description
        return cell
    }
}
