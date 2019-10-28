//
//  AccountService.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Moya

protocol AccountService {
    func fetchAccount(then handler: @escaping (Result<Profile, MoyaError>) -> Void)
    func changeName(_ name: String, then handler: @escaping (Result<Profile, MoyaError>) -> Void)
}

struct AccountServiceImpl {
    init(provider: MoyaProvider<AccountAPI>) {
        self.provider = provider
    }

    private let provider: MoyaProvider<AccountAPI>
}

extension AccountServiceImpl: AccountService {
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

    func changeName(_ name: String, then handler: @escaping (Result<Profile, MoyaError>) -> Void) {
        self.provider.request(.changeName(name: name)) { result in
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
