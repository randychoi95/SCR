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

protocol ScrSearchRouting: ViewableRouting {
    
}

protocol ScrSearchPresentable: Presentable {
    var listener: ScrSearchPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol ScrSearchListener: AnyObject {
    func attachScrDetail()
}

protocol ScrSearchInteractorDependency {
    var scrRepository: ScrRepository { get }
}

final class ScrSearchInteractor: PresentableInteractor<ScrSearchPresentable>, ScrSearchInteractable, ScrSearchPresentableListener {

    weak var router: ScrSearchRouting?
    weak var listener: ScrSearchListener?

    private let dependency: ScrSearchInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: ScrSearchPresentable,
        dependency: ScrSearchInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.scrRepository.scrList
            .sink { models in
                print("CJHLOG: models = \(models)")
                print("CJHLGO: count is \(models.count)")
            }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapNext() {
        listener?.attachScrDetail()
    }
}
