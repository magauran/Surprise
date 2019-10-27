//
//  AccountAPI.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Moya

enum AccountAPI {
    case profile
}

extension AccountAPI: AuthorizedTargetType {
    var baseURL: URL { return AppConfig.baseURL }

    var path: String {
        switch self {
        case .profile: return "profile/"
        }
    }

    var method: Method {
        switch self {
        case .profile: return .get
        }
    }

    var sampleData: Data {
        return Data() // TODO: stubbed response
    }

    var task: Task {
        switch self {
        case .profile: return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .profile: return [:]
        }
    }

    var needsAuth: Bool {
        switch self {
        case .profile: return true
        }
    }
}
