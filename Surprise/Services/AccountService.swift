//
//  AccountService.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Moya

struct AccountService {
    init(tokenSource: TokenSource) {
        self.provider = MoyaProvider<AccountAPI>(
            plugins: [
                AuthPlugin(tokenClosure: { tokenSource.token })
            ]
        )
    }

    private let provider: MoyaProvider<AccountAPI>

    func fetchAccount(then handler: (Result<Profile, Error>) -> Void) {
        self.provider.request(.profile) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let profile = try filteredResponse.map(Profile.self)
                    print(profile)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
