//
//  FilterSelectScreen.swift
//  Movies
//
//  Created by Ravikanth  on 10/9/23.
//

import SwiftUI

enum FilterOption {
    
    case title(String)
    case reviewCounr(Int)
    case actorCount(Int)
    case none
    
}
struct FilterSelectionScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle:String = ""
    @State private var numberOfReview:Int?
    @State private var actorCount:Int?

    @Binding var filterOption: FilterOption
    
    var body: some View {
        Form{
            Section("Filter by title") {
                TextField("Movie title", text: $movieTitle)
                Button("Search"){
                    filterOption = .title(movieTitle)
                    dismiss()
                }
            }
            
            Section("Filter by number of reviews") {
                TextField("Review", value: $numberOfReview, format: .number)
                Button("Search"){
                    filterOption = .reviewCounr(numberOfReview ??  1)
                    dismiss()
                }
            }
            
            Section("Filter by number of actors") {
                TextField("Actor", value: $actorCount, format: .number)
                Button("Search"){
                    filterOption = .actorCount(actorCount ??  1)
                    dismiss()
                }
            }


        }
    }
}

#Preview {
    FilterSelectionScreen(filterOption: .constant(.title("Batman")))
}
