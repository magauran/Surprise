//
//  UITableView++.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

extension UITableView {
    func setAndLayoutTableHeaderView(header: UIView) {
        header.frame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        )
        self.tableHeaderView = header
    }

    func setAndLayoutTableFooterView(footer: UIView) {
        footer.frame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        )
        self.tableFooterView = footer
    }
}
