import XCTest
@testable import Rick_MortyWiki

final class CharacterDetailRepositoryTests: XCTestCase {
    
    func test_getAllCharactersList_returns_success_when_find_id() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success(CharacterDTO.getMocks()),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharacterDetailRepository(apiDataSource: apiDataSourceStub,
                                            cacheDataSource: cacheDataSource)
        
        let result = await sut.getCharacterDetail(forId: 0)
        
        let charactersList = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterDTO.getMocks().map { CharacterInfo(dto: $0) }.first!
        
        XCTAssertEqual(charactersList, charactersListDomain)
    }
    
    func test_getAllCharactersList_returns_success_when_find_id_inCache() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success([]),
                                                            characterResult: .failure(.generic))
        let cacheDataSource = CharactersCacheDataSourceStub(result: CharacterInfo.getMocks())
        
        let sut = CharacterDetailRepository(apiDataSource: apiDataSourceStub,
                                            cacheDataSource: cacheDataSource)
        
        let result = await sut.getCharacterDetail(forId: 0)
        
        let charactersList = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterDTO.getMocks().map { CharacterInfo(dto: $0) }.first!
        
        XCTAssertEqual(charactersList.id, charactersListDomain.id)
    }
    
    func test_getAllCharactersList_returns_failure_when_dont_find_id() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success(CharacterDTO.getMocks()),
                                                            characterResult: .success(CharacterDTO.getMocks().last!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharacterDetailRepository(apiDataSource: apiDataSourceStub,
                                            cacheDataSource: cacheDataSource)
        
        let result = await sut.getCharacterDetail(forId: 12)
        
        guard case .failure(let error) = result else {
            XCTFail("Expected failure")
            return
        }
        
        XCTAssertEqual(error, .idNotFound)
    }
    
    func test_getAllCharactersList_returns_failure_when_dataSource_failure() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success(CharacterDTO.getMocks()),
                                                            characterResult: .failure(.generic))
        let cacheDataSource = CharactersCacheDataSourceStub(result: [])
        
        let sut = CharacterDetailRepository(apiDataSource: apiDataSourceStub,
                                            cacheDataSource: cacheDataSource)
        
        let result = await sut.getCharacterDetail(forId: 12)
        
        guard case .failure(let error) = result else {
            XCTFail("Expected failure")
            return
        }
        
        XCTAssertEqual(error, .idNotFound)
    }
    
    func test_getAllCharactersList_returns_cache_when_cached() async throws {
        let apiDataSourceStub = APICharactersDataSourceStub(charactersResult: .success([]),
                                                            characterResult: .success(CharacterDTO.getMocks().first!))
        let cacheDataSource = CharactersCacheDataSourceStub(result: CharacterInfo.getMocks())
        
        let sut = CharacterDetailRepository(apiDataSource: apiDataSourceStub,
                                            cacheDataSource: cacheDataSource)
        
        let result = await sut.getCharacterDetail(forId: 0)
        
        let charactersList = try XCTUnwrap(result.get())
        let charactersListDomain = CharacterInfo.getMocks().first!
        
        XCTAssertEqual(charactersList, charactersListDomain)
    }
}
