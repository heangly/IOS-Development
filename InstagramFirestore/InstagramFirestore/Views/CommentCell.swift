//
//  CommentCell.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/25/21.
//

import UIKit

class CommentCell: UICollectionViewCell {
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 40 / 2
        return iv
    }()

    private let commentLabel: UILabel = {
        let lb = UILabel()
        let attributeString = NSMutableAttributedString(string: "joker ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributeString.append(NSAttributedString(string: "Some test comment for now...", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        lb.attributedText = attributeString
        return lb
    }()


    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
      
        let allSubViews = [profileImageView, commentLabel]
        
        allSubViews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let contraints = [
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            commentLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            commentLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
        ]

        NSLayoutConstraint.activate(contraints)
    }



}
