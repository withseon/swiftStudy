//
//  ComposableArchitectureExampleTests.swift
//  ComposableArchitectureExampleTests
//
//  Created by 정인선 on 3/15/24.
//

import ComposableArchitecture
import XCTest
@testable import ComposableArchitectureExample

@MainActor
final class ComposableArchitectureExampleTests: XCTestCase {
    
    // 증가, 감소에 대한 테스트
    func testCounter() async {
        // 테스트 스토어 생성
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtenTapped) {
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
    
    func testTimer() async {
        // dependency 추가 후
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number"}
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        await store.receive(\.factResponese) {
            $0.isLoading = false
            $0.fact = "0 is a good number"
        }
    }
    
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.tab1.incrementButtenTapped) {
            $0.tab1.count = 1
        }
    }
    
    func testAddFlow() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            // 0부터 시작하여 순차적으로 증가하는 ID를 생성
            $0.uuid = .incrementing
        }
        
        // + 버튼을 탭할 때
        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(
                    contact: Contact(id: UUID(0), name: "")
                )
            )
        }
        
        // 텍스트 필드에 "Blob Jr."을 입력했을 때
        await store.send(\.destination.addContact.setName, "Blob Jr.") {
            $0.destination?.addContact?.contact.name = "Blob Jr."
        }
        
        // 저장 버튼 탭 후 상태가 즉시 변경되지 않기 때문에 후행 클로저 사용 X
        await store.send(\.destination.addContact.saveButtonTapped)
        
        // 저장 버튼 탭 후 수신
        await store.receive(
            \.destination.addContact.delegate.saveContact,
             Contact(id: UUID(0), name: "Blob Jr.")
        ) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
        }
        
        // destination 종료
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
    }
    
    func testAddFlow_NonExhaustive() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        // non-exhaustive 스타일로 테스트하기 위해 설정
        store.exhaustivity = .off
        
        // 상태 변경을 주장할 필요가 없기 때문에 후행 클로저 X
        await store.send(.addButtonTapped)
        await store.send(\.destination.addContact.setName, "Blob Jr.")
        await store.send(\.destination.addContact.saveButtonTapped)
        // 저장 버튼 탭 후 수신 스킵
        await store.skipReceivedActions()
        
        // 최종적으로 contact가 추가되고 destination이 종료됨을 확인
        store.assert {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
            $0.destination = nil
        }
    }
    
    func testDeleteContact() async {
        let store = TestStore(
            initialState: ContactsFeature.State(
                contacts: [
                    Contact(id: UUID(0), name: "Blob"),
                    Contact(id: UUID(1), name: "Blob Jr.")
                ]
            )
        ) {
            ContactsFeature()
        }
        
        // 두번째 연락처 삭제 후 alert 상태 변경
        await store.send(.deleteButtonTapped(id: UUID(1))) {
            $0.destination = .alert(.deleteConfirmation(id: UUID(1)))
        }
        
        // 삭제 확인
        await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
            $0.contacts.remove(id: UUID(1))
            $0.destination = nil
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
