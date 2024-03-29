//
//  AddContactFeature.swift
//  ComposableArchitectureExample
//
//  Created by 정인선 on 3/23/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AddContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        // 하위 기능이 원하는 작업을 상위 기능에 알릴 수 있도록 함
        enum Delegate: Equatable {
            case saveContact(Contact)
        }
    }
    
    // sheet 창을 닫기 위한 종속성 추가
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
                
            // 어떤 논리도 수행 X
            // 부모가 행동을 듣고 delegate에 따라 대응
            case .delegate:
                return .none
                
            case .saveButtonTapped:
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }
                
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}
