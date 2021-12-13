//
//  AppRootRouter.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import ScrSearch
import ScrDetail
import ScrUI
import RIBsUtil

protocol AppRootInteractable: Interactable, ScrSearchListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private var navigationControllable: NavigationControllerable?
    
    private let scrSearchBuildable: ScrSearchBuildable
    private var scrSearchRouting: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        scrSearchBuildable: ScrSearchBuildable
    ) {
        self.scrSearchBuildable = scrSearchBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachScrSearch() {
        if scrSearchRouting != nil {
            return
        }
        
        let router = scrSearchBuildable.build(withListener: interactor)
        let navigation = NavigationControllerable(root: router.viewControllable)
        
        self.navigationControllable = navigation
        viewController.present(viewController: navigation)
        self.scrSearchRouting = router
        attachChild(router)
    }
}
