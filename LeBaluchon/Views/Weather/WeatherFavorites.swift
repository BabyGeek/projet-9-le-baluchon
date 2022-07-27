//
//  WeatherFavorites.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 27/07/2022.
//

import Foundation
import SwiftUI


extension WeatherView {
    var favorites: some View {
        if #available(iOS 15.0, *) {
            return AnyView(
                ForEach(viewModel.favorites, id: \.self) { weather in
                    WeatherRowView(weather: weather)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                            Button {
                                print("DELETE ME")
                            } label: {
                                Text("Del")
                            }
                            .tint(.red)
                        })
                }
            )
        } else {
            return AnyView(
                ForEach(viewModel.favorites, id: \.self) { weather in
                    WeatherRowView(weather: weather)
                }
                .onDelete(perform: deleteFavorite)
            )
        }
    }
    
    func deleteFavorite(at offsets: IndexSet) {
        viewModel.favorites.remove(atOffsets: offsets)
    }
}

