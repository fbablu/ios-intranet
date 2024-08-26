

import SwiftUI
import SwiftData
import Foundation
struct ContentView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView (selection: $selection) {
            News()
            Home()
            Events()
            
        }
    }
}
    
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
