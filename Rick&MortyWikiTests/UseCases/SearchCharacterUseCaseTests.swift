import XCTest
@testable import Rick_MortyWiki

final class SearchCharacterUseCaseTests: XCTestCase {
    
    func test_execute_successfully_returns_notEmpty_array_when_repository_returns_notEmpty_array() async throws {
        let mockArray = CharacterInfo.getMocks()
        let result: Result<[CharacterInfo],DomainError> = .success(mockArray)
        
        let repositoryStub = CharactersRepositoryStub(result: result)
        let sut = SearchCharacterUseCase(repository: repositoryStub)
        
        let capturedResult = await sut.execute(characterName: "")
        
        let capturedCharactersResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCharactersResult, mockArray)
    }
    
    func test_execute_successfully_returns_empty_array_when_repository_returns_empty_array() async throws {
        let result: Result<[CharacterInfo],DomainError> = .success([])
        
        let repositoryStub = CharactersRepositoryStub(result: result)
        let sut = SearchCharacterUseCase(repository: repositoryStub)
        
        let capturedResult = await sut.execute(characterName: "")
        
        let capturedCharactersResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCharactersResult, [])
    }
    
    func test_execute_returns_error_when_repository_returns_error() async throws {
        let result: Result<[CharacterInfo],DomainError> = .failure(.emptyResponse)
        
        let repositoryStub = CharactersRepositoryStub(result: result)
        let sut = SearchCharacterUseCase(repository: repositoryStub)
        
        let capturedResult = await sut.execute(characterName: "")
        
        XCTAssertEqual(capturedResult, result)
    }
}
