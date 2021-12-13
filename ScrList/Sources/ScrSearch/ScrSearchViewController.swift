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
}

final class ScrSearchViewController: UIViewController, ScrSearchPresentable, ScrSearchViewControllable {
    
    weak var listener: ScrSearchPresentableListener?
    
    private var models: [InventoryModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ScrSearchTableViewCell.self)
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
        
        self.tableView.reloadData()
    }
}

extension ScrSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScrSearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.setTitle(self.models[indexPath.row].name)
        
        return cell
    }
}

extension ScrSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didSelectItem(at: indexPath.row)
    }
}
