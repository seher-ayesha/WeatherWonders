//
//  WeatherView.swift
//  WeatherWonders
//
//  Created by Seher Ayesha on 01/11/2024.
//

import SwiftUI

struct WeatherView: View {
    @State private var city: String = ""
    @State private var weatherResponse: WeatherResponse?
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showWeatherDetailSegment: Bool = false
    
    var weatherService: WeatherService

    var body: some View {
        VStack {
            // Title
            Text("Weather Wonders")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.top, 40)

            SearchBar(text: $city)
                .padding(.horizontal)
                .accessibilityIdentifier("SearchBar")

            Button(action: {
                if city.isEmpty {
                    alertMessage = "Please enter a city name."
                    showAlert = true
                    self.showWeatherDetailSegment = false
                } else {
                    withAnimation(nil){
                        fetchWeather()
                    }
                }
            }) {
                Text("Get Weather")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.teal]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
            .padding(.top)
            .accessibilityIdentifier("Get Weather")
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                    .padding()
                    .animation(nil)
            } else if let weather = weatherResponse{
               
                if showWeatherDetailSegment {
                    VStack {
                        Text("\(weather.location.name), \(weather.location.region), \(weather.location.country)")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .padding(.top)
                            .accessibilityIdentifier("WeatherInfo")

                        Text("\(weather.current.temp_c, specifier: "%.1f")°C")
                            .font(.system(size: 72))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .accessibilityIdentifier("TemperatureLabel")

                        Text(weather.current.condition.text)
                            .font(.title3)
                            .foregroundColor(.gray)
                            .accessibilityIdentifier("ConditionLabel")

                        AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .accessibilityIdentifier("WeatherIcon")
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding()
                }
                
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea(edges: .bottom)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }

    private func fetchWeather() {
        isLoading = true
        weatherService.fetchWeather(for: city) { response in
            DispatchQueue.main.async {
                if let response = response {
                    self.weatherResponse = response
                    self.alertMessage = ""
                    self.showAlert = false
                    self.showWeatherDetailSegment = true
                } else {
                    self.alertMessage = "Invalid city name. Please try again."
                    self.showAlert = true
                    self.showWeatherDetailSegment = false
                }
                self.isLoading = false
            }
        }
    }
}


// Provide a default WeatherService instance for previews
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherService: WeatherService())
    }
}
