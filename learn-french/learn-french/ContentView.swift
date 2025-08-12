//
//  ContentView.swift
//  learn-french
//
//  Created by Kun Shao on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var articleService = ArticleService()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "book.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                    
                    Text("Learn French")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("A2 Level Articles")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Article Display
                if articleService.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("Generating your French article...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                } else if let article = articleService.currentArticle {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Title
                            Text(article.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            // Content
                            Text(article.content)
                                .font(.body)
                                .lineSpacing(6)
                                .foregroundColor(.primary)
                            
                            // Vocabulary Notes
                            if !article.vocabularyNotes.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Vocabulary Notes")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                    
                                    Text(article.vocabularyNotes)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .padding()
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                            
                            // Timestamp
                            Text("Generated: \(article.formattedDate)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                } else {
                    // Empty State
                    VStack(spacing: 16) {
                        Image(systemName: "text.book.closed")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Article Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Tap the button below to generate your first French A2 article")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                
                Spacer()
                
                // Generate Button
                Button(action: {
                    Task {
                        await articleService.generateNewArticle()
                    }
                }) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                        Text("Generate New Article")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(articleService.isLoading ? Color.gray : Color.blue)
                    .cornerRadius(12)
                }
                .disabled(articleService.isLoading)
                .padding(.horizontal)
                .padding(.bottom, 20)
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
