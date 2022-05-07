//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Rahul Mayani on 13/07/21.
//

import XCTest

class PokemonTests: XCTestCase {
    
    // MARK: - Variable -
    private let gateway = APIGateway()
    
    // MARK: - Testing Cycle -
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Test Case -
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        gateway.delegate = self
        gateway.getPokemons()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
 
extension PokemonTests: APIGatewayProtocol {
    func getPokResponse(success: Bool, isLoadMore: Bool) {
        XCTAssertTrue(!gateway.dataList.isEmpty)
    }
}
