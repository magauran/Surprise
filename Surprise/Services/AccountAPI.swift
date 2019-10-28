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
    case changeName(name: String)
}

extension AccountAPI: AuthorizedTargetType {
    var baseURL: URL { return AppConfig.baseURL }

    var path: String {
        switch self {
        case .profile: return "profile/"
        case .changeName: return "profile/name/"
        }
    }

    var method: Method {
        switch self {
        case .profile: return .get
        case .changeName: return .post
        }
    }

    var sampleData: Data {
        return Data() // TODO: stubbed response
    }

    var task: Task {
        switch self {
        case .profile: return .requestPlain
        case .changeName(let name):
            let changeNameBody = ChangeNameRequestBody(firstName: name)
            return .requestJSONEncodable(changeNameBody)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .profile: return [:]
        case .changeName: return [:]
        }
    }

    var needsAuth: Bool {
        switch self {
        case .profile: return true
        case .changeName: return true
        }
    }
}

struct ChangeNameRequestBody: Encodable {
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
    }
}
