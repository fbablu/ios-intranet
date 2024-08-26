import Foundation

class PeopleLoader {
    static func loadPeopleFromJSON() -> [Person] {
        guard let url = Bundle.main.url(forResource: "SamplePeople", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load SamplePeople.json")
            return []
        }
        
        do {
            let people = try JSONDecoder().decode([Person].self, from: data)
            return people
        } catch {
            print("Failed to decode SamplePeople.json: \(error)")
            return []
        }
    }
}
