//
//  AuthPlugin.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Moya

protocol AuthorizedTargetType: TargetType {
    var needsAuth: Bool { get }
}

protocol TokenSource {
    var token: String? { get }
}

struct AuthPlugin: PluginType {
    let tokenClosure: () -> String?

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard
            let token = self.tokenClosure(),
            let target = target as? AuthorizedTargetType,
            target.needsAuth
        else {
            return request
        }

        var request = request
        request.addValue("Token " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
