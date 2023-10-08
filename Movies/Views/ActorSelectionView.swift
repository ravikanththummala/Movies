//
//  ActorSelectionView.swift
//  Movies
//
//  Created by Ravikanth  on 10/7/23.
//

import SwiftUI
import SwiftData

struct ActorSelectionView: View {
    
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    @Binding var selectedActor:Set<Actor>
    
    var body: some View {
        List(actors){ actor in
            HStack {
                Image(systemName: selectedActor.contains(actor) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectedActor.contains(actor){
                            selectedActor.insert(actor)
                        }else{
                            selectedActor.remove(actor)
                        }
                    }
                Text(actor.name)
            }
        }
    }
}

//#Preview {
//    ActorSelectionView()
//        
//}
