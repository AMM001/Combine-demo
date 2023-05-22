//
//  ProductListViewController.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation
import UIKit
import Combine

class ProductListViewController:UIViewController {
    
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private var viewModel:ProductListViewModelProtocol?
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        bindData()
        self.viewModel?.getAllProductList(category: .all)
        
        segmentedControl.addTarget(self, action: #selector(self.segmentTaped(_:)), for: .valueChanged)
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        
    }
    
    func setup(viewModel: ProductListViewModelProtocol = ProductListViewModel()) {
        self.viewModel = viewModel
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ProductTableViewCell.self)
        tableView.register(ProductDisableTableViewCell.self)
        //        tableView.register(ProductListHeaderView.self)
        //        tableView.register(ProductListFooterView.self)
        tableView.refreshControl = refreshControl
    }
    
    func bindData() {
        self.viewModel?.displayedProductList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    @objc private func segmentTaped(_ sender: UISegmentedControl) {
        guard let category = ProductCategoryType(rawValue: sender.selectedSegmentIndex) else {
            fatalError("no corresponding category type for the index selected by segment control")
        }
        viewModel?.getAllProductList(category: category)
    }
    
    @objc private func refreshData(_ sender: Any) {
        guard let category = ProductCategoryType(rawValue: segmentedControl.selectedSegmentIndex) else {
            fatalError("no corresponding category type for the index selected by segment control")
        }
        viewModel?.getAllProductList(category: category)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.displayedProductList.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let product = viewModel?.displayedProductList.value[indexPath.row] {
            if (product.available) {
                let cell: ProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configureCell(item: product)
                cell.selectionStyle = .none
                return cell
            } else {
                let cell: ProductDisableTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configureCell(item: product)
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = viewModel?.displayedProductList.value[indexPath.row] {
            self.viewModel?.navigateToDetailsView(viewController: self , products: product)
        }
    }
}
