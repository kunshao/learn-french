//
//  ContentView.swift
//  learn-french
//
//  Created by Kun Shao on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var articleService = ArticleService()
    @StateObject private var translationService = TranslationService()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Compact Header
                VStack(spacing: 4) {
                    HStack {
                        Image(systemName: "book.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                        
                        Text("Learn French")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            Task {
                                await articleService.generateNewArticle()
                            }
                        }) {
                            Image(systemName: "wand.and.stars")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(articleService.isLoading ? Color.gray : Color.blue)
                                .cornerRadius(8)
                        }
                        .disabled(articleService.isLoading)
                    }
                    
                    Text("A2 Level Articles")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 4)
                
                // Article Display - Maximized
                if articleService.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("Generating your French article...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let article = articleService.currentArticle {
                    VStack(alignment: .leading, spacing: 0) {
                        // Title - Compact
                        Text(article.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)
                        
                        // Content - Maximized
                        DuoStyleReader(
                            text: article.content,
                            translate: { word in
                                await translationService.translate(word)
                            }
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(Color(.systemBackground))
                } else {
                    // Empty State
                    VStack(spacing: 16) {
                        Image(systemName: "text.book.closed")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Article Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Tap the button above to generate your first French A2 article")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationBarHidden(true)
        }
        .alert("Error", isPresented: .constant(articleService.errorMessage != nil)) {
            Button("OK") {
                articleService.errorMessage = nil
            }
        } message: {
            Text(articleService.errorMessage ?? "")
        }
    }
}

#Preview {
    ContentView()
}
