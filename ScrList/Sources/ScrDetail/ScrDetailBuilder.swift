//
//  ScrDetailBuilder.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import InventoryEntity

public protocol ScrDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ScrDetailComponent: Component<ScrDetailDependency>, ScrDetailInteractorDependency {
    
    var inventoryModel: InventoryModel
    
    init(
        dependency: ScrDetailDependency,
        model: InventoryModel
    ) {
        self.inventoryModel = model
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

public protocol ScrDetailBuildable: Buildable {
    func build(withListener listener: ScrDetailListener, model: InventoryModel) -> ViewableRouting
}

public final class ScrDetailBuilder: Builder<ScrDetailDependency>, ScrDetailBuildable {
    
    public override init(dependency: ScrDetailDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ScrDetailListener, model: InventoryModel) -> ViewableRouting {
        let component = ScrDetailComponent(dependency: dependency, model: model)
        let viewController = ScrDetailViewController()
        let interactor = ScrDetailInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ScrDetailRouter(interactor: interactor, viewController: viewController)
    }
}
