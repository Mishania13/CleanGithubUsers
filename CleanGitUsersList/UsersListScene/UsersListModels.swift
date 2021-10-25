//
//  UsersListModels.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 21.10.2021.
//

import Foundation

enum UsersList {

    enum ShowUsersList {
        struct Response {
            let users: [UserListDataModel]
        }
        struct ViewModel {
            struct DisplayUser {
                let name: String
                let id: String
                let imageUrl: String
            }
            var usersViewModel: [DisplayUser]
        }
    }
}

