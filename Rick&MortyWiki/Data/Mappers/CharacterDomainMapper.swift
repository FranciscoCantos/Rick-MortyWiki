import Foundation
import RickMortySwiftApi

class CharacterDomainMapper {
    func map(apiModels: [RMCharacterModel]) -> [CharacterDTO] {
        let mappedModels = apiModels.map {
            return CharacterDTO(id: $0.id,
                                name: $0.name,
                                url: $0.url,
                                status: $0.status,
                                species: $0.species,
                                type: $0.type,
                                gender: $0.gender,
                                origin: $0.origin.name,
                                location: $0.location.name,
                                imageURL: $0.image,
                                episodes: $0.episode,
                                created: $0.created)
        }
        return mappedModels
    }
}
