//
// Copyright © 2024 Dawn Health.
// All Rights Reserved.

import ComposableArchitecture
import XCTest

@testable import TCASharedStateNil

final class TCASharedStateNilTests: XCTestCase {

    @MainActor
    func test_resetButtonTapped() async throws {
        @Shared(.sharedValue) var test = "test"

        let store = TestStore(initialState: .init()) {
            ContentFeature()
        }

        await store.send(\.view.resetButtonTapped) {
            $0.sharedValue = nil /// <--- This fails the value is still "test"
        }
    }

    @MainActor
    func test_testButtonTapped() async throws {
        @Shared(.sharedValue) var test = nil

        let store = TestStore(initialState: .init()) {
            ContentFeature()
        }

        await store.send(\.view.testButtonTapped) {
            $0.sharedValue = "Hello, world!"
        }
    }

}
