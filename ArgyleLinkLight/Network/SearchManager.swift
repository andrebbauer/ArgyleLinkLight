protocol SearchManagerProtocol {
    func search(for searchTerm: String, limit: String) async -> Result<[LinkItem], Error>
}

struct SearchManager: SearchManagerProtocol {
    let networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    func search(for searchTerm: String, limit: String) async -> Result<[LinkItem], Error> {
        let endpoint = SearchEndpoint.search(searchTerm: searchTerm, limit: limit)
        do {
            let response: LinkItemResponse = try await self.networkAPI.request(for: endpoint)
            return .success(response.results)
        } catch {
            return .failure(error)
        }
    }
}
