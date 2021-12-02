//
//  ScrDetailViewController.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import UIKit

protocol ScrDetailPresentableListener: AnyObject {
    func detachScrDetail()
}

final class ScrDetailViewController: UIViewController, ScrDetailPresentable, ScrDetailViewControllable {

    weak var listener: ScrDetailPresentableListener?
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ScrDetailViewController.storyboard"
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.backgroundColor = .white
        
        title = "요소수 상세"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "chevron.backward",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            ),
            style: .plain,
            target: self,
            action: #selector(close)
        )
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func close() {
        listener?.detachScrDetail()
    }
}
