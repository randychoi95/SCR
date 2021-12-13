//
//  ScrSearchInteractor.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import ScrRepository
import Combine
import ScrEntity
import ScrUI
import InventoryRepository
import InventoryEntity
import Foundation
import RIBsUtil

protocol ScrSearchRouting: ViewableRouting {
    func attachScrDetail(models: InventoryModel)
    func detachScrDetail()
}

protocol ScrSearchPresentable: Presentable {
    var listener: ScrSearchPresentableListener? { get set }
    
    func update(model: [InventoryModel])
}

public protocol ScrSearchListener: AnyObject {
    
}

protocol ScrSearchInteractorDependency {
    var scrRepository: ScrRepository { get }
    var inventoryRepository: InventoryRepository { get }
}

final class ScrSearchInteractor: PresentableInteractor<ScrSearchPresentable>, ScrSearchInteractable, ScrSearchPresentableListener {

    weak var router: ScrSearchRouting?
    weak var listener: ScrSearchListener?

    private let dependency: ScrSearchInteractorDependency
    
    private var models: [InventoryModel]
    
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: ScrSearchPresentable,
        dependency: ScrSearchInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        self.models = []
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.scrRepository.scrList
            .sink { models in
                print("CJHLOG: scrRepository models = \(models)")
                print("CJHLOG: scrRepository count is \(models.count)")
            }.store(in: &cancellables)
        
        dependency.inventoryRepository.inventoryList
            .receive(on: DispatchQueue.main)
            .sink { models in
                print("CJHLOG: inventoryRepository models = \(models)")
                print("CJHLOG: inventoryRepository count is \(models.count)")
                self.models = models
                self.presenter.update(model: self.models)
            }.store(in: &cancellables)
        
        
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didSelectItem(at: Int) {
        router?.attachScrDetail(models: self.models[at])
    }
    
    func detachScrDetail() {
        router?.detachScrDetail()
    }
}
