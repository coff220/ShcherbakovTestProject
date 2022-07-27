//
//  PostRequest.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 21.07.2022.
//

import Foundation


struct PostDetailsRepsonse: Decodable { // Decodable parse JSON to object
    var post: PostDetails?
    
    enum CodingKeys: String, CodingKey {
        case post
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.post = try? container.decodeIfPresent(PostDetails.self, forKey: .post)
    }
}

struct PostDetails: Decodable {
    var title: String
    var subtitle: String
    var like: Int
    var id: Int
    var date: Double
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case id = "postId"
        case subtitle = "text"
        case like = "likes_count"
        case date = "timeshamp"
        case url = "postImage"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.like = try container.decode(Int.self, forKey: .like)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
        self.title = try container.decode(String.self, forKey: .title)
        self.date = try container.decode(Double.self, forKey: .date)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
