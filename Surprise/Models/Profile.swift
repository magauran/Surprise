//
//  Profile.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

struct Profile: Equatable {
    let firstName: String
    let lastName: String
    let email: String
    let avatarURL: URL
}

extension Profile: Decodable {
    enum CodingKeys: String, CodingKey {
        case rootKey = "data"
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "avatar"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .rootKey)
        self.firstName = try nestedContainer.decode(String.self, forKey: .firstName)
        self.lastName = try nestedContainer.decode(String.self, forKey: .lastName)
        self.email = try nestedContainer.decode(String.self, forKey: .email)
        self.avatarURL = try nestedContainer.decode(URL.self, forKey: .avatarURL)
    }
}
