//
//  ComposableArchitectureExampleApp.swift
//  ComposableArchitectureExample
//
//  Created by 정인선 on 3/15/24.
//

import SwiftUI
import ComposableArchitecture

//@main
struct ComposableArchitectureExampleApp: App {
    static let store = Store(initialState: CounterFeature.State()) { CounterFeature()._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: ComposableArchitectureExampleApp.store)
        }
    }
}
