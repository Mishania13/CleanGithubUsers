//
//  UserListDataModel.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 21.10.2021.
//

struct UserListDataModel: Codable {

    let login: String?
    let id: Int?
    let avatarUrl: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case login, id, url
        case avatarUrl = "avatar_url"
    }
}
