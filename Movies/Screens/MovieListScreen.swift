//
//  MovieListScreen.swift
//  Movies
//
//  Created by Ravikanth on 6/10/23.
//

import SwiftUI
import SwiftData

enum Sheets: Identifiable {
    case addMovie
    case addActor
    case showFilter
    
    var id: Int {
        hashValue
    }
}

struct FilterSelectionConfig {
    var movieTitle: String = ""
    var numberOfReviews: Int?
    var numberOfActors: Int?
    var genre: Genre = .action
    var filter: FilterOption = .none
}

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var actorName: String = ""
    @State private var activeSheet: Sheets?
    
    @State private var filterSelectionConfig = FilterSelectionConfig()
    @State private var filterOption: FilterOption = .none
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                
                Button("Filter") {
                    activeSheet = .showFilter
                }
            }
            
            Button("Clear Filters") {
                    filterSelectionConfig = FilterSelectionConfig()
            }
            
            MovieListView(filterOption: filterSelectionConfig.filter)
            
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .padding()
        .toolbar(content: {
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    activeSheet = .addActor
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    activeSheet = .addMovie
                }
            }
        })
        .sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
                case .addMovie:
                    NavigationStack {
                        AddMovieScreen()
                    }
                case .addActor:
                    Text("Add Actor")
                        .font(.largeTitle)
                    
                    TextField("Actor name", text: $actorName)
                        .textFieldStyle(.roundedBorder)
                        .presentationDetents([.fraction(0.25)])
                        .padding()
                    
                    Button("Save") {
                        saveActor()
                        self.activeSheet = nil
                    }
                case .showFilter:
                    FilterSelectionScreen(filterSelectionConfig: $filterSelectionConfig)
            }
        })
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self, Review.self, Actor.self], inMemory: true)
    }
}
