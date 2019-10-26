//
//  UIStoryboard++.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)
}

extension UIStoryboard {
    func instantiate<ViewController: UIViewController>() -> ViewController {
        let identifier = String(describing: ViewController.self)
        return instantiateViewController(withIdentifier: identifier) as! ViewController
    }
}
