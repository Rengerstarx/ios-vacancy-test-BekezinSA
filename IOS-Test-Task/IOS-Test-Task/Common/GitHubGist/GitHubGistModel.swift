//
//  GitHubGistModel.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import Foundation

struct GitHubGist: Codable {
    let url: String
    let forksURL: String
    let commitsURL: String
    let id: String
    let nodeID: String
    let gitPullURL: String
    let gitPushURL: String
    let htmlURL: String
    let files: [String: GistFile]
    let isPublic: Bool
    let createdAt: String
    let updatedAt: String
    let description: String?
    let comments: Int
    let user: GistUser?
    let commentsURL: String
    let owner: GistUser?
    let truncated: Bool?
    let forks: [String]?
    let history: [String]?
    
    enum CodingKeys: String, CodingKey {
        case url
        case forksURL = "forks_url"
        case commitsURL = "commits_url"
        case id
        case nodeID = "node_id"
        case gitPullURL = "git_pull_url"
        case gitPushURL = "git_push_url"
        case htmlURL = "html_url"
        case files
        case isPublic = "public"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
        case comments
        case user
        case commentsURL = "comments_url"
        case owner
        case truncated
        case forks
        case history
    }
}

struct GistFile: Codable {
    let filename: String
    let type: String
    let language: String?
    let rawURL: String
    let size: Int
    
    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case language
        case rawURL = "raw_url"
        case size
    }
}

struct GistUser: Codable {
    let name: String?
    let email: String?
    let login: String
    let id: Int64
    let nodeID: String
    let avatarURL: String
    let gravatarID: String?
    let url: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
    let starredAt: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case starredAt = "starred_at"
    }
}
