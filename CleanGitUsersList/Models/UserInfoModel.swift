//
//  UserDetaisModel.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 23.10.2021.
//

struct UserInfoModel: Codable {

    let login: String?
    let htmlUrl: String?
    let name: String?
    let company: String?
    let location: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let createdAt: String?

}
