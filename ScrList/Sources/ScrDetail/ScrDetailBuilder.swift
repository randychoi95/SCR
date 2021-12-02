//
//  ScrDetailBuilder.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs

public protocol ScrDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ScrDetailComponent: Component<ScrDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol ScrDetailBuildable: Buildable {
    func build(withListener listener: ScrDetailListener) -> ViewableRouting
}

public final class ScrDetailBuilder: Builder<ScrDetailDependency>, ScrDetailBuildable {

    public override init(dependency: ScrDetailDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: ScrDetailListener) -> ViewableRouting {
        let component = ScrDetailComponent(dependency: dependency)
        let viewController = ScrDetailViewController()
        let interactor = ScrDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return ScrDetailRouter(interactor: interactor, viewController: viewController)
    }
}
