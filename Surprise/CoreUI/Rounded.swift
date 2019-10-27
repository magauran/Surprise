//
//  Rounded.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

@propertyWrapper
public struct Rounded<T: UIView> {
    public var wrappedValue: T? {
        didSet {
            self.round(cornerRadius: self.cornerRadius)
        }
    }

    private var cornerRadius: CGFloat

    public init(_ cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        self.wrappedValue = nil
        self.round(cornerRadius: cornerRadius)
    }

    func round(cornerRadius: CGFloat) {
        self.wrappedValue?.layer.cornerRadius = cornerRadius
    }
}
