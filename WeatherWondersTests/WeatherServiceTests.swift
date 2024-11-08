//
//  WeatherServiceTests.swift
//  WeatherWondersTests
//
//  Created by Seher Ayesha on 01/11/2024.
//

import XCTest
@testable import WeatherWonders

class WeatherServiceTests: XCTestCase {
    var weatherService: WeatherService!
    //The exclamation mark (!) indicates that it is an implicitly unwrapped optional, meaning it can be nil but is expected to have a value by the time it is used.

    override func setUp() {
        //This method is called before each test method is executed. It is used to set up any necessary state or objects for the tests.
        super.setUp()
        weatherService = WeatherService()
    }

    override func tearDown() {
        
        //Override func tearDown(): This method is called after each test method has finished executing. It is used to clean up any state or objects that were set up in setUp().
        weatherService = nil
        super.tearDown()
    }

    func testFetchWeatherForValidCity() {
        let expectation = self.expectation(description: "Fetch weather for valid city")

        //This creates an expectation for an asynchronous operation. It allows the test to wait until a certain condition is met. The description is used for clarity in test results.
        
        weatherService.fetchWeather(for: "London") { response in
            XCTAssertNotNil(response, "Response should not be nil for a valid city.")
            XCTAssertEqual(response?.location.name, "London", "The location name should be London.")
            expectation.fulfill()
            //expectation.fulfill(): This signals that the expectation has been met, indicating that the asynchronous operation has completed successfully.
        }

        waitForExpectations(timeout: 5, handler: nil)
        //waitForExpectations(timeout: 5, handler: nil): This line tells the test to wait for the expectation to be fulfilled, with a maximum wait time of 5 seconds. If the expectation is not fulfilled within this time, the test will fail.
    }

    func testFetchWeatherForInvalidCity() {
        let expectation = self.expectation(description: "Fetch weather for invalid city")
        weatherService.fetchWeather(for: "InvalidCity123") { response in
            XCTAssertNil(response, "Response should be nil for an invalid city.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
