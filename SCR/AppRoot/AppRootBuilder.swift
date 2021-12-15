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
import NetworkImp
import InventoryRepository
import RIBsUtil

protocol AppRootDependency: Dependency {
    
}

final class AppRootComponent: Component<AppRootDependency>, ScrSearchDependency {
    
    var inventoryRepository: InventoryRepository?
    
    private let rootViewController: AppRootViewControllable
    
    init(
        dependency: AppRootDependency,
        rootViewController: AppRootViewControllable,
        inventoryRepository: InventoryRepository
    ) {
        self.inventoryRepository = inventoryRepository
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
        
        let network = NetworkImp(session: URLSession.shared)
        
        let inventoryRepository = InventoryRepositoryImp(
            network: network,
            baseURL: "https://api.odcloud.kr/api/uws/v1/inventory",
            query: ["page": "1", "perPage": "20", "serviceKey":"9PAc6aMn2DC3xdA7rYZn71Hxr3mT9V5E4qnnakQkwj44zVNrPfV%2FVLVnDsnf30wrZZ%2BD%2FS%2BWRTNinP7J8lMjeQ%3D%3D"],
            header: ["Content-Type":"application/json", "charset":"UTF-8"]
        )
        inventoryRepository.fetchScrList()
        
        let component = AppRootComponent(
            dependency: dependency,
            rootViewController: viewController,
            inventoryRepository: inventoryRepository
        )
        
        let interactor = AppRootInteractor(
            presenter: viewController,
            inventoryRepository: inventoryRepository
        )
        
        let scrSearchBuilder = ScrSearchBuilder(dependency: component)
        
        return AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            scrSearchBuildable: scrSearchBuilder
        )
    }
}
