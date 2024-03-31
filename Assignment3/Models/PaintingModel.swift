//
//  PaintingModel.swift
//  Assignment3
//
//  Created by John Sims on 3/30/24.
//

import Foundation

struct PaintingResults: Codable, Identifiable {
    let objectID: Int
    let primaryImage: String
    let constituents: [NameModel]
    let title: String
    let objectDate: String
    let artistDisplayBio: String
    var id: Int { objectID }
}

struct NameModel: Codable {
    let name: String
}

struct SearchResults: Codable {
    let total: Int
    let objectIDs: [Int]
}
