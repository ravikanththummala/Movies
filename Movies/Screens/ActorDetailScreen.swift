//
//  ActorDetailScreen.swift
//  Movies
//
//  Created by Ravikanth  on 10/9/23.
//

import SwiftUI
import SwiftData

struct ActorDetailScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private  var selectedMovies:Set<Movie> = []
    let actor:Actor

    var body: some View {
        VStack {
            MovieSelectionView(selectedActor: $selectedMovies)
                .onAppear {
                    selectedMovies = Set(actor.movies)
                }
        }.onChange(of: selectedMovies, { oldValue, newValue in
            actor.movies = Array(selectedMovies)
            context.insert(actor)
        })
        .navigationTitle(actor.name)
    }
}
