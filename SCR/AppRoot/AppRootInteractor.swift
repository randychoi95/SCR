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
    
    func searchScrList(page: Int) {
        print("CJHLOG: page = \(page)")
        let network = NetworkImp(session: URLSession.shared)
        inventoryRepository = InventoryRepositoryImp(
            network: network,
            baseURL: "https://api.odcloud.kr/api/uws/v1/inventory",
            query: ["page": "2", "perPage": "20", "serviceKey":"9PAc6aMn2DC3xdA7rYZn71Hxr3mT9V5E4qnnakQkwj44zVNrPfV%2FVLVnDsnf30wrZZ%2BD%2FS%2BWRTNinP7J8lMjeQ%3D%3D"],
            header: ["Content-Type":"application/json", "charset":"UTF-8"]
        )
        
//        inventoryRepository.inventoryList
//            .sink { model in
//                print("CJHLOG: new Model = \(model)")
//            }.store(in: &cancellables)
    }
}
