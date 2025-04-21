//
//  MovieDetailView.swift
//  MyMovies
//
//  Created by Durgesh Mathur on 21/04/25.
//


import SwiftUI

struct MovieDetailView: View {
    let movieID: Int
    @StateObject private var viewModel = MovieDetailViewModel()

    var body: some View {
        ScrollView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if let movie = viewModel.movie {
                    VStack(alignment: .leading, spacing: 16) {
                        if let posterURL = movie.posterURL {
                            AsyncImageView(urlString: posterURL.absoluteString)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                        }

                        Text(movie.title ?? "")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Release Date: \(movie.releaseDate ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text(movie.overview ?? "")
                            .font(.body)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchMovieDetails(id: movieID)
        }
    }
}
