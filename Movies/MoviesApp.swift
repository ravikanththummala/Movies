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
    
    let container:ModelContainer
    init() {
        do {
            container = try ModelContainer(for: Movie.self, migrationPlan: MovieMigrationPlan.self, configurations: ModelConfiguration(for: Movie.self))
        }
        catch{
          fatalError("Could not initialize the container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }.modelContainer(container)
    }
}
