//
//  MovieSelectionView.swift
//  Movies
//
//  Created by Ravikanth  on 10/9/23.
//

import SwiftUI
import SwiftData

struct MovieSelectionView: View {
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Binding var selectedActor:Set<Movie>

    var body: some View {
        List(movies){ movie in
            HStack{
                Image(systemName: selectedActor.contains(movie) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectedActor.contains(movie){
                            selectedActor.insert(movie)
                        }else{
                            selectedActor.remove(movie)
                        }
                    }
                Text(movie.title)
            }
            
        }
    }
}

//#Preview {
//    MovieSelectionView()
//}
