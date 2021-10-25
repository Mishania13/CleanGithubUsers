//
//  UserCellConfigurator.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 23.10.2021.
//

import UIKit

import UIKit

final class UserCellConfigurator {

    static let shared = UserCellConfigurator()

    private init() {}

    func confugure(with tableViewCell: UserTableViewCell) {
        let viewController = tableViewCell
        let interactor = UserCellInteractor()
        let presenter = UserCellPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
