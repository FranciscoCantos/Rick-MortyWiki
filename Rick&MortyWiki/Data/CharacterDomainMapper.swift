import Foundation
import RickMortySwiftApi

class CharacterDomainMapper {
    func map(apiModels: [RMCharacterModel]) -> [CharacterDTO] {
        let mappedModels = apiModels.map {
            return CharacterDTO(id: $0.id,
                                name: $0.name,
                                url: $0.url,
                                image: $0.image,
                                status: CharacterStatus(rawValue: $0.status) ?? .unknown,
                                species: $0.species)
        }
        return mappedModels
    }
}
