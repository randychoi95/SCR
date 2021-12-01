//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/01.
//

import UIKit
import ModernRIBs

public extension Builder {
    func callViewControllerFromStoryboard(sb: String, ids: String) -> UIViewController {
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: ids)
    }
}
