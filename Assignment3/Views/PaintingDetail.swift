//
//  PaintingDetail.swift
//  Assignment3
//
//  Created by John Sims on 3/30/24.
//

import SwiftUI

struct PaintingDetail: View {
    let title: String
    let artistName: String
    let imageUrl: String
    let artistBio: String
    let year: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(title)
                    .font(.title)
                if !year.isEmpty {
                    Text("Year: \(year)")
                        .font(.title2)
                }
                
                Text("Artist: \(artistName)")
                    .font(.title2)
                    .padding(.top)
                
                if !artistBio.isEmpty {
                    Text("Artist Bio: \(artistBio)")
                        .font(.title2)
                }
                
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
            }
            .padding()
        }
    }
}
