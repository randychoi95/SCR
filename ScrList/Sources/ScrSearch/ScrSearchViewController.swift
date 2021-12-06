//
//  ScrSearchViewController.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import UIKit

protocol ScrSearchPresentableListener: AnyObject {
    func didTapNext()
}

final class ScrSearchViewController: UIViewController, ScrSearchPresentable, ScrSearchViewControllable {
    
    weak var listener: ScrSearchPresentableListener?
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ScrSearchViewController.storyboard"
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("next", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        return button
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
        view.addSubview(button)
        view.backgroundColor = .white
        
//        title = "요소수 조회"
        
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
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func action() {
        listener?.didTapNext()
    }
}
