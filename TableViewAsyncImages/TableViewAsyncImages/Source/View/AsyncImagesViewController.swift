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
    private var viewModel = AsyncImagesViewModel(aboutCanada: AboutCanada(title: "", rows: nil))
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        additionalSafeAreaInsets = .zero
        setupViewHierarchy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            viewModel.loadJSON(onCompletion: { success in
                if success {
                    self.updateData()
                    LoadingOverlay.shared.hideOverlayView(onCompletion: {
                        // do nothing
                    })
                } else {
                    let alert = UIAlertController(title: "Alert!", message: "Failed to load data.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        } else {
            print("Internet connection FAILED")
            LoadingOverlay.shared.hideOverlayView(onCompletion: {
                let alert = UIAlertController(title: "No internet Connection", message: "Please connect to internet and pull to RELOAD", preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            })
            
        }
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
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            self.viewModel.loadJSON { success in
                if success {
                    self.updateData()
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                    }
                } else {
                    let alert = UIAlertController(title: "Alert!", message: "Failed to load data.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No internet Connection", message: "Please connect to internet", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

// MARK: Tableview data source

extension AsyncImagesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.asyncImagesTableViewCellIdentifier) as? AsyncImagesTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.articleImageView.imageFromServerURL(urlString: viewModel.aboutCanada.rows?[indexPath.row].imageHref ?? "", PlaceHolderImage: UIImage(named: Constants.placeholderImageName)!)
        cell.titleLabel.text = viewModel.aboutCanada.rows?[indexPath.row].title
        cell.descriptionLabel.text = viewModel.aboutCanada.rows?[indexPath.row].description
        return cell
    }
}
