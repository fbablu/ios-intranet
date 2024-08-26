import Foundation

struct : Codable {
    var name: String
    var email: String?
    var phone: String?
    var vCard: String?
    var position: String?
    var url: String
    var location: String?
}

func parsePerson(data: String) -> Person {
    let lines = data.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
    var person = Person(name: "", email: nil, phone: nil, vCard: nil, position: nil, url: "", location: nil)
    
    // Extract name
    if let nameParts = lines.first?.components(separatedBy: " ").dropFirst(), nameParts.count > 0 {
        person.name = nameParts.joined(separator: " ")
    }
    
    // Extract email
    if let emailMatch = data.range(of: #"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b"#, options: .regularExpression) {
        person.email = String(data[emailMatch])
    }
    
    // Extract phone
    if let phoneMatch = data.range(of: #"\+1 \d{3} \d{3} \d{4}"#, options: .regularExpression) {
        person.phone = String(data[phoneMatch])
    }
    
    // Extract vCard
    if let vCardMatch = data.range(of: #"vCard: (https://.*?\.vcf)"#, options: .regularExpression) {
        person.vCard = String(data[vCardMatch])
    } else if data.contains("vCard") {
        person.vCard = "Available"
    }
    
    // Extract position
    if let positionMatch = data.range(of: #"Position: (.+)"#, options: .regularExpression) {
        person.position = String(data[positionMatch]).components(separatedBy: ": ")[1]
    } else if let vCardPositionMatch = data.range(of: #"vCard (.+)"#, options: .regularExpression) {
        person.position = String(data[vCardPositionMatch]).components(separatedBy: "vCard ")[1]
    }
    
    // Extract URL
    if let urlMatch = data.range(of: #"Url: (https://.*)"#, options: .regularExpression) {
        person.url = String(data[urlMatch]).components(separatedBy: ": ")[1]
    } else {
        person.url = "https://www.jenner.com/en/people/\(person.name.lowercased().replacingOccurrences(of: " ", with: "-"))"
    }
    
    // Extract location
    if let locationMatch = data.range(of: #"(New York|Chicago|Washington, DC|Los Angeles|London)"#, options: .regularExpression) {
        person.location = String(data[locationMatch])
    }
    
    return person
}

func processData(_ data: String) -> [Person] {
    let peopleData = data.components(separatedBy: "518 results").dropFirst()
    return peopleData.map { parsePerson(data: $0) }
}


func main() {
    // Sample data (you would replace this with your full dataset)
    let sampleData = """
    518 results Christopher J. Abbott Christopher J. Abbott christopher.abbott@jenner.com +1 202 639 6877 vCard: https://www.jenner.com/en/people/christopher-j-abbott/vcard.vcf Position: Partner Url: https://www.jenner.com/en/people/christopher-j-abbott
    Washington, DC Jacob D. Alderdice Jacob D. Alderdice jalderdice@jenner.com +1 212 891 1625 vCard: https://www.jenner.com/en/people/jacob-d-alderdice/vcard.vcf Position: Partner Url: https://www.jenner.com/en/people/jacob-d-alderdice
    New York Angela Allen Angela Allen aallen@jenner.com +1 312 840 7218 vCard Partner
    Chicago Nicole Allen Nicole Allen nallen@jenner.com +1 312 923 2868 vCard Partner
    Chicago
    """

    // Process the data
    let people = processData(sampleData)

    // Convert to JSON
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted

    do {
        let jsonData = try jsonEncoder.encode(people)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    } catch {
        print("Error encoding JSON: \(error)")
    }
}

// Call the main function

