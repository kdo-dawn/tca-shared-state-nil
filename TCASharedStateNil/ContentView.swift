//
// Copyright © 2024 Dawn Health.
// All Rights Reserved.


import ComposableArchitecture
import SwiftUI

@ViewAction(for: ContentFeature.self)
struct ContentView: View {

    @State var store: StoreOf<ContentFeature>

    init(store: StoreOf<ContentFeature>) {
        self.store = store
    }

    var body: some View {
        VStack {
            Button("Tap to set shared state value") {
                send(.testButtonTapped)
            }

            Button("Tap to reset") {
                send(.resetButtonTapped)
            }
        }
        .padding()
    }
}

extension PersistenceReaderKey where Self == PersistenceKeyDefault<AppStorageKey<String?>> {
    public static var sharedValue: Self {
        PersistenceKeyDefault(.appStorage("sharedValue"), nil)
    }
}

@Reducer
public struct ContentFeature {

    @ObservableState
    public struct State: Equatable {
        @Shared(.sharedValue) var sharedValue
    }

    public enum Action: ViewAction {
        case view(View)

        @CasePathable
        public enum View {
            case testButtonTapped
            case resetButtonTapped
        }
    }

    public init() { }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.resetButtonTapped):
                state.sharedValue = nil
                print(state.sharedValue)
                return .none

            case .view(.testButtonTapped):
                state.sharedValue = "Hello, world!"
                print(state.sharedValue)
                return .none
            }
        }
    }
}


#Preview {
    ContentView(store: .init(initialState: ContentFeature.State()) {
        ContentFeature()
    })
}
