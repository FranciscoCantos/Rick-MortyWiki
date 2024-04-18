import Foundation

protocol APICharactersDataSourceProtocol {
    func getAllCharacters() async -> Result<[CharacterDTO], HTTPClientError>
    func getCharacter(forId: Int) async -> Result<CharacterDTO, HTTPClientError>
    func searchCharacter(forName: String) async -> Result<[CharacterDTO], HTTPClientError>
}
