//
//  ScrSearchBuilder.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import ScrUI
import ScrRepository

public protocol ScrSearchDependency: Dependency {
    var scrRepository: ScrRepository { get }
}

final class ScrSearchComponent: Component<ScrSearchDependency>, ScrSearchInteractorDependency {
    var scrRepository: ScrRepository { dependency.scrRepository }
}

// MARK: - Builder

public protocol ScrSearchBuildable: Buildable {
    func build(withListener listener: ScrSearchListener) -> ViewableRouting
}

public final class ScrSearchBuilder: Builder<ScrSearchDependency>, ScrSearchBuildable {

    public override init(dependency: ScrSearchDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: ScrSearchListener) -> ViewableRouting {
        let component = ScrSearchComponent(dependency: dependency)
        let viewController = ScrSearchViewController()
        let interactor = ScrSearchInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return ScrSearchRouter(interactor: interactor, viewController: viewController)
    }
}
