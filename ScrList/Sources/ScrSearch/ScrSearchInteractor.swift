//
//  ScrSearchInteractor.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs

protocol ScrSearchRouting: ViewableRouting {
    
}

protocol ScrSearchPresentable: Presentable {
    var listener: ScrSearchPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol ScrSearchListener: AnyObject {
    func attachScrDetail()
}

final class ScrSearchInteractor: PresentableInteractor<ScrSearchPresentable>, ScrSearchInteractable, ScrSearchPresentableListener {

    weak var router: ScrSearchRouting?
    weak var listener: ScrSearchListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ScrSearchPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapNext() {
        listener?.attachScrDetail()
    }
}
