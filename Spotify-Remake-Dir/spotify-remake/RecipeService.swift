import Foundation

class RecipeService {
    private let baseURL = "https://dummyjson.com/recipes/search"

    func searchRecipes(query: String) async throws -> RecipeSearchResponse {
        guard let url = URL(string: "\(baseURL)?q=\(query)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
    }
}
