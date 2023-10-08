//
//  MovieListScreen.swift
//  Movies
//
//  Created by Ravikanth on 6/10/23.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var isAddMoviePresented: Bool = false
    @State private var isAddActorPresented: Bool = false
    @State private var actorName:String = ""
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Movies")
                .font(.largeTitle)
            MovieListView(movies: movies)
            
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
            
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    isAddActorPresented = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    isAddMoviePresented = true
                }
            }
        })
        .sheet(isPresented: $isAddMoviePresented, content: {
            NavigationStack {
                AddMovieScreen()
            }
        })
        .sheet(isPresented: $isAddActorPresented, content: {
            Text("Add Actor")
                .font(.largeTitle)
            
            TextField("Actor name", text: $actorName)
                .textFieldStyle(.roundedBorder)
                .presentationDetents([.fraction(0.25)])
                .padding()
            
            
            Button("Save") {
                isAddActorPresented = false
                saveActor()
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
