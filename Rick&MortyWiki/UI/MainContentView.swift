import SwiftUI
import SwiftData

struct MainContentView: View {
    private let charactersListView: CharactersListView
    
    init(charactersListView: CharactersListView) {
        self.charactersListView = charactersListView
    }
    
    var body: some View {
        charactersListView
    }
}
