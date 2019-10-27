//
//  AboutViewModels.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

struct AboutItemViewModel {
    let itemTitle: String
    let itemBody: String
}

struct AboutViewModel {
    let appIcon: UIImage?
    let appName: String
    let appDescription: String
    let aboutItems: [AboutItemViewModel]
}
