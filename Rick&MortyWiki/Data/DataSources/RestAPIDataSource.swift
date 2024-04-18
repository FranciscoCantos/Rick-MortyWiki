import Foundation

class RestAPIDataSource: APICharactersDataSourceProtocol {
    private let httpClient: HTTPClientProtocol
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    private var paginationInfo: PaginationInfo? = nil
        
    private enum Paths: String {
        case characters = "character"
        case character = "character/{characterId}"
    }
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getAllCharacters() async -> Result<[CharacterDTO], HTTPClientError> {
        let request = HTTPRequest(baseURL: baseURL,
                                  path: Paths.characters.rawValue,
                                  method: .get,
                                  queryParams: paginationInfo?.queryParams)
        
        let result = await httpClient.makeRequest(request)
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let charactersResponse = try? JSONDecoder().decode(CharactersResponseDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        
        paginationInfo = charactersResponse.info
        
        if charactersResponse.results.isEmpty {
            return .failure(.badURL)
        }
        
        return .success(charactersResponse.results)
    }
    
    func getCharacter(forId id: Int) async -> Result<CharacterDTO, HTTPClientError> {
        let request = HTTPRequest(baseURL: baseURL,
                                  path: Paths.character.rawValue.replacingOccurrences(of: "{characterId}", with: "\(id)"),
                                  method: .get)
        let result = await httpClient.makeRequest(request)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let characters = try? JSONDecoder().decode(CharacterDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(characters)
    }
    
    func searchCharacter(forName name: String) async -> Result<[CharacterDTO], HTTPClientError> {
        var nextPage: String?
        var resultCharacters: [CharacterDTO] = []

        var queryParams: [String: String] = [:]
        queryParams["name"] = name

        
        func makeSearchRequest(_ queryParams: [String: String]) async -> Result<[CharacterDTO], HTTPClientError> {
            print("-->> makeSearchRequest : \(queryParams)")
            let request = HTTPRequest(baseURL: baseURL,
                                      path: Paths.characters.rawValue,
                                      method: .get,
                                      queryParams: queryParams)
            
            let result = await httpClient.makeRequest(request)
            guard case .success(let data) = result else {
                return .failure(handleError(error: result.failureValue as? HTTPClientError))
            }
            
            guard let charactersResponse = try? JSONDecoder().decode(CharactersResponseDTO.self, from: data) else {
                return .failure(.parsingError)
            }
            
            nextPage = charactersResponse.info.queryParams["page"]
            return .success(charactersResponse.results)
        }
                        
        repeat {
            
            if let nextPage {
                queryParams["page"] = nextPage
            }
            
            let result = await makeSearchRequest(queryParams)
            
            guard case .success(let info) = result else {
                return .failure(handleError(error: result.failureValue as? HTTPClientError))
            }
            
            resultCharacters.append(contentsOf: info)

        } while nextPage != nil
        
        return .success(resultCharacters)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        return error
    }
}
