//
//  UserDetailsConfigurator.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 23.10.2021.
//

import UIKit

final class UserDetailsConfigurator {

    static let shared = UserDetailsConfigurator()

    private init() {}

    func confugure(with viewController: UserDetailsViewController) {
        let viewController = viewController
        let presenter = UserDetailsPresenter()
        let interactor = UserDetailsInteractor()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
