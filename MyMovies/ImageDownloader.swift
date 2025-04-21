//
//  ImageDownloader.swift
//
//
import SwiftUI
import Combine

class ImageCache: ObservableObject {
    private let cache = NSCache<NSString, UIImage>()
    
    static let shared = ImageCache()
    
    func getImage(for url: String) -> UIImage? {
        return cache.object(forKey: url as NSString)
    }
    
    func setImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
}

struct AsyncImageView: View {
    @State private var image: UIImage?
    @State private var isLoading = true
    let urlString: String
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text("Failed to load image")
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        // Check the cache first
        if let cachedImage = ImageCache.shared.getImage(for: urlString) {
            self.image = cachedImage
            self.isLoading = false
        } else {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    // Cache the image
                    ImageCache.shared.setImage(downloadedImage, for: urlString)
                    self.image = downloadedImage
                }
                self.isLoading = false
            }
        }.resume()
    }
}
