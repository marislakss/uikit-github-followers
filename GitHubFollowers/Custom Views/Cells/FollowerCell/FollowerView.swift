//
//  FollowerView.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 18/04/2024.
//

import SwiftUI

// MARK: - FollowerView Struct

// FollowerView is a struct conforming to the View protocol,
// it's a custom view used for displaying follower data.
struct FollowerView: View {

    // MARK: - Properties

    // The Follower data model containing user details
    var follower: Follower

    // MARK: - Body

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(.avatarPlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(Circle())

            Text(follower.login)
                .bold()
                .font(.system(size: 14))
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

// MARK: - Canvas Preview

// Preview provider to visualize the view in SwiftUI's preview canvas
#Preview {
    FollowerView(follower: Follower(login: "Username", avatarUrl: ""))
}
