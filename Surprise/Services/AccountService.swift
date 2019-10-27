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

    func fetchAccount(then handler: @escaping (Result<Profile, MoyaError>) -> Void) {
        self.provider.request(.profile) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let profile = try filteredResponse.map(Profile.self)
                    handler(.success(profile))
                } catch let moyaError as MoyaError {
                    handler(.failure(moyaError))
                } catch {
                    handler(.failure(MoyaError.underlying(error, response)))
                }
            case .failure(let error):
                handler(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
}
