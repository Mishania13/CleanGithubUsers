//
//  UsersListPresenter.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UsersListPresentationLogic {

    func presentUsersList(response: UsersList.ShowUsersList.Response)
    func presentError(error: Error)
}

class UsersListPresenter: UsersListPresentationLogic {

    weak var viewController: UsersListDisplayLogic?

    func presentUsersList(response: UsersList.ShowUsersList.Response)
    {
        var viewModel = UsersList.ShowUsersList.ViewModel(usersViewModel: [])
        for item in response.users {
            let name = "User: \(item.login?.capitalized ?? "missed")"
            let id = "ID: \(item.id ?? 0)"
            let imageUrl = item.avatarUrl ?? ""
            viewModel.usersViewModel.append(UsersList.ShowUsersList.ViewModel.DisplayUser(name: name,
                                                                                          id: id,
                                                                                          imageUrl: imageUrl))
        }
        viewController?.displayUsersList(viewModel: viewModel)
    }
    
    func presentError(error: Error) {
        viewController?.displayAlert(with: error.localizedDescription)
    }
}