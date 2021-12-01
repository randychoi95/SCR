//
//  AppComponent.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import Foundation
import ModernRIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
}
