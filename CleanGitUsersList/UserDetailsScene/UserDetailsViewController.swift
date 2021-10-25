//
//  UserDetailsViewController.swift
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

protocol UserDetailsDisplayLogic: AnyObject {

    func displayUserDetails(viewModel: UserDetails.ShowDetails.ViewModel)
    func displayAlert(with text: String)
}

class UserDetailsViewController: UIViewController {

    private var tableView = UITableView()
    private var userImageView = UIImageView()
    private var activityInicator = UIActivityIndicatorView()

    var userDetails: UserInfoModel!
    var userInfo: [String] = []

    var userUrl: String!
    var userImageUrl: String!
    var interactor: UserDetailsBusinessLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        UserDetailsConfigurator.shared.confugure(with: self)
        [userImageView, tableView, activityInicator].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureViews()
        showUserDetails()
        
    }

    private func showUserDetails() {
        let request = UserDetails.ShowDetails.Request(userUrl: userUrl, userImageUrl: userImageUrl)
        interactor?.showDetails(request: request)
    }

    private func layoutViews() {
        let imageViewConstraints = [
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            userImageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        let activitiIndicatorConstraints = [
            activityInicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityInicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityInicator.widthAnchor.constraint(equalToConstant: 25),
            activityInicator.heightAnchor.constraint(equalToConstant: 25)

        ]
        [imageViewConstraints, tableViewConstraints, activitiIndicatorConstraints].forEach{NSLayoutConstraint.activate($0)}
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground

        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        activityInicator.hidesWhenStopped = true
        activityInicator.startAnimating()

        layoutViews()
    }

}

extension UserDetailsViewController: UserDetailsDisplayLogic {

    func displayUserDetails(viewModel: UserDetails.ShowDetails.ViewModel) {
        userInfo = viewModel.userInfo
        DispatchQueue.main.async {
            self.userImageView.image = UIImage(data: viewModel.userImageData) ?? UIImage(systemName: "nosign")
            self.title = viewModel.userName
            self.activityInicator.stopAnimating()
            self.tableView.reloadData()
        }
    }

    func displayAlert(with text: String) {
        DispatchQueue.main.async {
            self.activityInicator.stopAnimating()
            self.showAlert(title: "Error", message: text)
        }
    }
}


//MARK: TableView

extension UserDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userInfo[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Noteworthy Light", size: 20)
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        return cell
    }
}
