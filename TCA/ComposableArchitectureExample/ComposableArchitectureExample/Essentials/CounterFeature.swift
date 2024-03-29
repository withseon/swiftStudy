//
//  CounterFeature.swift
//  ComposableArchitectureExample
//
//  Created by 정인선 on 3/15/24.
//

import ComposableArchitecture
import Foundation

// Reducer프로토콜 준수를 위한 매크로
@Reducer
struct CounterFeature {
    // swiftUI에서 관찰하기 위한 매크로
    @ObservableState
    // 작업을 수행하는 데 필요한 상태를 보유
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    // 사용자가 기능에서 수행할 수 있는 모든 작업
    enum Action {
        case decrementButtonTapped
        case incrementButtenTapped
        case factButtonTapped
        case factResponese(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID { case timer }
    
    // body 내 Reducer 내부 나열
    // 작업에 따라 상태를 변화시키고 외부 작업의 결과를 반환하는 Reducer
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .incrementButtenTapped:
                state.fact = nil
                state.count += 1
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                // .run: 비동기 처리 핸들러
                // [count = state.count]: 클로저 캡처 리스트.          
                // 🛑 Mutable capture of 'inout' parameter 'state' is not allowed in concurrently-executing code

                return .run { [count = state.count] send in
                    // numberapi.com를 사용하여 현재 개수에 대한 사실을 가져옴 (외부)
//                    let (data, _) = try await URLSession.shared
//                      .data(from: URL(string: "http://numbersapi.com/\(count)")!)
//                    let fact = String(decoding: data, as: UTF8.self)
                    try await send(.factResponese(self.numberFact.fetch(count)))
                }
                
            case let .factResponese(fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        for await _ in self.clock.timer(interval: .seconds(1)) {
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer)
                }
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
            }
        }
    }
}
