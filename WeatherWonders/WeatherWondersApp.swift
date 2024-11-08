//
//  WeatherWondersApp.swift
//  WeatherWonders
//
//  Created by Seher Ayesha on 01/11/2024.
//

import SwiftUI

@main
struct WeatherWondersApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(weatherService: WeatherService())
        }
    }
}
