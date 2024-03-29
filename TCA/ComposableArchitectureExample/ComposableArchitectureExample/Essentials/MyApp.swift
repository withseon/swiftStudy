//
//  MyApp.swift
//  ComposableArchitectureExample
//
//  Created by 정인선 on 3/23/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct MyApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: MyApp.store)
        }
    }
}
