//
//  MovieMigrationPlan.swift
//  Movies
//
//  Created by Ravikanth  on 10/10/23.
//

import Foundation
import SwiftData

enum MovieMigrationPlan: SchemaMigrationPlan {
    
    static var schemas: [any VersionedSchema.Type] {
        [MovieSchemav1.self,MovieSchemav2.self]
    }
    
    static var stages: [MigrationStage]{
        [migrateV1ToV2]
    }
    static let migrateV1ToV2  = MigrationStage.custom(fromVersion: MovieSchemav1.self, toVersion: MovieSchemav2.self, willMigrate: { context in
        guard let movies = try? context.fetch(FetchDescriptor<Movie>()) else { return }
        
        var duplicates = Set<Movie>()
        var uniqueSet = Set<String>()
        
        for movie in movies {
            if !uniqueSet.insert(movie.title).inserted {
                duplicates.insert(movie)
            }
        }
        
        for movie in duplicates {
            guard let movieTobeUpdated = movies.first(where: {$0.id == movie.id }) else {
                continue
            }
            
            movieTobeUpdated.title = movieTobeUpdated.title + "\(UUID().uuidString)"
        }
        
        try? context.save()
        
    }, didMigrate: nil)
    
    
}
