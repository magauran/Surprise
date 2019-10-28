//
//  AccountServiceTests.swift
//  SurpriseTests
//
//  Created by Alexey Salangin on 10/28/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

@testable import Surprise_Me
import XCTest
import Moya

// swiftlint:disable force_unwrapping
class AccountServiceTests: XCTestCase {
    func testFetchAccountSuccess() {
        let provider = MoyaProvider<AccountAPI>(
            stubClosure: MoyaProvider.immediatelyStub
        )
        let accountService = AccountServiceImpl(provider: provider)

        let expectation = self.expectation(description: "FetchAccount")

        let expectedProfile = Profile(
            firstName: "Alexey",
            lastName: "Salangin",
            email: "alexey@salangin.com",
            avatarURL: URL(string: "https://app.surprizeme.ru/media/users/26132/1znu4cjtcau.jpg")!
        )

        var realProfile: Profile?

        accountService.fetchAccount { result in
            switch result {
            case .success(let profile):
                realProfile = profile
            case .failure:
                realProfile = nil
            }

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)

        XCTAssertEqual(expectedProfile, realProfile)
    }

    func testChangeNameSuccess() {
        let provider = MoyaProvider<AccountAPI>(
            stubClosure: MoyaProvider.immediatelyStub
        )
        let accountService = AccountServiceImpl(provider: provider)

        let expectation = self.expectation(description: "ChangeName")

        let expectedProfile = Profile(
            firstName: "Alexey",
            lastName: "Salangin",
            email: "alexey@salangin.com",
            avatarURL: URL(string: "https://app.surprizeme.ru/media/users/26132/1znu4cjtcau.jpg")!
        )

        var realProfile: Profile?

        accountService.changeName("") { result in
            switch result {
            case .success(let profile):
                realProfile = profile
            case .failure:
                realProfile = nil
            }

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)

        XCTAssertEqual(expectedProfile, realProfile)
    }

    func testFetchAccountFailed() {
        let customEndpointClosure = { (target: AccountAPI) -> Endpoint in
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(401, Data()) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }

        let provider = MoyaProvider<AccountAPI>(
            endpointClosure: customEndpointClosure
        )
        let accountService = AccountServiceImpl(provider: provider)

        let expectation = self.expectation(description: "ChangeName")

        var realProfile: Profile?
        var realError: MoyaError?

        accountService.fetchAccount { result in
            switch result {
            case .success(let profile):
                realProfile = profile
                realError = nil
            case .failure(let error):
                realProfile = nil
                realError = error
            }

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)

        XCTAssertEqual(realProfile, nil)
        XCTAssert(realError != nil)
    }

    func testChangeNameFailed() {
        let customEndpointClosure = { (target: AccountAPI) -> Endpoint in
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(401, Data()) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }

        let provider = MoyaProvider<AccountAPI>(
            endpointClosure: customEndpointClosure
        )
        let accountService = AccountServiceImpl(provider: provider)

        let expectation = self.expectation(description: "ChangeName")

        var realProfile: Profile?
        var realError: MoyaError?

        accountService.changeName("") { result in
            switch result {
            case .success(let profile):
                realProfile = profile
                realError = nil
            case .failure(let error):
                realProfile = nil
                realError = error
            }

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)

        XCTAssertEqual(realProfile, nil)
        XCTAssert(realError != nil)
    }
}
