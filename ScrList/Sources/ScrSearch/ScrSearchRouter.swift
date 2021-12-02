//
//  ScrSearchRouter.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs

protocol ScrSearchInteractable: Interactable {
    var router: ScrSearchRouting? { get set }
    var listener: ScrSearchListener? { get set }
}

protocol ScrSearchViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ScrSearchRouter: ViewableRouter<ScrSearchInteractable, ScrSearchViewControllable>, ScrSearchRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ScrSearchInteractable, viewController: ScrSearchViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
