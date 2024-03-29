//
//  UserCellModels.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 23.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum UserCell {

    enum ShowUserCell {
        struct Request {
            let imageUrl: String
        }
        struct Response {
            let imageData: Data
        }
        struct ViewModel {
            let imageData: Data
        }
    }
}
