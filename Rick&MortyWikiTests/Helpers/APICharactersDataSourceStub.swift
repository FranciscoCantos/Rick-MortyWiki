import Foundation
@testable import Rick_MortyWiki

class APICharactersDataSourceStub: APICharactersDataSourceProtocol {
    private let charactersResult: Result<[CharacterDTO], HTTPClientError>
    private let characterResult: Result<CharacterDTO, HTTPClientError>
    
    init(charactersResult: Result<[CharacterDTO], HTTPClientError>, characterResult: Result<CharacterDTO, HTTPClientError>) {
        self.charactersResult = charactersResult
        self.characterResult = characterResult
    }
                                    
    func getAllCharacters() async -> Result<[CharacterDTO], HTTPClientError> {
        return charactersResult
    }
    
    func getCharacter(forId: Int) async -> Result<CharacterDTO, HTTPClientError> {
        return characterResult
    }
}
