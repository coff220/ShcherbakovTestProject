//
//  PostRequest.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 21.07.2022.
//

import UIKit
import Kingfisher

protocol PostViewControllerProtocol: AnyObject {
    func showImage(_ url: String)
    func update(_ title: String)
    func updateDescription(_ description: String)
    func updateDate(_ date: String)
    func updateLikes(_ likes: String)
}

class PostViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var presenter: PostPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension PostViewController: PostViewControllerProtocol {
    func showImage(_ url: String) {
        image.kf.setImage(with: URL(string: url))
    }
    
    func update(_ title: String) {
        titleLabel.text = title
    }
    
    func updateDescription(_ description: String) {
        textLabel.text = description
    }
    
    func updateDate(_ date: String) {
        dateLabel.text = date
    }
    
    func updateLikes(_ likes: String) {
        likesLabel.text = likes
    }
}
