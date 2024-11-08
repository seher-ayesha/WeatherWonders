//
//  WeatherWondersUITests.swift
//  WeatherWondersUITests
//
//  Created by Seher Ayesha on 01/11/2024.
//

import XCTest

class WeatherWondersUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Set up the application
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Clean up after each test
        app.terminate()
        super.tearDown()
    }

    func testInitialUIState() {
        // Check if the title is displayed
        XCTAssertTrue(app.staticTexts["Weather Wonders"].exists, "The title 'Weather Wonders' should be displayed.")

        // Check if the search bar is present
        XCTAssertTrue(app.textFields["SearchBar"].exists, "The search bar should be present.")

        // Check if the button is present
        XCTAssertTrue(app.buttons["Get Weather"].exists, "The 'Get Weather' button should be present.")
    }

    func testFetchWeatherWithEmptyCity() {
        let app = XCUIApplication()
        app.launch()

        // Tap the button without entering a city name
        app.buttons["Get Weather"].tap()

        // Check for the alert
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "An alert should be shown for empty city input.")
        
        // Check the alert message
        let alertMessage = alert.staticTexts["Please enter a city name."]
        XCTAssertTrue(alertMessage.exists, "The alert message should prompt to enter a city name.")

        // Dismiss the alert
        alert.buttons["OK"].tap()
    }

    func testFetchWeatherWithInvalidCity() {
           let app = XCUIApplication()
           app.launch()

           // Enter an invalid city name
           let searchBar = app.textFields["SearchBar"]
           searchBar.tap()
           searchBar.typeText("InvalidCity")

           // Tap the button
           app.buttons["Get Weather"].tap()

           // Check for the alert
           let alert = app.alerts["Error"]
           XCTAssertTrue(alert.waitForExistence(timeout: 5), "An alert should be shown for invalid city input.")
           
           // Check the alert message
           let alertMessage = alert.staticTexts["Invalid city name. Please try again."]
           XCTAssertTrue(alertMessage.exists, "The alert message should indicate the city is invalid.")

           // Dismiss the alert
           alert.buttons["OK"].tap()
       }
   
    func testFetchWeatherWithValidCity() {
        let app = XCUIApplication()
        app.launch()

        // Enter a valid city name (replace with an actual valid city)
        let searchBar = app.textFields["SearchBar"]
        searchBar.tap()
        searchBar.typeText("London") // Replace with a valid city

        // Tap the button
        app.buttons["Get Weather"].tap()

        // Check for the weather info
        let weatherInfo = app.staticTexts["WeatherInfo"]
        XCTAssertTrue(weatherInfo.waitForExistence(timeout: 5), "Weather information should be displayed.")

        // Check for the temperature label
        let temperatureLabel = app.staticTexts["TemperatureLabel"]
        XCTAssertTrue(temperatureLabel.exists, "The temperature label should be displayed.")
    }
}
