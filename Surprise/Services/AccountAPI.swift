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
        switch self {
        case .profile:
            let json = Self.mockProfileJSON
            return Data(json.utf8)
        case .changeName:
            let json = Self.mockProfileJSON
            return Data(json.utf8)
        }
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

extension AccountAPI {
    private static let mockProfileJSON =
    """
    {
      "data": {
        "id": 26132,
        "email": "alexey@salangin.com",
        "phone": null,
        "first_name": "Alexey",
        "last_name": "Salangin",
        "nickname": "id26132",
        "avatar": "https://app.surprizeme.ru/media/users/26132/1znu4cjtcau.jpg",
        "is_superuser": false,
        "is_password_set": false,
        "is_social_set": false,
        "is_partner": false,
        "is_sales": true,
        "permissions": [],
        "client": {
          "name": "Free personal plan (test@user.com)",
          "max_downloads": 30,
          "downloads": 0
        },
        "locale": "en",
        "created_at": 1570804084,
        "favorite_products": [],
        "is_hijacked": false
      }
    }
    """
}
