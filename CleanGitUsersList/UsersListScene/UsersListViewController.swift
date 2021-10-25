//
//  UsersListViewController.swift
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

protocol UsersListDisplayLogic: AnyObject {
    
    func displayUsersList(viewModel: UsersList.ShowUsersList.ViewModel)
    func displayAlert(with text: String)
}

class UsersListViewController: UITableViewController{

    private var activityInicator = UIActivityIndicatorView()
    private let standartIndent: CGFloat = 12

    var router: UsersListRouterInput?
    var interactor: UsersListBusinessLogic?
    var users: [UsersList.ShowUsersList.ViewModel.DisplayUser] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Git's users"
        configureView()
        UsersListConfigurator.shared.confugure(with: self)
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
        showUsersList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewsPositioner()
    }

    private func showUsersList() {
        interactor?.showUsersList()
    }

    private func configureView() {
        view.addSubview(activityInicator)

        activityInicator.hidesWhenStopped = true
        activityInicator.startAnimating()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    private func viewsPositioner() {
        activityInicator.frame.size = CGSize(width: 25, height: 25)
        activityInicator.center = CGPoint(x: view.frame.width/2,
                                          y: view.frame.height/2)
    }
    //MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let userInfo = users[indexPath.row]
        cell.configure(name: userInfo.name, id: userInfo.id, imageUrl: userInfo.imageUrl)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.width/4 + standartIndent
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.showUserDetailViewController(at: indexPath.row)
    }
}

extension UsersListViewController: UsersListDisplayLogic {

    func displayUsersList(viewModel: UsersList.ShowUsersList.ViewModel) {
        users = viewModel.usersViewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityInicator.stopAnimating()
        }
    }

    func displayAlert(with text: String) {
        showAlert(title: "Error", message: text) {
            DispatchQueue.main.async {
                self.activityInicator.stopAnimating()
            }
        }
    }
}

