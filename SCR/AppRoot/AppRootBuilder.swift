//
//  AppRootBuilder.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import UIKit
import ScrUI
import ScrSearch
import ScrDetail

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency>, ScrSearchDependency,ScrDetailDependency {
    private let rootViewController: AppRootViewControllable
    
    init(
        dependency: AppRootDependency,
        rootViewController: AppRootViewControllable
    ) {
        self.rootViewController = rootViewController
        
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = callViewControllerFromStoryboard(sb: "AppRootViewController", ids: "AppRootViewController") as! AppRootViewController
        let component = AppRootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        let interactor = AppRootInteractor(presenter: viewController)
        
        let scrSearchBuilder = ScrSearchBuilder(dependency: component)
        let scrDetailBuilder = ScrDetailBuilder(dependency: component)
        
        return AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            scrSearchBuildable: scrSearchBuilder,
            scrDetailBuildable: scrDetailBuilder
        )
    }
}
