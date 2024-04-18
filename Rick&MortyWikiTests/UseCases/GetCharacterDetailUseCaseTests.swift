import XCTest
@testable import Rick_MortyWiki

final class GetCharacterDetailUseCaseTests: XCTestCase {
    
    func test_execute_successfully_returns_character_when_repository_returns_character() async throws {
        let mock = CharacterInfo.getMocks().first!
        let result: Result<CharacterInfo, DomainError> = .success(mock)
        
        let repositoryStub = CharacterDetailRepositoryStub(result: result)
        let sut = GetCharacterDetailUseCase(repository: repositoryStub)
        
        let capturedResult = await sut.execute(forId: 0)
        
        let capturedCharactersResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCharactersResult, mock)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async throws {
        let result: Result<CharacterInfo, DomainError> = .failure(.idNotFound)
        
        let repositoryStub = CharacterDetailRepositoryStub(result: result)
        let sut = GetCharacterDetailUseCase(repository: repositoryStub)
        
        let capturedResult = await sut.execute(forId: 0)
        
        XCTAssertEqual(capturedResult, result)
    }
}
