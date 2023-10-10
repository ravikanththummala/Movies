//
//  MovieSchemaVersions.swift
//  Movies
//
//  Created by Ravikanth  on 10/10/23.
//

import Foundation
import SwiftData

enum MovieSchemav1: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] {
           [Movie.self]
       }
    
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
}

enum MovieSchemav2: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(2, 0, 0)

    static var models: [any PersistentModel.Type] {
           [Movie.self]
       }
    
    @Model
    final class Movie {
        
        @Attribute(.unique) var title: String
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
    
    
    
    
}


enum MovieSchemav3: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(3, 0, 0)

    static var models: [any PersistentModel.Type] {
           [Movie.self]
       }
    
    @Model
    final class Movie {
        
        @Attribute(.unique,originalName: "title") var name: String
        var year: Int
        
        @Transient var reviewsCount:Int { reviews.count }
        @Transient var actorsCount:Int { actors.count }


        @Relationship(.unique, inverse: \Review.movie) var reviews:[Review] = []
        
        @Relationship(.unique, inverse: \Actor.movies) var actors:[Actor] = []
        
        init(name: String, year: Int) {
            self.name = name
            self.year = year
        }
    }
    
    
    
    
}
