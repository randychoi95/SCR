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
        return indicatorView
    }()
    
    func start() {
        indicatorView.startAnimating()
    }
}
