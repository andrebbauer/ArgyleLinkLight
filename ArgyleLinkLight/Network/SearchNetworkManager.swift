protocol SearchManagerProtocol {
    func search(for searchTerm: String, limit: String) async -> Result<[LinkItem], Error>
}

struct SearchNetworkManager: SearchManagerProtocol {

    let engine: Engine

    init(engine: Engine) {
        self.engine = engine
    }

    func search(for searchTerm: String, limit: String) async -> Result<[LinkItem], Error> {
        let endpoint = SearchEndpoint.search(searchTerm: searchTerm, limit: limit)
        do {
            let response: LinkItemResponse = try await engine.request(for: endpoint)
            return .success(response.results)
        } catch {
            return .failure(error)
        }
    }
}
