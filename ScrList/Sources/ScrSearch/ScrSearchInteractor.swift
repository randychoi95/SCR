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
import NetworkImp

protocol ScrSearchRouting: ViewableRouting {
    func attachScrDetail(models: InventoryModel)
    func detachScrDetail()
}

protocol ScrSearchPresentable: Presentable {
    var listener: ScrSearchPresentableListener? { get set }
    
    func update(model: [InventoryModel])
}

public protocol ScrSearchListener: AnyObject {
    func searchScrList(page: Int)
}

protocol ScrSearchInteractorDependency {
    var scrRepository: ScrRepository { get }
    var inventoryRepository: InventoryRepository? { get set }
}

final class ScrSearchInteractor: PresentableInteractor<ScrSearchPresentable>, ScrSearchInteractable, ScrSearchPresentableListener {
    
    weak var router: ScrSearchRouting?
    weak var listener: ScrSearchListener?
    
    private var dependency: ScrSearchInteractorDependency
    
    private var models: [InventoryModel]
    private var totalCount: Int
    private var page: Int
    
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: ScrSearchPresentable,
        dependency: ScrSearchInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        self.models = []
        self.totalCount = 0
        self.page = 0
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.inventoryRepository?.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] model in
                print("model = \(model)")
                guard let self = self else {
                    return
                }
                self.models = model
                self.presenter.update(model: self.models)
            }.store(in: &cancellables)
        
//        dependency.inventoryRepository.totalCount
//            .receive(on: DispatchQueue.main)
//            .sink { totalCount in
//                self.totalCount = totalCount
//            }.store(in: &cancellables)
//
//        dependency.inventoryRepository.page
//            .receive(on: DispatchQueue.main)
//            .sink { page in
//                self.page = page
//            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelectItem(at: Int) {
        router?.attachScrDetail(models: self.models[at])
    }
    
    func detachScrDetail() {
        router?.detachScrDetail()
    }
    
    func paging() {
//        if models.count < totalCount {
        let network = NetworkImp(session: URLSession.shared)
        dependency.inventoryRepository = InventoryRepositoryImp(
            network: network,
            baseURL: "https://api.odcloud.kr/api/uws/v1/inventory",
            query: ["page": "2", "perPage": "20", "serviceKey":"9PAc6aMn2DC3xdA7rYZn71Hxr3mT9V5E4qnnakQkwj44zVNrPfV%2FVLVnDsnf30wrZZ%2BD%2FS%2BWRTNinP7J8lMjeQ%3D%3D"],
            header: ["Content-Type":"application/json", "charset":"UTF-8"]
        )
            dependency.inventoryRepository?.fetch()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in }) { model in
                    print("new Model = \(model)")
                    self.models.append(contentsOf: model)
                    self.presenter.update(model: self.models)
                }.store(in: &cancellables)
//        }
    }
}
