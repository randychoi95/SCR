//
//  ScrSearchBuilder.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import ScrUI

public protocol ScrSearchDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ScrSearchComponent: Component<ScrSearchDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let interactor = ScrSearchInteractor(presenter: viewController)
        interactor.listener = listener
        return ScrSearchRouter(interactor: interactor, viewController: viewController)
    }
}
