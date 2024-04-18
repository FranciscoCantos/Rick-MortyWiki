import Foundation

struct CharacterDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: String
    let location: String
    let imageURL: String
    let episodes: [String]
    let created: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, url, created, type, status, species, gender, location, origin
        case episodes = "episode"
        case imageURL = "image"
    }
    
    init(id: Int, name: String, url: String, status: String, species: String, type: String, gender: String, origin: String, location: String, imageURL: String, episodes: [String], created: String) {
        self.id = id
        self.name = name
        self.url = url
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.imageURL = imageURL
        self.episodes = episodes
        self.created = created
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(species, forKey: .species)
        try container.encode(type, forKey: .type)
        try container.encode(gender, forKey: .gender)
        try container.encode(origin, forKey: .origin)
        try container.encode(location, forKey: .location)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(episodes, forKey: .episodes)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        type = try container.decode(String.self, forKey: .type)
        gender = try container.decode(String.self, forKey: .gender)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        episodes = try container.decode([String].self, forKey: .episodes)
        url = try container.decode(String.self, forKey: .url)
        created = try container.decode(String.self, forKey: .created)
        
        let originContainer = try container.decode(ValueContainer.self, forKey: .origin)
        origin = originContainer.name
        
        let locationContainer = try container.decode(ValueContainer.self, forKey: .location)
        location = locationContainer.name
    }
}

struct ValueContainer: Codable {
    let name: String
    let url: String
}
