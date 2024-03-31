//
// ContentView.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct Paintings: View {
    
    @ObservedObject var paintingsvm = PaintingsViewModel()
    
    var body: some View {
        NavigationStack {
            if let errorMessage = paintingsvm.errorMessage {
                Text(errorMessage)
            } else {
                List(paintingsvm.paintingsData) { painting in
                    NavigationLink {
                        PaintingDetail(title: painting.title,
                                       artistName: painting.constituents.first?.name ?? "Unknown Artist",
                                       imageUrl: painting.primaryImage,
                                       artistBio: painting.artistDisplayBio,
                                       year: painting.objectDate)
                    } label: {
                        Text(painting.title)
                    }
                }
                .navigationTitle("European Paintings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Paintings()
    }
}
