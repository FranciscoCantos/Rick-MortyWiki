import Foundation

protocol CacheContainerProtocol {
    func fetchCharacters() -> [CharacterInfo]
    func insertCharaters(_ characters: [CharacterInfo]) async
}
