//
//  ScrDetailInteractor.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import InventoryEntity

protocol ScrDetailRouting: ViewableRouting {
    
}

protocol ScrDetailPresentable: Presentable {
    var listener: ScrDetailPresentableListener? { get set }
    
    func update(model: InventoryModel)
}

public protocol ScrDetailListener: AnyObject {
    func detachScrDetail()
}

protocol ScrDetailInteractorDependency {
    var inventoryModel: InventoryModel { get }
}

final class ScrDetailInteractor: PresentableInteractor<ScrDetailPresentable>, ScrDetailInteractable, ScrDetailPresentableListener {

    weak var router: ScrDetailRouting?
    weak var listener: ScrDetailListener?

    private let dependency: ScrDetailInteractorDependency
    
    init(
        presenter: ScrDetailPresentable,
        dependency: ScrDetailInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.update(model: dependency.inventoryModel)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func detachScrDetail() {
        listener?.detachScrDetail()
    }
    
}
