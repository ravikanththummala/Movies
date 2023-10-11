//
//  AddMovieScreen.swift
//  Movies
//
//  Created by Ravikanth on 6/10/23.
//

import SwiftUI
import SwiftData

struct AddMovieScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var year: Int?
    @State private var selectedActor:Set<Actor> = []
    @State private var genre:Genre = .action
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace && year != nil && !selectedActor.isEmpty
    }
    
    var body: some View {
        Form {
            Picker("Select Genre", selection: $genre) {
                ForEach(Genre.allCases){ genr in
                    Text(genr.title).tag(genr)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            
            Section("Select Actors"){
                ActorSelectionView(selectedActor: $selectedActor)
            }
            
        }
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                    guard let year = year else { return }
                    
                    let movie = Movie(title: title, year: year,genre: genre)
                    movie.actors = Array(selectedActor)
                    
                    selectedActor.forEach { actor in
                        actor.movies.append(movie)
                        context.insert(actor)
                    }
                    
                    context.insert(movie)
                    
                    dismiss()
                    
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieScreen()
            .modelContainer(for: [Movie.self])
    }
}
