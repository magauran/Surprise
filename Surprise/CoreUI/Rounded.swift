//
//  Rounded.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

@propertyWrapper
struct Rounded<T: UIView> {
    var wrappedValue: T? {
        didSet { self.round(self.cornerRadius) }
    }

    private var cornerRadius: CGFloat

    init(_ cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }

    private func round(_ cornerRadius: CGFloat) {
        self.wrappedValue?.layer.cornerRadius = cornerRadius
    }
}
