//
//  MVVMExampleTests.swift
//  MVVMExampleTests
//
//  Created by Rinki Banerjee on 23/11/22.
//

import XCTest
@testable import MVVMExample

class MVVMExampleTests: XCTestCase {
    
    // custom urlsession for mock network calls
      var urlSession: URLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Set url session for mock networking
               let configuration = URLSessionConfiguration.ephemeral
               configuration.protocolClasses = [HttpRequestHelper.self]
               urlSession = URLSession(configuration: configuration)
    }
    func testGetProfile() throws {
          // Profile API. Injected with custom url session for mocking
//        let profileAPI = HttpRequestHelper.GET(urlSession)
//
//          // Set mock data
//          let sampleProfileData = ""
//          let mockData = try JSONEncoder().encode(sampleProfileData)
//
//          // Return data in mock request handler
//        EmployeesServiceProtocol.Protocol = { request in
//              return (HTTPURLResponse(), mockData)
//          }
//
          // Set expectation. Used to test async code.
          let expectation = XCTestExpectation(description: "response")
          
          // Make mock network request to get profile
//          profileAPI.getProfile { user in
//              // Test
//              XCTAssertEqual(user.name, "Yugantar")
//              expectation.fulfill()
//          }
          wait(for: [expectation], timeout: 1)
      }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
