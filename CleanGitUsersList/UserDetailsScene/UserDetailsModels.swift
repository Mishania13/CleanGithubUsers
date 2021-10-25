//
//  UserDetailsModels.swift
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

enum UserDetails {

    enum ShowDetails {
        struct Request {
            let userUrl: String
            let userImageUrl: String
        }
        struct Response {
            let userDetails: UserInfoModel?
            let userImageData: Data
        }
        struct ViewModel {
            let userName: String
            let userInfo: [String]
            let userImageData: Data
        }
    }
}