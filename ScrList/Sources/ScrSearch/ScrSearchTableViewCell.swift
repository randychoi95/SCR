//
//  ScrSearchTableViewCell.swift
//  SCR
//
//  Created by 최제환 on 2021/12/13.
//

import UIKit

class ScrSearchTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let addrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        label.textColor = .systemGray2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(addrLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            addrLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            addrLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            addrLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            addrLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    func setTableViewCell(_ name: String, _ addr: String) {
        nameLabel.text = name
        addrLabel.text = addr
    }
}
