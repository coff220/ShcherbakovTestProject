//
//  ViewControllerPresenter.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 20.07.2022.
//

import Foundation

protocol PostsPresenterProtocol {
    func viewDidLoad()
    func countItems() -> Int
    func itemAt(_ index: Int) -> Post
    var view: PostsViewControllerProtocol? { set get }
    func pressedSort()
}

class PostsPresenter: PostsPresenterProtocol {
    private var posts: [Post] = []
    private let postRequest: PostRequestProtocol = PostRequest()
    private var ascending = false
    weak var view: PostsViewControllerProtocol?
    
    func viewDidLoad() {
        postRequest.getPosts { posts in
            self.posts = posts ?? []
            self.view?.reloadData()
        }
    }
    
    func countItems() -> Int {
        posts.count
    }
    
    func itemAt(_ index: Int) -> Post {
        posts[index]
    }
    
    func pressedSort() {
        ascending.toggle()
        posts = posts.sorted(by: { ascending ? $0.date > $1.date : $0.date < $1.date })
        view?.reloadData()
    }
}
