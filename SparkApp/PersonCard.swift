// PersonCard.swift

import SwiftUI

struct PersonCard: View {
    let person: Person
    
    var body: some View {
        Button(action: {
            if let url = URL(string: person.url) {
                UIApplication.shared.open(url)
            }
        }) {
            VStack {
                AsyncImage(url: URL(string: person.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                
                Text(person.name)
                    .font(.caption)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text(person.position)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 120, height: 150)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
