//
//  MoviesApp.swift
//  Movies
//
//  Created by Ravikanth on 6/10/23.
//

import SwiftUI

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
