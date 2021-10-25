//
//  UsersListConfigurator.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 22.10.2021.
//

import UIKit

final class UsersListConfigurator {

    static let shared = UsersListConfigurator()

    private init() {}

    func confugure(with viewController: UsersListViewController) {
        let viewController = viewController
        let presenter = UsersListPresenter()
        let router = UsersListRouter()
        let interactor = UsersListInteractor()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
