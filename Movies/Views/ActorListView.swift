//
//  ActorListView.swift
//  Movies
//
//  Created by Ravikanth  on 10/7/23.
//

import SwiftUI

struct ActorListView: View {
    let actors:[Actor]
    
    var body: some View {
        List(actors){ actor in
            Text(actor.name)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
