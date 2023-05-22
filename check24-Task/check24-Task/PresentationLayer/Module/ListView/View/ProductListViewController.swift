//
//  ProductListViewController.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation
import UIKit

class ProductListViewController:UIViewController {
    
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:ProductListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.getAllProductList()
    }
    
    init(viewModel: ProductListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    init(){}
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ProductTableViewCell.self)
        tableView.register(ProductDisableTableViewCell.self)
        //        tableView.register(ProductListHeaderView.self)
        //        tableView.register(ProductListFooterView.self)
        // tableView.refreshControl = refreshControl
    }
    
    
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
}
