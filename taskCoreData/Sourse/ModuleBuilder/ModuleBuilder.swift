//
//  ModuleBuilder.swift
//  taskCoreData
//
//  Created by admin on 18.04.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func createMainView() -> UIViewController
    static func createDetailView(model: User) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    static func createMainView() -> UIViewController {
        let view = ListUsersView()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createDetailView(model: User) -> UIViewController {
        let view = DetailView()
        let presenter = DetailPresenter(view: view, user: model)
        view.presenter = presenter
        return view
    }
}
