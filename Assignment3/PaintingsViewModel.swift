//
//  PaintingsViewModel.swift
//  Assignment3
//
//  Created by John Sims on 3/30/24.
//

import Foundation

class PaintingsViewModel: ObservableObject {
    @Published var paintingsData: [PaintingResults] = []
    @Published var errorMessage: String?

    private let searchURL = "https://collectionapi.metmuseum.org/public/collection/v1/search?q=flowers&departmentId=11"

    init() {
        fetchObjectIDs()
    }

    func fetchObjectIDs() {
        guard let url = URL(string: searchURL) else {
            errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }

                if let response = try? JSONDecoder().decode(SearchResults.self, from: data) {
                    let objectIDs = response.objectIDs
                    self?.fetchDetailsForObjects(objectIDs: Array(objectIDs))
                } else {
                    self?.errorMessage = "Data decoding error"
                }
            }
        }.resume()
    }

    func fetchDetailsForObjects(objectIDs: [Int]) {
        for id in objectIDs {
            let detailURL = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(id)"
            
            guard let url = URL(string: detailURL) else { continue }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.errorMessage = "Network error: \(error.localizedDescription)"
                        return
                    }

                    guard let data = data else {
                        self?.errorMessage = "No data received for object ID \(id)"
                        return
                    }

                    if let paintingDetails = try? JSONDecoder().decode(PaintingResults.self, from: data) {
                        self?.paintingsData.append(paintingDetails)
                    } else {
                        self?.errorMessage = "Data decoding error for object ID \(id)"
                    }
                }
            }.resume()
        }
    }
}
