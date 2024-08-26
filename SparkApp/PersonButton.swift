import SwiftUI

struct PersonButton: View {
    let person: Person

    var body: some View {
        Button(action: {
            // Handle person action, e.g., open URL
            if let url = URL(string: person.url) {
                UIApplication.shared.open(url)
            }
        }) {
            VStack {
                if let imageURL = URL(string: person.imageURL) {
                    AsyncImageView(url: imageURL)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                Text(person.name)
                    .font(.caption)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}
