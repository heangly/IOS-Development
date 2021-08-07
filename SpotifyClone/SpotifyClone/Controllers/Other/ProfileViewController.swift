//
//  ProfileViewController.swift
//  SpotifyClone
//
//  Created by Heang Ly on 8/4/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        APICaller.shared.getCurrentUserProfile { result in
            switch result {
            case.success(let model):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }



}
