//
//  ScrDetailInteractor.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs

protocol ScrDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ScrDetailPresentable: Presentable {
    var listener: ScrDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol ScrDetailListener: AnyObject {
    func detachScrDetail()
}

final class ScrDetailInteractor: PresentableInteractor<ScrDetailPresentable>, ScrDetailInteractable, ScrDetailPresentableListener {

    weak var router: ScrDetailRouting?
    weak var listener: ScrDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ScrDetailPresentable) {
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
    
    func detachScrDetail() {
        listener?.detachScrDetail()
    }
}
