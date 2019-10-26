//
//  AccountViewModels.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

typealias MenuViewModel = [MenuSectionViewModel]

struct MenuSectionViewModel {
    let items: [MenuItemViewModel]
}

struct MenuItemViewModel {
    let title: String
}