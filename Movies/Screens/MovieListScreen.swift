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
    case ShoeFilter
    
    var id:Int {
        hashValue
    }
}

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    //    @Query(filter: #Predicate<Movie> { $0.year > 2021} ) private var movies: [Movie]
    @Query(sort: \Movie.title, order: .reverse) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var actorName:String = ""
    @State private var activeSheet: Sheets?
    @State private var filterOption: FilterOption = .none

    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .firstTextBaseline) {
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                Button("Filter") {
                    activeSheet = .ShoeFilter
                }
            }
       
            MovieListView(filterOption: filterOption)
            
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
                NavigationStack { AddMovieScreen() }
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
            case .ShoeFilter:
                FilterSelectionScreen(filterOption: $filterOption)
            }
        })
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self,Actor.self,Review.self])
    }
}
