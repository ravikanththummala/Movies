//
//  String+Extensions.swift
//  Movies
//
//  Created by Ravikanth on 6/10/23.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}
