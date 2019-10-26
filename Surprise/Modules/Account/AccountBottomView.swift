//
//  AccountBottomView.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

final class AccountBottomView: UIView {
    @IBOutlet var logoutButton: UIButton! {
        didSet {
            self.logoutButton.layer.cornerRadius = 10
            self.logoutButton.layer.masksToBounds = true
            UIColor(named: "logoutButton").map {
                let image = UIImage.imageWith(color: $0)
                self.logoutButton.setBackgroundImage(image, for: .normal)
            }
        }
    }

    @IBAction func didTapLogoutButton() {
    }
}
