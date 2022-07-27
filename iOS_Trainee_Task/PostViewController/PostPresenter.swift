//
//  PostRequest.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 21.07.2022.
//


import Foundation

protocol PostPresenterProtocol {
    func viewDidLoad()
    var view: PostViewControllerProtocol? { get set }
}

struct PostPresenter: PostPresenterProtocol {
    weak var view: PostViewControllerProtocol?
    private var postId: Int = 0
    private let postRequest: PostRequestProtocol = PostRequest()
    
    init(postID: Int) {
        self.postId = postID
    }
    
    func viewDidLoad() {
        postRequest.getPostBy(id: postId) { post in
            DispatchQueue.main.async {
                guard let post = post else { return }
                self.view?.showImage(post.url)
                self.view?.update(post.title)
                self.view?.updateDescription(post.subtitle)
                self.view?.updateLikes("\(post.like)")
                
                let milisecond = post.date
                let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)/1000)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                
                self.view?.updateDate(dateFormatter.string(from: dateVar))
            }
        }
    }
}
