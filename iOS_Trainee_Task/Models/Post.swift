//
//  Post.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 21.07.2022.
//

import Foundation

struct PostsRepsonse: Decodable { // Decodable parse JSON to object
    var posts: [Post]?
    
    enum CodingKeys: String, CodingKey {
        case posts
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posts = try? container.decodeIfPresent([Post].self, forKey: .posts)
    }
}

struct Post: Decodable {
    var title: String
    var subtitle: String
    var like: Int
    var id: Int
    var date: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case id = "postId"
        case subtitle = "preview_text"
        case like = "likes_count"
        case date = "timeshamp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.like = try container.decode(Int.self, forKey: .like)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
        self.title = try container.decode(String.self, forKey: .title)
        self.date = try container.decode(Double.self, forKey: .date)
    }
}
