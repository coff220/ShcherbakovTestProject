//
//  PostRequest.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 21.07.2022.
//

import Foundation

protocol PostRequestProtocol {
    func getPosts(completion: @escaping ([Post]?) -> Void)
    func getPostBy(id: Int, completion: @escaping (PostDetails?) -> Void)
}

struct PostRequest: PostRequestProtocol {
    func getPosts(completion: @escaping ([Post]?) -> Void) {
        guard let url = URL.init(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json")
        else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type") // просим сервер вернуть json
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            let posts: PostsRepsonse? = try? JSONDecoder().decode(PostsRepsonse.self, from: data!)
       
            completion(posts?.posts)
        }.resume()
    }
    
    func getPostBy(id: Int, completion: @escaping (PostDetails?) -> Void) {
        guard let url = URL.init(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json")
        else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type") // просим сервер вернуть json
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            let post: PostDetailsRepsonse? = try? JSONDecoder().decode(PostDetailsRepsonse.self, from: data!)
       
            completion(post?.post)
        }.resume()
    }
}
