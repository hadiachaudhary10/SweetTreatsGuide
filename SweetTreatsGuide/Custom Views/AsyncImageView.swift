//
//  AsyncImageView.swift
//  SweetTreatsGuide
//
//  Created by Dev on 19/02/2024.
//

import SwiftUI

struct AsyncImageView: View {
    var url: String
    var body: some View {
        if let image = CacheImage.shared.checkIfImageIsCache(urlString: url) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            AsyncImage(url:  URL(string: url)) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .task {
                                CacheImage.shared.storeCacheImage(imageData: image, urlString: url)
                            }
                    case .failure:
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tint(Color.black)
                            .opacity(0.4)
                            .frame(width: 50, height: 50)
                    @unknown default:
                        Text("Unknown state")
                }
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: "")
    }
}
