import SwiftUI

struct ContentView: View {
    @StateObject private var articleManager = ArticleManager()
    @State private var showingVocabulary = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let article = articleManager.currentArticle {
                        // Header
                        VStack(spacing: 10) {
                            Text("Niveau A2")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(12)
                            
                            Text(article.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top)
                        
                        // Article content
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Article")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(article.content)
                                .font(.body)
                                .lineSpacing(6)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        // Vocabulary section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Vocabulaire")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        showingVocabulary.toggle()
                                    }
                                }) {
                                    HStack {
                                        Text(showingVocabulary ? "Masquer" : "Afficher")
                                        Image(systemName: showingVocabulary ? "eye.slash" : "eye")
                                    }
                                    .font(.caption)
                                    .foregroundColor(.blue)
                                }
                            }
                            
                            if showingVocabulary {
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 12) {
                                    ForEach(Array(article.vocabulary.keys.sorted()), id: \.self) { word in
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(word)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                            Text(article.vocabulary[word] ?? "")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Next article button
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                articleManager.getRandomArticle()
                                showingVocabulary = false
                            }
                        }) {
                            HStack {
                                Image(systemName: "shuffle")
                                Text("Article Suivant")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                    } else {
                        // Loading state
                        VStack(spacing: 20) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Chargement...")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .navigationTitle("Apprendre le Français")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    ContentView()
} 