//
//  MoviesApp.swift
//  Movies
//
//  Created by Ravikanth on 6/10/23.
//

import SwiftUI
import SwiftData
@main
struct MoviesApp: App {
   
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }.modelContainer(for: [Movie.self])
    }
}
