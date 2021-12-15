//
//  AppRootInteractor.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import Foundation
import InventoryRepository
import NetworkImp
import Combine

protocol AppRootRouting: ViewableRouting {
    func attachScrSearch()
}

protocol AppRootPresentable: Presentable {
    var listener: AppRootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AppRootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener {
    
    weak var router: AppRootRouting?
    weak var listener: AppRootListener?
    
    private var inventoryRepository: InventoryRepository
    
    private var cancellables: Set<AnyCancellable>
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: AppRootPresentable,
        inventoryRepository: InventoryRepository
    ) {
        self.inventoryRepository = inventoryRepository
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        router?.attachScrSearch()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
}
