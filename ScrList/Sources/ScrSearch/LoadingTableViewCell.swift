//
//  LoadingTableViewCell.swift
//  SCR
//
//  Created by 최제환 on 2021/12/14.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    func start() {
        print("CJHLOG: call start!")
        indicatorView.startAnimating()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 50),
            indicatorView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
