//
//  UserCellInteractor.swift
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

protocol UserCellBusinessLogic {

    func showUserImage(request: UserCell.ShowUserCell.Request)
}

class UserCellInteractor: UserCellBusinessLogic {
    
    var presenter: UserCellPresentationLogic?

    func showUserImage(request: UserCell.ShowUserCell.Request) {

        if let url = URL(string: request.imageUrl) {
            ImageDataLoader.shared.loadImage(url: url) {result in
                do {
                    let imageData = try result.get()
                    let response = UserCell.ShowUserCell.Response(imageData: imageData)
                    self.presenter?.presentUserImage(response: response)
                } catch {
                    self.presenter?.presentDefaultImage()
                }
            }
        }
    }
}