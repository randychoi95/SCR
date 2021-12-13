//
//  ScrDetailRouter.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs

protocol ScrDetailInteractable: Interactable {
    var router: ScrDetailRouting? { get set }
    var listener: ScrDetailListener? { get set }
}

protocol ScrDetailViewControllable: ViewControllable {
    
}

final class ScrDetailRouter: ViewableRouter<ScrDetailInteractable, ScrDetailViewControllable>, ScrDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ScrDetailInteractable, viewController: ScrDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
