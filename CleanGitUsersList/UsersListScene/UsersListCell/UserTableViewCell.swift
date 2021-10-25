//
//  UserTableViewCell.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 21.10.2021.
//

import UIKit

protocol UserCellDisplayLogic: AnyObject {

    func displayUserImage(viewModel: UserCell.ShowUserCell.ViewModel)
    func displayDefaultImage()
}

class UserTableViewCell: UITableViewCell {

    private var userImageView: UIImageView!
    private var activityIndicator: UIActivityIndicatorView!
    private var nameLabel: UILabel!
    private var idLabel: UILabel!
    private var userImageURL = ""

    var interactor: UserCellBusinessLogic?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        UserCellConfigurator.shared.confugure(with: self)
        let viewWidht = frame.width
        let standartIndent: CGFloat = 12

        userImageView = UIImageView(frame: CGRect(x: standartIndent, y: standartIndent, width: viewWidht/4, height: viewWidht/4))
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 8

        activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame.size = CGSize(width: 20, height: 20)
        activityIndicator.center = CGPoint(x: standartIndent + viewWidht/8, y: standartIndent + viewWidht/8)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.style = .large

        nameLabel = UILabel(frame: CGRect(x: standartIndent * 2 + viewWidht/4,
                                          y: standartIndent,
                                          width: viewWidht - viewWidht/4 - standartIndent * 2,
                                          height: viewWidht/8))
        idLabel = UILabel(frame: CGRect(x: standartIndent * 2 + viewWidht/4,
                                        y: standartIndent + viewWidht/8,
                                        width: viewWidht - viewWidht/4 - standartIndent * 2,
                                        height: viewWidht/8))

        [nameLabel, idLabel].forEach { label in
            label?.font = UIFont(name: "Noteworthy Bold" , size: 20)
        }
        [userImageView, activityIndicator, nameLabel, idLabel].forEach{addSubview($0)}
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(name: String, id: String, imageUrl: String) {
        interactor?.showUserImage(request: UserCell.ShowUserCell.Request(imageUrl: imageUrl))
        nameLabel.text = name
        idLabel.text = id
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        activityIndicator.startAnimating()
        userImageView.isHidden = true
    }
}

extension UserTableViewCell: UserCellDisplayLogic {
    func displayDefaultImage() {
        userImageView.isHidden = false
        activityIndicator.stopAnimating()
        userImageView.image = UIImage(systemName: "nosign")
    }


    func displayUserImage(viewModel: UserCell.ShowUserCell.ViewModel) {
        DispatchQueue.main.async {
            self.userImageView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.userImageView.image = UIImage(data: viewModel.imageData)
        }
    }
}
