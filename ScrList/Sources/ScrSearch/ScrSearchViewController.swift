//
//  ScrSearchViewController.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import UIKit
import ScrUI
import InventoryEntity

protocol ScrSearchPresentableListener: AnyObject {
    func didSelectItem(at: Int)
    func paging()
}

final class ScrSearchViewController: UIViewController, ScrSearchPresentable, ScrSearchViewControllable {
    
    weak var listener: ScrSearchPresentableListener?
    
    private var models: [InventoryModel] = []
    private var isPaging: Bool = false
    private var hasNextPage: Bool = false
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ScrSearchTableViewCell.self)
        tableView.register(cellType: LoadingTableViewCell.self)
        tableView.rowHeight = 60
        tableView.separatorInset = .zero
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        title = "요소수 조회"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            ),
            style: .plain,
            target: self,
            action: nil
        )
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func update(model: [InventoryModel]) {
        self.models = model
        print("CJHLOG: update count = \(self.models.count)")
        
        self.isPaging = false
        
        self.tableView.reloadData()
        
    }
}

extension ScrSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.models.count
        } else if section == 1 && isPaging {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ScrSearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            cell.setTitle(self.models[indexPath.row].name)
            
            return cell
        } else {
            let cell: LoadingTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.start()
            return cell
        }
    }
}

extension ScrSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didSelectItem(at: indexPath.row)
    }
}

extension ScrSearchViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) {
            if isPaging == false {
                print("1")
                isPaging = true
                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
                print("2")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.listener?.paging()
                }
                
            }
        }
    }
}
