//
//  SearchBar.swift
//  WeatherWonders
//
//  Created by Seher Ayesha on 01/11/2024.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.blue)
            TextField("Search your city", text: $text)
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.leading, 5)
        }
        .padding(.horizontal)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
