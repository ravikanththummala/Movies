//
//  Movie.swift
//  Movies
//
//  Created by Ravikanth on 6/10/23.
//

import Foundation
import SwiftData

@Model
final class Movie {
    
    var title: String
    var year: Int
    
    @Transient var reviewsCount:Int { reviews.count }
    @Transient var actorsCount:Int { actors.count }


    @Relationship(.unique, inverse: \Review.movie) var reviews:[Review] = []
    
    @Relationship(.unique, inverse: \Actor.movies) var actors:[Actor] = []
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}
