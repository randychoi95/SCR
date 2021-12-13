//
//  ScrSearchRouter.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import InventoryEntity
import ScrDetail
import RIBsUtil

protocol ScrSearchInteractable: Interactable, ScrDetailListener {
    var router: ScrSearchRouting? { get set }
    var listener: ScrSearchListener? { get set }
}

protocol ScrSearchViewControllable: ViewControllable {
    
}

final class ScrSearchRouter: ViewableRouter<ScrSearchInteractable, ScrSearchViewControllable>, ScrSearchRouting {
    
    private let scrDetailBuildable: ScrDetailBuildable
    private var scrDetailRouting: Routing?
    
    init(
        interactor: ScrSearchInteractable,
        viewController: ScrSearchViewControllable,
        scrDetailBuildable: ScrDetailBuildable
    ) {
        self.scrDetailBuildable = scrDetailBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachScrDetail(models: InventoryModel) {
        if scrDetailRouting != nil {
            return
        }
        
        let router = scrDetailBuildable.build(withListener: interactor, model: models)
        attachChild(router)
        scrDetailRouting = router
        viewController.pushVieController(router.viewControllable, animated: true)
    }
    
    func detachScrDetail() {
        guard let router = scrDetailRouting else {
            return
        }
        
        viewControllable.popViewController(animated: true)
        detachChild(router)
        scrDetailRouting = nil
    }
}
