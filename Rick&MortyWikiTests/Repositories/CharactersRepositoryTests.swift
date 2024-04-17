import XCTest
@testable import Rick_MortyWiki

final class CharactersRepositoryTests: XCTestCase {
    
    func test_getAllCharactersList_returns_success() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success(CharacterDTO.getMocks()),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.getAllCharactersList()
        
        let charactersList = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterDTO.getMocks().map { CharacterInfo(dto: $0) }
        
        XCTAssertEqual(charactersList, charactersListDomain)
    }
    
    func test_getAllCharactersList_returns_cache_when_cached() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success([]),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: CharacterInfo.getMocks())
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.getAllCharactersList()
        
        let charactersList = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterInfo.getMocks()
        
        XCTAssertEqual(charactersList, charactersListDomain)
    }
    
    func test_getAllCharactersList_returns_error_when_empty() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success([]),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.getAllCharactersList()
        
        guard case .failure(let error) = result else {
            XCTFail("Expected failure")
            return
        }
        
        XCTAssertEqual(error, .emptyResponse)
    }
    
    func test_getAllCharactersList_returns_error_when_failure() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .failure(.generic),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.getAllCharactersList()
        
        guard case .failure(let error) = result else {
            XCTFail("Expected failure")
            return
        }
        
        XCTAssertEqual(error, .generic)
    }
    
    func test_searchCharacter_returns_searchedCharacter() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success(CharacterDTO.getMocks()),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.searchCharacter(byName: "000")
        
        let searchedCaracter = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterDTO.getMocks().map { CharacterInfo(dto: $0) }.filter { $0.name.contains("000") }
        
        XCTAssertEqual(searchedCaracter, charactersListDomain)
    }
    
    func test_searchCharacter_returns_failure_when_failure() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .failure(.generic),
                                                            characterResult: .failure(.generic))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.searchCharacter(byName: "000")
        
        guard case .failure(let error) = result else {
            XCTFail("Expected failure")
            return
        }
        
        XCTAssertEqual(error, .generic)
    }
    
    func test_searchCharacter_returns_empty_whenNotFound() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success(CharacterDTO.getMocks()),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.searchCharacter(byName: "1000")
        
        let searchedCaracter = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterDTO.getMocks().map { CharacterInfo(dto: $0) }.filter { $0.name.contains("1000") }
        
        XCTAssertEqual(searchedCaracter, charactersListDomain)
    }
    
    func test_searchCharacter_returns_allCharacter_whenNoSearch() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success(CharacterDTO.getMocks()),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharactersRepository(apiDataSource: apiDataSourceStub,
                                       cacheDataSource: cacheDataSource)
        
        let result = await sut.searchCharacter(byName: "")
        
        let charactersList = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterDTO.getMocks().map { CharacterInfo(dto: $0) }
        
        XCTAssertEqual(charactersList, charactersListDomain)
    }
}


