//
//  ActorCellView.swift
//  Movies
//
//  Created by Ravikanth  on 10/7/23.
//

import SwiftUI

struct ActorCellView: View {
    
    let actor:Actor
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(actor.name)
            Text(actor.movies.map{$0.title },format: .list(type: .and))
                .font(.caption)
        }
    }
}
