//
//  ReviewListView.swift
//  Movies
//
//  Created by Ravikanth  on 10/7/23.
//

import SwiftUI

struct ReviewListView: View {
    @Environment(\.modelContext) private var context
    
    let movie: Movie
    
    
    private func deleteReview(indexSet: IndexSet) {
        
        indexSet.forEach { index in
            let movie = movie.reviews[index]
            context.delete(movie)
            
            do {
                movie.movie?.reviews.remove(at: index)
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    var body: some View {
        List {
            ForEach(movie.reviews) { review  in
                VStack(alignment: .leading){
                    Text(review.subject)
                        .font(.headline)
                    Text(review.body)
                        .font(.callout)
                        .foregroundStyle(Color.gray.opacity(0.3))
                }
            }.onDelete(perform: deleteReview)
        }
    }
}

//#Preview {
//    ReviewListView(reviews: [])
//        .modelContainer(for:[Review.self,Movie.self])
//}
